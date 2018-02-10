defmodule StrawHat.Review.Test.ReviewTest do
  use StrawHat.Review.Test.DataCase, async: true
  alias StrawHat.Review.Review

  test "get review by id" do
    review = insert(:review)
    assert Review.get_review(review.id) != nil
  end

  test "get review with invalid id" do
    assert {:error, _reason} = Review.find_review(836747)
  end

  test "list per page" do
    insert_list(10, :review)
    review = Review.get_reviews(%{page: 2, page_size: 5})
    assert review.total_entries == 10
  end

  test "create review" do
    params = params_for(:review)
    assert {:ok, _review} = Review.create_review(params)
  end

  test "update review" do
    review = insert(:review)
    {:ok, review} = Review.update_review(review, %{score: 4})
    assert review.score == 4
  end

  test "delete review" do
    review = insert(:review)
    assert {:ok, _} = Review.destroy_review(review)
  end

  test "add tags to review" do
    review = insert(:review)
    tags = insert_list(10, :tag)
    assert {:ok, review} = Review.add_tags(review, tags)
    assert Enum.count(review.tags) == 10
  end

  test "remove tags from review" do
    review = insert(:review)
    tag = insert(:tag)
    assert {:ok, review} = Review.add_tags(review, [tag])
    assert {count, _} = Review.remove_tags(review, [tag.id])
    assert count == 1
  end

  test "add accomplishments to review" do
    review = insert(:review)
    accomplishments = insert_list(10, :accomplishment)
    assert {:ok, review} = Review.add_accomplishments(review, accomplishments)
    assert Enum.count(review.accomplishments) == 10
  end

  test "remove accomplishments from review" do
    review = insert(:review)
    accomplishment = insert(:accomplishment)
    assert {:ok, review} = Review.add_accomplishments(review, [accomplishment])
    assert {count, _} = Review.remove_accomplishments(review, [accomplishment.id])
    assert count == 1
  end
end
