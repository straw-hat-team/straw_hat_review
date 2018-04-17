defmodule StrawHat.Review.Reactions do
  @moduledoc """
  Interactor module that defines all the functionality for Reactions management.
  """

  use StrawHat.Review.Interactor
  alias StrawHat.Response
  alias StrawHat.Review.Reaction

  @doc """
  Gets the list of reactions.
  """
  @since "1.0.0"
  @spec get_reactions(Scrivener.Config.t()) :: Scrivener.Page.t()
  def get_reactions(pagination \\ []), do: Repo.paginate(Reaction, pagination)

  @doc """
  Creates reaction.
  """
  @since "1.0.0"
  @spec create_reaction(Reaction.reaction_attrs()) ::
          {:ok, Reaction.t()} | {:error, Ecto.Changeset.t()}
  def create_reaction(reaction_attrs) do
    %Reaction{}
    |> Reaction.changeset(reaction_attrs)
    |> Repo.insert()
  end

  @doc """
  Updates reaction.
  """
  @since "1.0.0"
  @spec update_reaction(Reaction.t(), Reaction.reaction_attrs()) ::
          {:ok, Reaction.t()} | {:error, Ecto.Changeset.t()}
  def update_reaction(%Reaction{} = reaction, reaction_attrs) do
    reaction
    |> Reaction.changeset(reaction_attrs)
    |> Repo.update()
  end

  @doc """
  Destroys reaction.
  """
  @since "1.0.0"
  @spec destroy_reaction(Reaction.t()) :: {:ok, Reaction.t()} | {:error, Ecto.Changeset.t()}
  def destroy_reaction(%Reaction{} = reaction), do: Repo.delete(reaction)

  @doc """
  Finds reaction by `id`.
  """
  @since "1.0.0"
  @spec find_reaction(Integer.t()) :: {:ok, Reaction.t()} | {:error, Error.t()}
  def find_reaction(reaction_id) do
    reaction_id
    |> get_reaction()
    |> Response.from_value(
      Error.new(
        "straw_hat_review.reaction.not_found",
        metadata: [reaction_id: reaction_id]
      )
    )
  end

  @doc """
  Gets reaction by `id`.
  """
  @since "1.0.0"
  @spec get_reaction(Integer.t()) :: Reaction.t() | nil | no_return
  def get_reaction(reaction_id), do: Repo.get(Reaction, reaction_id)

  @doc """
  Gets list of reaction by ids.
  """
  @since "1.0.0"
  @spec reaction_by_ids([Integer.t()]) :: [Reaction.t()] | no_return
  def reaction_by_ids(reaction_ids) do
    query = from(reaction in Reaction, where: reaction.id in ^reaction_ids)

    Repo.all(query)
  end
end
