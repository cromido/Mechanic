defmodule Fuelpump.Messages do

  defmodule Attachment, do: defstruct [:type, :payload]
  defmodule Element, do: defstruct [:title, :image_url, :subtitle, :buttons]

  defstruct [:messages]

  alias Fuelpump.Messages

  def messages(), do: %Messages{messages: []}

  def add_text(m=%Messages{}, text) do
    %Messages{messages: m.messages ++ [%{text: text}]}
  end

  def add_attachment(m=%Messages{}, a=%Attachment{}) do
    %Messages{messages: m.messages ++ [%{attachment: a}]}
  end

  def add_image(m=%Messages{}, url), do: add_attachment(m, image url)
  def add_video(m=%Messages{}, url), do: add_attachment(m, video url)
  def add_audio(m=%Messages{}, url), do: add_attachment(m, audio url)

  defp image(url), do: url("image", url)
  defp video(url), do: url("video", url)
  defp audio(url), do: url("audio", url)

  defp url(type, url) do
    %Attachment{
      type: type,
      payload: %{url: url}
    }
  end

  def buttons(text) do
    %Attachment{
      type: "template",
      payload: %{
        template_type: "button",
        text: text,
        buttons: []
      }
    }
  end

  def add_show_block_button(x, title, block_name) do
    add_button(x, %{
      type: "show_block",
      block_name: block_name,
      title: title
    })
  end

  def add_web_url_button(x, title, url) do
    add_button(x, %{
      type: "web_url",
      url: url,
      title: title
    })
  end

  defp add_button(a=%Attachment{payload: %{template_type: "button"}}, button) do
    payload = %{ a.payload | buttons: a.payload.buttons ++ [button] }
    %Attachment{ a | payload: payload }
  end

  defp add_button(e=%Element{}, button) do
    %Element{ e | buttons: e.buttons ++ [button] }
  end

  def generic() do
    %Attachment{
      type: "template",
      payload: %{
        template_type: "generic",
        elements: []
      }
    }
  end

  def element(title, image_url, subtitle) do
    %Element{
      title: title,
      image_url: image_url,
      subtitle: subtitle,
      buttons: []
    }
  end

  def add_element(a=%Attachment{payload: %{"template_type" => "generic"}}, e=%Element{}) do
    payload = %{ a.payload | elements: a.payload.elements ++ [e] }
    %Attachment{ a | payload: payload  }
  end
end
