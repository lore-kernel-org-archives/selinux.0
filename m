Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA3FisXZ015454
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 10:44:54 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA3FhW4w016686
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 15:43:32 GMT
Date: Wed, 3 Nov 2004 15:55:37 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Valdis.Kletnieks@vt.edu
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, Chad Hanson <chanson@TrustedCS.com>,
   Darrel Goeddel <DGoeddel@TrustedCS.com>, selinux@tycho.nsa.gov,
   Frank Mayer <mayerf@tresys.com>
Subject: Re: dynamic context transitions
Message-ID: <20041103155537.GD5061@lkcl.net>
References: <36282A1733C57546BE392885C06185924D9100@chaos.tcs.tcs-sec.com> <1099342548.21386.239.camel@moss-spartans.epoch.ncsc.mil> <20041101225820.GP9643@lkcl.net> <200411021930.iA2JURrg028137@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200411021930.iA2JURrg028137@turing-police.cc.vt.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Nov 02, 2004 at 02:30:26PM -0500, Valdis.Kletnieks@vt.edu wrote:
> >  by exec()'ing a process, that just simply cannot occur: the
> >  most you pass over is the command-line arguments, environment
> >  variables and um... according to man exec that's it.  [oh, and
> >  man execve says it respects setuid and setgid bits on an executable.]
> 
> Not true at all - just because the only things passed to the execve()
> syscall are the argv[] and envp[] arrays doesn't mean that it's the
> only resources passed to the post-exec code:
> 
> 1) Open file descriptors, unless flagged as close-on-exec
> 2) ulimit/umask settings
> 3) Posix 1.e attributes (modulo the active/permitted/inherited changes)
> 4) The current working directory
> 5) Any namespaces created by mount --bind, clone(CLONE_FS), and friends.
> 
> And probably a bunch of other stuff I'm forgetting.  There's PLENTY of
> places to accidentally leak stuff up/down across an exec() call....

thank you for correcting me.

i trust that all these things are covered in some way by
SE/Linux - from what i can gather, the open file descriptors
definitely are, yes?

l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
