Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA01622
	for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 10:10:39 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA02376
	for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 14:07:49 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id OAA02299
	for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 14:07:15 GMT
Received: from coalpipe.epoch.ncsc.mil (coalpipe [144.51.25.11])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA25262
	for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 10:08:43 -0400 (EDT)
Message-Id: <200209241351.JAA00540@coalpipe.epoch.ncsc.mil>
Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
        by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA04549
        for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 07:56:23 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
        by jazzswing.ncsc.mil  with ESMTP id LAA25558
        for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 11:53:34 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzswing.ncsc.mil  with ESMTP id LAA25554
        for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 11:53:32 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brian May <bam@snoopy.apana.org.au>
Subject: Re: SE-Linux packages
Date: Tue, 24 Sep 2002 13:54:35 +0200
Cc: selinux@tycho.nsa.gov
References: <20020920022148.GA12250@snoopy.apana.org.au> <200209201747.53722.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

+<20020924030750.GA28681@snoopy.apana.org.au>
In-Reply-To: <20020924030750.GA28681@snoopy.apana.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200209241354.35906.russell@coker.com.au>

On Tue, 24 Sep 2002 05:07, Brian May wrote:
> On Fri, Sep 20, 2002 at 05:47:53PM +0200, Russell Coker wrote:
> > I have just updated my patch for unstable to the latest "coreutils" based
> > replacement for fileutils and shellutils.  You may want to base your work
> > on that and maintain one package instead of two.
> >
> > My coreutils stuff is in http://www.coker.com.au/selinux/coreutils/
>
> Ok, I have compiled that for woody.
>
> I have also compiled your latest selinux package for woody.
>
> I have put both of these in my repository at the address previously
> given.
>
> However, there seem to be two policy errors, and I cannot see how to fix
> them:
>
> 1. run_deb_t is defined twice; once in run_deb.te, and once in
> dpkg.te (run_program macro).

run_deb.te should not exist any more.  The diff created by dpkg-buildpackage
seems to have problems with deleted files.

> 2. mailman_queue_gph_t is not defined but required by the su_mini_domain
> macro.

I don't know the best way to solve this.  It would probably be best for you to
devise a solution as you use gnome-pty-helper, it's difficult for me to solve
problems that don't occur for me...

> I have hacked solutions to these problems, but think a better solution
> is required.

--
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
