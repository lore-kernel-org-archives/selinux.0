Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA03288
	for <selinux@tycho.nsa.gov>; Tue, 28 May 2002 11:34:32 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA01882
	for <selinux@tycho.nsa.gov>; Tue, 28 May 2002 15:33:12 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id PAA01878 for <selinux@tycho.nsa.gov>; Tue, 28 May 2002 15:33:11 GMT
Date: Tue, 28 May 2002 11:34:24 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: mini policy for initrd
In-Reply-To: <20020524122608.989A28B9@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0205281133030.1315-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 24 May 2002, Russell Coker wrote:

> I've developed a mini policy for an initrd, but now I have a problem.
>
> On boot after the root file system is mounted the mappings of PSIDs to SIDs
> are made BEFORE the policy is loaded from the root file system.  This means
> that 95% of all files on my root file system lose their labels...
>
> Is there any possibility of solving this in the kernel?  Or should I just
> make sure that my initrd policy contains all the types for all files on the
> root file system?

I'll try to look into solving this problem within the SELinux kernel
module.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
