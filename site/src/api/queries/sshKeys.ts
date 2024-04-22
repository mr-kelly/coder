import type { QueryClient } from "react-query";
import { api } from "api/api";
import type { GitSSHKey } from "api/typesGenerated";

const getUserSSHKeyQueryKey = (userId: string) => [userId, "sshKey"];

export const userSSHKey = (userId: string) => {
  return {
    queryKey: getUserSSHKeyQueryKey(userId),
    queryFn: () => api.getUserSSHKey(userId),
  };
};

export const regenerateUserSSHKey = (
  userId: string,
  queryClient: QueryClient,
) => {
  return {
    mutationFn: () => api.regenerateUserSSHKey(userId),
    onSuccess: (newKey: GitSSHKey) => {
      queryClient.setQueryData(getUserSSHKeyQueryKey(userId), newKey);
    },
  };
};
