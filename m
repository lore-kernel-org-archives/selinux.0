Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n762G1qw009769
	for <selinux@tycho.nsa.gov>; Wed, 5 Aug 2009 22:16:01 -0400
Received: from e35.co.us.ibm.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n762H0ab020316
	for <selinux@tycho.nsa.gov>; Thu, 6 Aug 2009 02:17:00 GMT
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7627JwP012842
	for <selinux@tycho.nsa.gov>; Wed, 5 Aug 2009 20:07:19 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n762FvbF258346
	for <selinux@tycho.nsa.gov>; Wed, 5 Aug 2009 20:15:57 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n762Fv9F005946
	for <selinux@tycho.nsa.gov>; Wed, 5 Aug 2009 20:15:57 -0600
Date: Wed, 5 Aug 2009 21:15:58 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Paul Moore <paul.moore@hp.com>
Cc: eparis@redhat.com, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: [RFC PATCH v1 1/2] lsm: Add hooks to the TUN driver
Message-ID: <20090806021558.GA17998@us.ibm.com>
References: <20090804211304.10798.65601.stgit@flek.lan> <20090804212158.10798.34592.stgit@flek.lan> <20090805141350.GA353@us.ibm.com> <200908051758.39051.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200908051758.39051.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Paul Moore (paul.moore@hp.com):
> On Wednesday 05 August 2009 10:13:50 am Serge E. Hallyn wrote:
> > Quoting Paul Moore (paul.moore@hp.com):
> 
> [NOTE: my email has been out all day due to some mysterious FS issue so my 
> apologies for not replying sooner]
> 
> ...
> 
> > The checks before and after this patch are not equivalent.  Post-patch,
> > one must always have CAP_NET_ADMIN to do the attach, whereas pre-patch
> > you only needed those if current_cred() did not own the tun device.  Is
> > that intentional?
> 
> Nope, just a goof on my part; I misread the booleans and haven't fully tested 
> the patch yet so it slipped out, thanks for catching it.  This brings up a 
> good point, would we rather move the TUN owner/group checks into the cap_tun_* 
> functions or move the capable() call back into the TUN driver?  The answer 
> wasn't clear to me when I was looking at the code before and the uniqueness of 
> the TUN driver doesn't help much in this regard.

I see the question being asked as:  Does this device belong to
the caller and, if not, is the caller privileged to act
anyway?'  So I think the capable call should be moved back
into the tun driver, followed by a separate security_tun_dev_attach()
check, since that is a separate, restrictive question.

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
