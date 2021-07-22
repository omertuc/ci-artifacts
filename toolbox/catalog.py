from toolbox._common import PlaybookRun


class Catalog:
    """
    Commands for NFD related tasks
    """
    @staticmethod
    def create(*bundles):
        """
        Creates an empty catalog image and uploads it to a container registry
        """
        return PlaybookRun("nfd_test_gpu")

    @staticmethod
    def has_labels():
        """
        Checks if the cluster has NFD labels
        """
        return PlaybookRun("nfd_has_labels")

    @staticmethod
    def wait_gpu_nodes():
        """
        Wait until nfd find GPU nodes
        """
        return PlaybookRun("nfd_wait_gpu")

    @staticmethod
    def wait_labels():
        """
        Wait until nfd labels the nodes
        """
        return PlaybookRun("nfd_wait_labels")
