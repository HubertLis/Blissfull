defmodule BlissfullySewnWeb.ColorLiveTest do
  use BlissfullySewnWeb.ConnCase

  import Phoenix.LiveViewTest
  import BlissfullySewn.ColorsFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp create_color(_) do
    color = color_fixture()
    %{color: color}
  end

  describe "Index" do
    setup [:create_color]

    test "lists all colors", %{conn: conn, color: color} do
      {:ok, _index_live, html} = live(conn, ~p"/colors")

      assert html =~ "Listing Colors"
      assert html =~ color.name
    end

    test "saves new color", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/colors")

      assert index_live |> element("a", "New Color") |> render_click() =~
               "New Color"

      assert_patch(index_live, ~p"/colors/new")

      assert index_live
             |> form("#color-form", color: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#color-form", color: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/colors")

      html = render(index_live)
      assert html =~ "Color created successfully"
      assert html =~ "some name"
    end

    test "updates color in listing", %{conn: conn, color: color} do
      {:ok, index_live, _html} = live(conn, ~p"/colors")

      assert index_live |> element("#colors-#{color.id} a", "Edit") |> render_click() =~
               "Edit Color"

      assert_patch(index_live, ~p"/colors/#{color}/edit")

      assert index_live
             |> form("#color-form", color: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#color-form", color: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/colors")

      html = render(index_live)
      assert html =~ "Color updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes color in listing", %{conn: conn, color: color} do
      {:ok, index_live, _html} = live(conn, ~p"/colors")

      assert index_live |> element("#colors-#{color.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#colors-#{color.id}")
    end
  end

  describe "Show" do
    setup [:create_color]

    test "displays color", %{conn: conn, color: color} do
      {:ok, _show_live, html} = live(conn, ~p"/colors/#{color}")

      assert html =~ "Show Color"
      assert html =~ color.name
    end

    test "updates color within modal", %{conn: conn, color: color} do
      {:ok, show_live, _html} = live(conn, ~p"/colors/#{color}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Color"

      assert_patch(show_live, ~p"/colors/#{color}/show/edit")

      assert show_live
             |> form("#color-form", color: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#color-form", color: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/colors/#{color}")

      html = render(show_live)
      assert html =~ "Color updated successfully"
      assert html =~ "some updated name"
    end
  end
end
