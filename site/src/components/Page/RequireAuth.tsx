import { useActor } from "@xstate/react"
import React, { useContext } from "react"
import { Navigate, useLocation } from "react-router"
import { embedRedirect } from "../../util/redirect"
import { XServiceContext } from "../../xServices/StateContext"
import { FullScreenLoader } from "../Loader/FullScreenLoader"

export interface RequireAuthProps {
  children: JSX.Element
}

export const RequireAuth: React.FC<RequireAuthProps> = ({ children }) => {
  const xServices = useContext(XServiceContext)
  const [authState] = useActor(xServices.authXService)
  const location = useLocation()
  const redirectTo = embedRedirect(location.pathname)

  if (authState.matches("signedOut") || !authState.context.me) {
    return <Navigate to={redirectTo} />
  } else if (authState.hasTag("loading")) {
    return <FullScreenLoader />
  } else {
    return children
  }
}
