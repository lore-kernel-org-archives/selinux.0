Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jB9LTAMA023234
	for <selinux@tycho.nsa.gov>; Fri, 9 Dec 2005 16:29:10 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id jB9LL7pK021899
	for <selinux@tycho.nsa.gov>; Fri, 9 Dec 2005 21:21:07 GMT
Subject: Re: Latest Ref Policy Diffs
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4398A239.1080005@redhat.com>
References: <4398A239.1080005@redhat.com>
Content-Type: text/plain
Date: Fri, 09 Dec 2005 16:24:02 -0500
Message-Id: <1134163442.16519.4.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-12-08 at 16:14 -0500, Daniel J Walsh wrote: 
> Major change in targeted policy is about to hit.  Basically we are going 
> to turn off allow_execmod, allow_execmem, and allow_execstack by default 
> for unconfined_t programs.
> 
> So several of these patches are to allow that to happen.  Including 
> turning on a real xdm policy.  Getting rid of the alias of 
> texrel_shlib_t to shlib_t.  Mozilla libraries all marked 
> texrel_shlib_t.  ( A bug has been reported on this and hopefully a fix will
> be added.)
> 
> So far I see hal and Xorg as needing execmem.
> 
> gfs support is added
> 
> Most if not all of the kernel leaky file descriptors have been fixed so 
> alot of nasty dontaudits are no longer necessary.
> 
> customizable_types file generated from base.pp for targeted policy.

Merged.  Added a comment as to why the udp bind for generic ports
(port_t) is needed for spamd.

One note, we want to keep the organization in the modules consistent, so
calls to a particular module should generally be grouped together (e.g.,
all interfaces calls to the files module usually go together).  This
would have made it easier to spot that there was a block that was adding
files_dontaudit_read_etc_runtime_files($1_su_t), when there already was
a files_read_etc_runtime_files($1_su_t).

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
