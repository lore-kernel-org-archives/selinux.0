Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hA3GFXWt000901
	for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2003 11:15:33 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hA3GFQKl005070
	for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2003 16:15:26 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id hA3GFP5m005067 for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2003 16:15:25 GMT
Subject: Re: default policy package
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Dale Amon <amon@vnl.com>
Cc: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20031103152731.GC29928@vnl.com>
References: <20031103114353.GC13273@vnl.com>
	 <200311040115.57564.russell@coker.com.au>  <20031103152731.GC29928@vnl.com>
Content-Type: text/plain
Message-Id: <1067876122.21113.70.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 03 Nov 2003 11:15:23 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-11-03 at 10:27, Dale Amon wrote:
> Here's one that might interest Steve: load_policy can 
> totally lock up a small memory machine if the binary 
> policy is large.

What was the memory size and the policy size?  load_policy follows
the same approach as init_module (in 2.6); it vmalloc's a region
for the entire binary policy, copies it from userspace into this region,
converts and extracts the data into the policy runtime data structures,
and then vfree's the copy.  If the initial vmalloc fails (or any
subsequent kmalloc or vmalloc for the runtime data structures fails),
all of the memory allocated during the load should be freed and it
should just fail with errno ENOMEM (and the system should continue
operating under the old policy, which isn't freed until after the new
policy has been fully loaded, sanity checked, and "installed" as the
active policy).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
