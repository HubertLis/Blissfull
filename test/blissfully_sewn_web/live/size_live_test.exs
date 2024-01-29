defmodule BlissfullySewnWeb.SizeLiveTest do
  use BlissfullySewnWeb.ConnCase

  import Phoenix.LiveViewTest
  import BlissfullySewn.SizesFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp create_size(_) do
    size = size_fixture()
    %{size: size}
  end

  describe "Index" do
    setup [:create_size]

    test "lists all size", %{conn: conn, size: size} do
      {:ok, _index_live, html} = live(conn, ~p"/size")

      assert html =~ "Listing Size"
      assert html =~ size.name
    end

    test "saves new size", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/size")

      assert index_live |> element("a", "New Size") |> render_click() =~
               "New Size"

      assert_patch(index_live, ~p"/size/new")

      assert index_live
             |> form("#size-form", size: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#size-form", size: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/size")

      html = render(index_live)
      assert html =~ "Size created successfully"
      assert html =~ "some name"
    end

    test "updates size in listing", %{conn: conn, size: size} do
      {:ok, index_live, _html} = live(conn, ~p"/size")

      assert index_live |> element("#size-#{size.id} a", "Edit") |> render_click() =~
               "Edit Size"

      assert_patch(index_live, ~p"/size/#{size}/edit")

      assert index_live
             |> form("#size-form", size: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#size-form", size: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/size")

      html = render(index_live)
      assert html =~ "Size updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes size in listing", %{conn: conn, size: size} do
      {:ok, index_live, _html} = live(conn, ~p"/size")

      assert index_live |> element("#size-#{size.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#size-#{size.id}")
    end
  end

  describe "Show" do
    setup [:create_size]

    test "displays size", %{conn: conn, size: size} do
      {:ok, _show_live, html} = live(conn, ~p"/size/#{size}")

      assert html =~ "Show Size"
      assert html =~ size.name
    end

    test "updates size within modal", %{conn: conn, size: size} do
      {:ok, show_live, _html} = live(conn, ~p"/size/#{size}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Size"

      assert_patch(show_live, ~p"/size/#{size}/show/edit")

      assert show_live
             |> form("#size-form", size: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#size-form", size: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/size/#{size}")

      html = render(show_live)
      assert html =~ "Size updated successfully"
      assert html =~ "some updated name"
    end
  end
end
