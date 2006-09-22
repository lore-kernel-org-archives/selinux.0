Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8MNpQgp005761
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 19:51:26 -0400
Received: from e3.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8MNoMYb001614
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 23:50:25 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8MNpJd9002012
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 19:51:19 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k8MNpJYs272542
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 19:51:19 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k8MNpC22012283
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 19:51:18 -0400
Date: Fri, 22 Sep 2006 18:39:32 -0500
From: Joy Latten <latten@austin.ibm.com>
Message-Id: <200609222339.k8MNdWXl003177@faith.austin.ibm.com>
To: vyekkirala@TrustedCS.com
Subject: RE: Labeled networking packets
Cc: chanson@TrustedCS.com, DGoeddel@TrustedCS.com, dwalsh@redhat.com,
        jbrindle@tresys.com, jmorris@redhat.com, kmacmillan@mentalrootkit.com,
        sds@epoch.ncsc.mil, selinux@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>> For handling incoming packets this may mean that we keep all of the
>> packet labeling mechanisms separate, allowing each to have it's own
>> permission check.
>
>But how would you then make sure a secret cipso didn't arrive thru a
>TopSecret SA?

But why would you want to configure an ipsec policy containing a
security context that will generate a TopSecret SA, over a traffic
stream that you know will use cipso? If the answer is customers
might do this... but I still don't get why?  Couldn't it be usage?
I may be misunderstanding...

Joy


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
