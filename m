Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA01452
	for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 09:58:05 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA01510
	for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 13:55:16 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id NAA01506
	for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 13:55:16 GMT
Received: from coalpipe.epoch.ncsc.mil (coalpipe [144.51.25.11])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA24969
	for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 09:56:43 -0400 (EDT)
Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id XAA02882
	for <selinux@tycho.nsa.gov>; Mon, 23 Sep 2002 23:07:58 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id DAA10823
	for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 03:06:11 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id DAA10819 for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 03:06:09 GMT
Date: Tue, 24 Sep 2002 13:07:50 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: SE-Linux packages
Message-ID: <20020924030750.GA28681@snoopy.apana.org.au>
References: <20020920022148.GA12250@snoopy.apana.org.au> <200209201747.53722.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200209201747.53722.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Sep 20, 2002 at 05:47:53PM +0200, Russell Coker wrote:
> I have just updated my patch for unstable to the latest "coreutils" based 
> replacement for fileutils and shellutils.  You may want to base your work on 
> that and maintain one package instead of two.
> 
> My coreutils stuff is in http://www.coker.com.au/selinux/coreutils/

Ok, I have compiled that for woody.

I have also compiled your latest selinux package for woody.

I have put both of these in my repository at the address previously
given.

However, there seem to be two policy errors, and I cannot see how to fix
them:

1. run_deb_t is defined twice; once in run_deb.te, and once in
dpkg.te (run_program macro).

2. mailman_queue_gph_t is not defined but required by the su_mini_domain
macro.

I have hacked solutions to these problems, but think a better solution
is required.
-- 
Brian May <bam@snoopy.apana.org.au>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
