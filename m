Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8MNbgUk005455
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 19:37:42 -0400
Received: from e6.ny.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8MNb7AJ015639
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 23:37:10 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8MNbgRp023691
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 19:37:42 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k8MNbWrD278292
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 19:37:36 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k8MNbVSa017384
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 19:37:32 -0400
Date: Fri, 22 Sep 2006 18:25:46 -0500
From: Joy Latten <latten@austin.ibm.com>
Message-Id: <200609222325.k8MNPk3K003106@faith.austin.ibm.com>
To: paul.moore@hp.com, vyekkirala@TrustedCS.com
Subject: Re: Labeled networking packets
Cc: chanson@TrustedCS.com, DGoeddel@TrustedCS.com, dwalsh@redhat.com,
        jbrindle@tresys.com, jmorris@redhat.com, kmacmillan@mentalrootkit.com,
        latten@austin.ibm.com, sds@epoch.ncsc.mil, selinux@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>If you have NetLabel carrying the MLS label why would you want to make
>your life complicated by using SA labeling as well?  I just don't
>understand why the duplication is necessary.  Since this example is only
>dealing with MLS, why not just use NetLabel and if you can't trust the
>physical link layer, i.e. you need IPsec protection, just run unlabeled
>IPsec.  This will allow you to talk to both SELinux and legacy Trusted
>OSs without problem, and it allows you the flexibility of offloading the
>IPsec processing to some sort of bump-in-the-wire solution which could
>yield significant performance advantages.

I agree with this.

Actually, I have been wondering why you would want to use both
netlabel and labeled ipsec on the same traffic stream.
In the same network environment, yes, but I am not sure I
understand why on the same traffic stream.

I think it was said, " but how would you then make sure a secret
cipso didn't arrive thru a TopSecret SA?" 
My question is why configure an ipsec policy with context (which
will result in a labeled SA, for example TopSecret SA) for that 
traffic stream if you know that traffic stream contains an OS 
that will use cipso?  I may be misunderstanding or missing something...
but I am not sure I understand why you would want that traffic 
stream to use both schemes?

I agree, if using cipso and you want to secure your traffic stream,
plain, non-labeled ipsec would do the job. 

Regards,
Joy

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
