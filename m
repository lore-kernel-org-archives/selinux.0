Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1JJOg7d025702
	for <selinux@tycho.nsa.gov>; Mon, 19 Feb 2007 14:24:42 -0500
Received: from e1.ny.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1JJPwHC016753
	for <selinux@tycho.nsa.gov>; Mon, 19 Feb 2007 19:25:59 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1JJPvei010584
	for <selinux@tycho.nsa.gov>; Mon, 19 Feb 2007 14:25:57 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id l1JJPuif244560
	for <selinux@tycho.nsa.gov>; Mon, 19 Feb 2007 14:25:56 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l1JJPtG1031988
	for <selinux@tycho.nsa.gov>; Mon, 19 Feb 2007 14:25:56 -0500
Subject: Re: [redhat-lspp] RE: Deleting xfrms
From: Joy Latten <latten@austin.ibm.com>
To: Eric Paris <eparis@redhat.com>
Cc: vyekkirala@TrustedCS.com, redhat-lspp@redhat.com, selinux@tycho.nsa.gov,
        jmorris@namei.org
In-Reply-To: <1171907230.10265.12.camel@localhost.localdomain>
References: <000c01c7544c$a87906a0$cc0a010a@tcssec.com>
	 <1171907230.10265.12.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 19 Feb 2007 13:10:23 -0600
Message-Id: <1171912223.2603.555.camel@faith.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-02-19 at 12:47 -0500, Eric Paris wrote:
> On Mon, 2007-02-19 at 11:37 -0600, Venkat Yekkirala wrote:
> > I see this bug crept in here:
> > 
> > http://marc.theaimsgroup.com/?l=linux-netdev&m=114956850915839&w=2
> > 
> > Are you planning to fix this or did you want me to?
> 
> Actually I was going to take a stab at it this afternoon.  But I won't
> complain if you beat me to it!
> 
 If either of you fix it, it would be great to me. I am currently
working on the loopback patch. So far things are looking ok... if 
my stress tests continue with no errors, I will send the patches
to ipsec-tools tomorrow for review.

Next is the "ipsec dropping first packet", see
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=225328 
I encountered problems when I tried to patch the 64 kernel a few weeks
ago. I could not get labeled ipsec to work... hopefully there will be
more success in lspp 65 kernel. Will try the lspp.65 patch next.
Also, when I tried the patch in upstream kernel, my kernel panic'd
because of https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=228409
so I have not been able to make much progress with this patch in either
upstream or lspp kernel. Also, I only saw panic in upstream kernel, not
lspp 64 kernel at the time.

Thanks!!!!!

Joy 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
