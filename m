Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id CAA22298
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2001 02:07:38 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id HAA09355
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2001 07:07:01 GMT
Received: from mail.windowpane.com (ip57.gte1.rb1.bel.nwlink.com [209.20.131.57])
	by jazzband.ncsc.mil  with ESMTP id HAA09351
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2001 07:07:01 GMT
Date: Mon, 5 Nov 2001 22:31:32 -0800 (PST)
From: Conan Callen <ccallen@windowpane.com>
To: Ryan Senior <slax@ksni.net>
Cc: <selinux@tycho.nsa.gov>
Subject: Re: Problem making the kernel w/ the SELinux modules added
In-Reply-To: <3BE74419.46DBEAA@ksni.net>
Message-ID: <Pine.LNX.4.33.0111052224090.1411-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ryan,

I got this same error. It happens when linux is compiled for the wrong
cpu. The default Processor Type is Pentium III, if you have an older
processor then this you need to specify your processor in config.

I had an old pentium, after selecting that (and recompiling) checkpolicy
ran without problems.

Conan

> I am running Red Hat 7.1 and am attempting to compile the SELinux
> additions into the kernel,  I get the following error message when it
> gets to part of the SELinux section:
>
> make[3]: Entering directory `/usr/src/selinux/module/selinux_plug/ss'
> gcc -o checkpolicy ebitmap.cp.o queue.cp.o hashtab.cp.o symtab.cp.o
> sidtab.cp.o avtab.cp.o policydb.cp.o services.cp.o y.tab.cp.o
> lex.yy.cp.o checkpolicy.cp.o -lfl
> /usr/bin/ld: cannot find -lfl
> collect2: ld returned 1 exit status
> make[3]: *** [checkpolicy] Error 1
> make[3]: Leaving directory `/usr/src/selinux/module/selinux_plug/ss'
> make[2]: *** [_subdir_ss] Error 2
> make[2]: Leaving directory `/usr/src/selinux/module/selinux_plug'
> make[1]: *** [_subdir_selinux_plug] Error 2
> make[1]: Leaving directory `/usr/src/lsm/security'
> make: *** [_dir_security] Error 2
>
> Thanks,
> Ryan
>
>
> --
> You have received this message because you are subscribed to the selinux list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
