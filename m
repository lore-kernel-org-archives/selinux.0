Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8KDDjsJ002905
	for <selinux@tycho.nsa.gov>; Sat, 20 Sep 2003 09:13:45 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8KDC3d0003916
	for <selinux@tycho.nsa.gov>; Sat, 20 Sep 2003 13:12:03 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id h8KDC2VY003913
	for <selinux@tycho.nsa.gov>; Sat, 20 Sep 2003 13:12:02 GMT
Date: Sat, 20 Sep 2003 14:13:40 +0100
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: Boot time avc messages
Message-ID: <20030920131340.GH12158@vnl.com>
References: <20030915214153.GE8988@vnl.com> <200309172245.18594.russell@coker.com.au> <20030919154123.GF22480@vnl.com> <200309201632.59282.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200309201632.59282.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Sep 20, 2003 at 04:32:59PM +1000, Russell Coker wrote:
> For best results change that to cron_log_t or whatever the cron logfile type 
> is in your policy.

Yes, that one exists. 

To tell the truth, now that I've gotten back up the learning
curve again, I've half a mind to just swap your policy tree for
Colin's, sans package. I think he's got too much class work
going right now to keep these things up on a timely fashion
and I have to do this work while time is available.

Can you see any potential gotcha's in swapping your 
policy/current and policy/default for his on 2.6.0 test5
kernel with sid packages?

I'm talking about completely bypassing the packaging system
for now, just manually replacing his policy tree with
yours.



 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
