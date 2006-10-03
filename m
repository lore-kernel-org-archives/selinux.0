Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k93JSS3Z023148
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 15:28:28 -0400
Received: from e1.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k93JRIqf000955
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 19:27:18 GMT
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k93JST3b000489
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 15:28:29 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k93JSSpV146996
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 15:28:29 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k93JSQ2J002528
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 15:28:27 -0400
Subject: Re: RHEL5 Kernel with labeled networking
From: Joy Latten <latten@austin.ibm.com>
To: Joshua Brindle <method@gentoo.org>
Cc: eparis@parisplace.org, redhat-lssp@redhat.com, selinux@tycho.nsa.gov,
        jmorris@namei.org, paul.moore@hp.com, vyekkirala@TrustedCS.com
In-Reply-To: <4522B79C.2060405@gentoo.org>
References: <200610031837.k93Ib7cQ003247@faith.austin.ibm.com>
	 <4522B79C.2060405@gentoo.org>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 14:16:28 -0500
Message-Id: <1159902988.29928.2.camel@faith.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-10-03 at 15:18 -0400, Joshua Brindle wrote:
> Joy Latten wrote:
> >> Before network labeling is completed we still need some work
> >> implementing how we plan to audit configuration changes in ipsec
> >> labeling decisions.  I believe we agreed today that this auditing must
> >> be done in kernelspace since we do not have fine grained enough controls
> >> on netlink messages to allow for all of the auditing in userspace.
> >>
> >>     
> >
> > I've talked to Klaus about what needs to be audited for ipsec and
> > lspp compliance. I will begin work on a patch and get this out
> > to the list as soon as I can. We will audit everytime a policy is 
> > added/removed to/from the ipsec policy database.
> >
> >   
> why not just auditallow all association setcontext?

Dang! Why didn't I think of that! :-) 
Such a good idea. I will do a quick test and
show Klaus and see if it all looks ok to him.
Thanks!!!

Regards,
Joy

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
