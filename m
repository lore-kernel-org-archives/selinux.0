Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m78037aK015481
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 20:03:07 -0400
Received: from tundra.namei.org (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m780355h027997
	for <selinux@tycho.nsa.gov>; Fri, 8 Aug 2008 00:03:06 GMT
Date: Fri, 8 Aug 2008 10:03:02 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Matt Anderson <mra@hp.com>
cc: selinux@tycho.nsa.gov
Subject: Re: SELinux policy and performance impacts
In-Reply-To: <489B81A4.9050007@hp.com>
Message-ID: <alpine.LRH.1.10.0808080955290.22387@tundra.namei.org>
References: <489B81A4.9050007@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 7 Aug 2008, Matt Anderson wrote:

> I'm currently looking into the performance impact of SELinux.  Most of what I
> have seen so far involve testing the system's performance with file creation,
> open, and exec, but I was hoping to gather some more data before finalizing
> any conclusions.
> 
> I was wondering if anyone knows of any types of policy rules that when loaded
> into the kernel are particularly detrimental to system performance.  My
> understanding is that all policy rules are treated equally once they've been
> compiled to binary, but I wanted to ask here first in order to confirm that.

Yes, all access rules are applied in a standard form with decisions cached 
in the AVC.  There were some network permissions which had to do a full 
policydb lookup on each packet to determine the label to use, but these 
are also now cached (although will still incur some overhead).

Auditing will introduce overhead (not all accesses are audited).

Probably the best place to start to understand how this works is to look 
at avc_has_perm() in the kernel code, and also look at /selinux/avc .

I suspect the largest overhead will be in the hook logic for various
operations (e.g. look at the size of inode_doinit_with_dentry()) rather 
than the AVC lookup.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
