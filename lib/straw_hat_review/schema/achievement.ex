defmodule StrawHat.Review.Schema.Achievement do
  @moduledoc """
  Represents a Achievement Ecto Schema relation.
  """

  use StrawHat.Review.Schema
  alias StrawHat.Review.Schema.{AchievementBadge}

  @typedoc """
  - `owner_id`: The `owner_id` is a reference to achievement owner.
  - `achievement_badge`: `t:StrawHat.Review.Schema.AchievementBadge.t/0` associated with the current achievement.
  - `achievement_badge_id`: The `achievement_badge_id` is a reference to AchievementBadge schema.
  """
  @type t :: %__MODULE__{
          owner_id: Integer.t(),
          achievement_badge: AchievementBadge.t() | Ecto.Association.NotLoaded.t(),
          achievement_badge_id: Integer.t()
        }

  @typedoc """
  Check `t` type for more information about the keys.
  """
  @type achievement_attrs :: %{
          owner_id: Integer.t(),
          achievement_badge_id: Integer.t()
        }

  @required_fields ~w(owner_id achievement_badge_id)a

  @primary_key false
  schema "achievements" do
    field(:owner_id, :string)
    belongs_to(:achievement_badge, AchievementBadge)
  end

  @doc """
  Validate the attributes and return a Ecto.Changeset for the current Achievement.
  """
  @spec changeset(t, achievement_attrs) :: Ecto.Changeset.t()
  def changeset(achievement, achievement_attrs) do
    achievement
    |> cast(achievement_attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
