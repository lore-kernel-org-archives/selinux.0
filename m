Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id VAA25585
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2002 21:01:17 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id CAA23562
	for <selinux@tycho.nsa.gov>; Wed, 23 Jan 2002 02:00:26 GMT
Received: from jsmith.org (pool-141-158-42-21.phil.east.verizon.net [141.158.42.21])
        by jazzband.ncsc.mil  with ESMTP id CAA23554 for <selinux@tycho.nsa.gov>; Wed, 23 Jan 2002 02:00:25 GMT
Subject: RE: Gdm shut my system down
From: Justin Smith <jsmith@mcs.drexel.edu>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: 
	<72222DC86846D411ABD300A0C9EB08A1015242A7@csoc-mail-box.csoconline.com>
References: 
	<72222DC86846D411ABD300A0C9EB08A1015242A7@csoc-mail-box.csoconline.com>
Content-Type: text/plain
Date: 22 Jan 2002 21:01:50 -0500
Message-Id: <1011751310.1789.8.camel@jsmith.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2002-01-22 at 10:21, Westerman, Mark wrote:
> Let me know 
> 
> Thanks,
> Mark
> 


Well, gdm 2.2.3.1 seems to dislike enforcing mode. Whenever I use it in
enforcing mode, it goes down within a few minutes (random short lengths
of time --- between 5 and 30 seconds). There does not appear to be a
problem in permissive mode since I've been able to use it for hours in
that mode.

In addition, X windows does not appear to have a problem, by itself.
I've been able to use X windows for hours in enforcing mode.

I don't think that it's a question of gdm getting permission denied
because using it for hours in permissive  mode (and setting the policy
to catch all the denied messages) would have caught everything gdm tried
to do. It must be some obscure interaction with the kernel...(ugh!)

I'm using Redhat 7.2 (upgraded from 7.1),

An Nvidia GEForce 2 MX card (with Nvidia's drivers recompiled for this
system)

lsm-2.4-selinux-2002011718.
-- 



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
