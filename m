Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9A6KmWt001050
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 02:20:48 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9A6Ki0p027564
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 06:20:44 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
	by jazzswing.ncsc.mil  with ESMTP id h9A6Khr7027479
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 06:20:43 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: login messages
Date: Fri, 10 Oct 2003 16:20:32 +1000
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>
References: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A45@s3cin> <200310080143.48828.russell@coker.com.au> <1065728379.8181.386.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1065728379.8181.386.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310101620.32424.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 10 Oct 2003 05:39, Stephen Smalley wrote:
> > Also I think I'll just make it loadkeys_t instead of having a number of
> > user_loadkeys_t domains.
>
> So, what's the resolution on the capable() check being performed by the
> SELinux module?  Should it be reduced from a full capable() check (i.e.
> Linux capability and SELinux permission check) to just a SELinux
> capability permission check, to avoid changing the Linux permissions
> model and the need for a setuid program?

I think that makes sense at the moment.

However I think that the kernel people should consider making this capability 
a requirement for non-SE kernels.  James, what do you think?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
