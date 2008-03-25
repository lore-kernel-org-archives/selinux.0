Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2PIQ6lb004769
	for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2008 14:26:06 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2PIQ1tT007693
	for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2008 18:26:01 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1) with ESMTP id m2PGKiTo012567
	for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2008 12:20:44 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1/Submit) id m2PGKiT0012566
	for selinux@tycho.nsa.gov; Tue, 25 Mar 2008 12:20:44 -0400
Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2PFFuie014660
	for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2008 11:15:56 -0400
Received: from mx.meyering.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2PFFoh6019137
	for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2008 15:15:51 GMT
From: Jim Meyering <jim@meyering.net>
To: russell@coker.com.au, 472590@bugs.debian.org
Cc: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: Re: ls in Debian/Unstable
In-Reply-To: <200803251523.34329.russell@coker.com.au> (Russell Coker's
	message of "Tue, 25 Mar 2008 15:23:32 +1100")
References: <200803251523.34329.russell@coker.com.au>
Date: Tue, 25 Mar 2008 16:08:36 +0100
Message-ID: <87tziu96yz.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker <russell@coker.com.au> wrote:
> unstable0:~/coreutils-6.10# ls -l /
> total 158
> drwxr-xr-x+  2 root root  4096 2008-03-25 10:02 bin
> drwxr-xr-x+  6 root root  1024 2008-03-21 12:30 boot
> drwxr-xr-x+ 16 root root  3700 2008-03-25 13:38 dev
> drwxr-xr-x+ 80 root root  4096 2008-03-25 13:38 etc
> drwxr-xr-x+  3 root root  4096 2008-02-15 22:08 home
>
> In Debian/Unstable the output of "ls -l" is as above, the "+" indicates a SE
> Linux security context - which doesn't do much good when every file has one.
>
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=472590
>
> The above URL has the Debian bug report with a patch.

Hi Russell,

Older versions of the POSIX spec for ls clearly require a "+" on
any file with a SE Linux security context.
But the latest allows it to be any non-space printable character.
So eventually we'll make it more useful than a one-size-fits-all "+",
but it must remain a non-' '.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
