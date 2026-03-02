public with sharing class DocGenRenditionFinalizer implements Finalizer {

    public Map<Id, Id> failedCvs;
    public Integer retryCount;

    public DocGenRenditionFinalizer(Integer retryCount) {
        this.failedCvs = new Map<Id, Id>();
        this.retryCount = retryCount;
    }

    public void execute(FinalizerContext ctx) {
        if (failedCvs != null && !failedCvs.isEmpty() && retryCount < 10) {
            System.debug('DocGen: Finalizer re-enqueuing ' + failedCvs.size() + ' renditions (retry ' + (retryCount + 1) + ')');
            System.enqueueJob(new DocGenRenditionQueueable(failedCvs, retryCount + 1));
        }
    }
}
