import { screen } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { api } from "api/api";
import { MockUser } from "testHelpers/entities";
import { renderWithAuth } from "testHelpers/renderHelpers";
import { AppearancePage } from "./AppearancePage";

describe("appearance page", () => {
  it("does nothing when selecting current theme", async () => {
    renderWithAuth(<AppearancePage />);

    jest.spyOn(api, "updateAppearanceSettings").mockResolvedValueOnce({
      ...MockUser,
      theme_preference: "dark",
    });

    const dark = await screen.findByText("Dark");
    await userEvent.click(dark);

    // Check if the api was called correctly
    expect(api.updateAppearanceSettings).toBeCalledTimes(0);
  });

  it("changes theme to dark blue", async () => {
    renderWithAuth(<AppearancePage />);

    jest.spyOn(api, "updateAppearanceSettings").mockResolvedValueOnce({
      ...MockUser,
      theme_preference: "darkBlue",
    });

    const darkBlue = await screen.findByText("Dark blue");
    await userEvent.click(darkBlue);

    // Check if the api was called correctly
    expect(api.updateAppearanceSettings).toBeCalledTimes(1);
    expect(api.updateAppearanceSettings).toHaveBeenCalledWith("me", {
      theme_preference: "darkBlue",
    });
  });

  it("changes theme to light", async () => {
    renderWithAuth(<AppearancePage />);

    jest.spyOn(api, "updateAppearanceSettings").mockResolvedValueOnce({
      ...MockUser,
      theme_preference: "light",
    });

    const light = await screen.findByText("Light");
    await userEvent.click(light);

    // Check if the api was called correctly
    expect(api.updateAppearanceSettings).toBeCalledTimes(1);
    expect(api.updateAppearanceSettings).toHaveBeenCalledWith("me", {
      theme_preference: "light",
    });
  });
});
