defmodule BlissfullySewnWeb.TariffLiveTest do
  use BlissfullySewnWeb.ConnCase

  import Phoenix.LiveViewTest
  import BlissfullySewn.VatFixtures

  @create_attrs %{vat: "120.5"}
  @update_attrs %{vat: "456.7"}
  @invalid_attrs %{vat: nil}

  defp create_tariff(_) do
    tariff = tariff_fixture()
    %{tariff: tariff}
  end

  describe "Index" do
    setup [:create_tariff]

    test "lists all vats", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/vats")

      assert html =~ "Listing Vats"
    end

    test "saves new tariff", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/vats")

      assert index_live |> element("a", "New Tariff") |> render_click() =~
               "New Tariff"

      assert_patch(index_live, ~p"/vats/new")

      assert index_live
             |> form("#tariff-form", tariff: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#tariff-form", tariff: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/vats")

      html = render(index_live)
      assert html =~ "Tariff created successfully"
    end

    test "updates tariff in listing", %{conn: conn, tariff: tariff} do
      {:ok, index_live, _html} = live(conn, ~p"/vats")

      assert index_live |> element("#vats-#{tariff.id} a", "Edit") |> render_click() =~
               "Edit Tariff"

      assert_patch(index_live, ~p"/vats/#{tariff}/edit")

      assert index_live
             |> form("#tariff-form", tariff: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#tariff-form", tariff: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/vats")

      html = render(index_live)
      assert html =~ "Tariff updated successfully"
    end

    test "deletes tariff in listing", %{conn: conn, tariff: tariff} do
      {:ok, index_live, _html} = live(conn, ~p"/vats")

      assert index_live |> element("#vats-#{tariff.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#vats-#{tariff.id}")
    end
  end

  describe "Show" do
    setup [:create_tariff]

    test "displays tariff", %{conn: conn, tariff: tariff} do
      {:ok, _show_live, html} = live(conn, ~p"/vats/#{tariff}")

      assert html =~ "Show Tariff"
    end

    test "updates tariff within modal", %{conn: conn, tariff: tariff} do
      {:ok, show_live, _html} = live(conn, ~p"/vats/#{tariff}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Tariff"

      assert_patch(show_live, ~p"/vats/#{tariff}/show/edit")

      assert show_live
             |> form("#tariff-form", tariff: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#tariff-form", tariff: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/vats/#{tariff}")

      html = render(show_live)
      assert html =~ "Tariff updated successfully"
    end
  end
end
