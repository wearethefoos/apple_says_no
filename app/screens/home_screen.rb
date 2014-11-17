class HomeScreen < PM::Screen
  include HomeStyles

  BASE_AUDIO_PATH = "#{NSBundle.mainBundle.resourcePath}/audio/"
  @@system_sounds = {}

  title "No"

  def will_appear
    @view_setup ||= self.set_up_view
  end

  def set_up_view
    set_attributes self.view, :home_view_style # found in HomeStyles module

    button = UIButton.buttonWithType UIButtonTypeRoundedRect
    button.setBackgroundImage UIImage.imageNamed('apple-no.png'), forState: UIControlStateNormal
    add button, :apple_button_style

    button.when(UIControlEventTouchUpInside) { say_no }

    true
  end

  def say_no
    p random_no
    SystemSounds.play random_no
  end

  def random_no
    @noes ||= Dir.glob("#{BASE_AUDIO_PATH}no*.wav")
    @noes.sample
  end

  def play(file_name)
    path = file_name if file_name.match(/^#{BASE_AUDIO_PATH}/)
    path ||= "#{BASE_AUDIO_PATH}#{file_name}"
    p path
    sound_id = find_or_create_sound_id(path)
    AudioServicesPlaySystemSound(sound_id[0])
  end

  def find_or_create_sound_id(file_name)
    unless sound_id = @@system_sounds[file_name]
      sound_id = Pointer.new('I')
      @@system_sounds[file_name] = sound_id
      AudioServicesCreateSystemSoundID(NSURL.fileURLWithPath(file_name), sound_id)
    end

    sound_id
  end
end
