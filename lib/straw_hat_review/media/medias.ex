defmodule StrawHat.Review.Medias do
  @moduledoc """
  Interactor module that defines all the functionality for Medias management.
  """

  use StrawHat.Review.Interactor

  alias StrawHat.Review.Media

  @doc """
  Get the list of medias.
  """
  @since "1.0.0"
  @spec get_medias(Scrivener.Config.t()) :: Scrivener.Page.t()
  def get_medias(pagination \\ []), do: Repo.paginate(Media, pagination)

  @doc """
  Create media.
  """
  @since "1.0.0"
  @spec create_media(Media.media_attrs()) ::
          {:ok, Media.t()} | {:error, Ecto.Changeset.t()}
  def create_media(media_attrs) do
    %Media{}
    |> Media.changeset(media_attrs)
    |> Repo.insert()
  end

  @doc """
  Update media.
  """
  @since "1.0.0"
  @spec update_media(Media.t(), Media.media_attrs()) ::
          {:ok, Media.t()} | {:error, Ecto.Changeset.t()}
  def update_media(%Media{} = media, media_attrs) do
    media
    |> Media.changeset(media_attrs)
    |> Repo.update()
  end

  @doc """
  Destroy media.
  """
  @since "1.0.0"
  @spec destroy_media(Media.t()) ::
          {:ok, Media.t()} | {:error, Ecto.Changeset.t()}
  def destroy_media(%Media{} = media), do: Repo.delete(media)

  @doc """
  Find media by `id`.
  """
  @since "1.0.0"
  @spec find_media(Integer.t()) :: {:ok, Media.t()} | {:error, Error.t()}
  def find_media(media_id) do
    case get_media(media_id) do
      nil ->
        error =
          Error.new(
            "straw_hat_review.media.not_found",
            metadata: [media_id: media_id]
          )

        {:error, error}

      media ->
        {:ok, media}
    end
  end

  @doc """
  Get media by `id`.
  """
  @since "1.0.0"
  @spec get_media(Integer.t()) :: Media.t() | nil | no_return
  def get_media(media_id), do: Repo.get(Media, media_id)
end