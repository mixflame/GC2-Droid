require 'ruboto/widget'
require 'ruboto/util/toast'
require 'ruboto/activity'

java_import "android.content.pm.ActivityInfo"

ruboto_import_widgets :LinearLayout, :TextView, :ListView, :EditText

class GlobalChatActivity
  require 'global_chat_controller'

  def on_create(bundle)
    super
    set_title 'GlobalChat2'

    $activity.run_on_ui_thread do

      $gcc = GlobalChatController.new

      self.content_view =
      linear_layout :orientation => :vertical do
        linear_layout :layout => {:width= => :fill_parent, :height= => 310} do
          @nicks_table = list_view :list => $gcc.nicks, :layout => {:width= => 200, :height= => :fill_parent}
          @scroll_view = scroll_view(:layout => {:width= => :fill_parent, :height= => :fill_parent}) do
            @chat_window_text = text_view :text => '', :layout => {:width= => :fill_parent, :height= => :fill_parent}
          end

        end
        linear_layout :orientation => :vertical, :layout => {:width= => :fill_parent, :height= => 60} do
          @chat_message = edit_text :text => '', :layout => {:width= => :fill_parent}
        end
      end

      $gcc.host = $host
      $gcc.port = $port
      $gcc.handle = $handle
      $gcc.password = $password

      $gcc.nicks_table = @nicks_table
      $gcc.chat_window_text = @chat_window_text
      $gcc.chat_message = @chat_message
      $gcc.scroll_view = @scroll_view
      $gcc.nicks = []
      $gcc.chat_buffer = ""
      $gcc.sign_on

    end



    # go landscape
    setRequestedOrientation(0)

  end

  # end


end
