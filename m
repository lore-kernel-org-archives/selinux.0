Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h44NVTI4024644
	for <selinux@tycho.nsa.gov>; Sun, 4 May 2003 19:31:29 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h44NVGVf017492
	for <selinux@tycho.nsa.gov>; Sun, 4 May 2003 23:31:16 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id h44NVE4D017489
	for <selinux@tycho.nsa.gov>; Sun, 4 May 2003 23:31:14 GMT
Date: Mon, 5 May 2003 09:31:22 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: strange avc messages on oom
Message-ID: <20030504233121.GA31478@snoopy.apana.org.au>
References: <200305042131.30060.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200305042131.30060.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, May 04, 2003 at 09:31:30PM +1000, Russell Coker wrote:
> avc:  denied  { sys_admin } for  pid=1169 exe=/usr/bin/kdeinit capability=21 
> scontext=system_u:system_r:nscd_t tcontext=system_u:system_r:nscd_t 
> tclass=capability
> 
> avc:  denied  { sys_rawio } for  pid=1169 exe=/usr/bin/kdeinit capability=17 
> scontext=system_u:system_r:nscd_t tcontext=system_u:system_r:nscd_t 
> tclass=capability
> 
> avc:  denied  { sys_admin } for  pid=1169 exe=/usr/bin/kdeinit capability=21 
> scontext=system_u:system_r:nscd_t tcontext=system_u:system_r:nscd_t 
> tclass=capability
> Out of Memory: Killed process 17695 (kdeinit).

Do you have nscd loaded?

Just a guess: maybe the kernel is trying to swap code to/from the swap
paritions, but for some reason in out-of-memory conditions cannot get
the correct context, so just uses the existing context instead?

When the kernel reads/writes the swap parition, are these accesses
checked by SE-Linux first?
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
