Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA22871
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2001 07:55:53 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA23660
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2001 12:55:46 GMT
Received: from stan.ksni.net (stan.ksni.net [207.239.115.11])
	by jazzswing.ncsc.mil  with ESMTP id MAA23656
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2001 12:55:45 GMT
Message-ID: <3BE7DF3C.4FF393A4@ksni.net>
Date: Tue, 06 Nov 2001 07:01:48 -0600
From: Ryan Senior <slax@ksni.net>
MIME-Version: 1.0
To: Conan Callen <ccallen@windowpane.com>
CC: selinux@tycho.nsa.gov
Subject: Re: Problem making the kernel w/ the SELinux modules added
References: <Pine.LNX.4.33.0111052224090.1411-100000@localhost.localdomain>
Content-Type: multipart/alternative;
 boundary="------------6C56E50507404BC508088855"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------6C56E50507404BC508088855
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I had that same problem (with the CPU's) earlier, because the default kernel in Red
Hat 7.1 defaults to PIII, but I have an AMD K62.  So when I would attempt to
compile, I would get similar errors to this.

So, I just keep telling it to make over and over, and eventually it finishes
compiling.  AMD K62 is specified on the new kernel, so I didn't know what the
problem could be.

/usr/bin/ld: cannot find -lfl
collect2: ld returned 1 exit status

That's the part of the error that tripped me up.

Thanks,
Ryan

Conan Callen wrote:

> Ryan,
>
> I got this same error. It happens when linux is compiled for the wrong
> cpu. The default Processor Type is Pentium III, if you have an older
> processor then this you need to specify your processor in config.
>
> I had an old pentium, after selecting that (and recompiling) checkpolicy
> ran without problems.
>
> Conan
>
> > I am running Red Hat 7.1 and am attempting to compile the SELinux
> > additions into the kernel,  I get the following error message when it
> > gets to part of the SELinux section:
> >
> > make[3]: Entering directory `/usr/src/selinux/module/selinux_plug/ss'
> > gcc -o checkpolicy ebitmap.cp.o queue.cp.o hashtab.cp.o symtab.cp.o
> > sidtab.cp.o avtab.cp.o policydb.cp.o services.cp.o y.tab.cp.o
> > lex.yy.cp.o checkpolicy.cp.o -lfl
> > /usr/bin/ld: cannot find -lfl
> > collect2: ld returned 1 exit status
> > make[3]: *** [checkpolicy] Error 1
> > make[3]: Leaving directory `/usr/src/selinux/module/selinux_plug/ss'
> > make[2]: *** [_subdir_ss] Error 2
> > make[2]: Leaving directory `/usr/src/selinux/module/selinux_plug'
> > make[1]: *** [_subdir_selinux_plug] Error 2
> > make[1]: Leaving directory `/usr/src/lsm/security'
> > make: *** [_dir_security] Error 2
> >
> > Thanks,
> > Ryan
> >
> >
> > --
> > You have received this message because you are subscribed to the selinux list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> > the words "unsubscribe selinux" without quotes as the message.
> >

--------------6C56E50507404BC508088855
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
I had that same problem (with the CPU's) earlier, because the default kernel
in Red Hat 7.1 defaults to PIII, but I have an AMD K62.&nbsp; So when I&nbsp;would
attempt to compile, I would get similar errors to this.
<p>So, I just keep telling it to make over and over, and eventually it
finishes compiling.&nbsp; AMD K62 is specified on the new kernel, so I
didn't know what the problem could be.
<p><i>/usr/bin/ld: cannot find -lfl</i>
<br><i>collect2: ld returned 1 exit status</i><i></i>
<p>That's the part of the error that tripped me up.
<p>Thanks<i>,</i>
<br>Ryan
<p>Conan Callen wrote:
<blockquote TYPE=CITE>Ryan,
<p>I got this same error. It happens when linux is compiled for the wrong
<br>cpu. The default Processor Type is Pentium III, if you have an older
<br>processor then this you need to specify your processor in config.
<p>I had an old pentium, after selecting that (and recompiling) checkpolicy
<br>ran without problems.
<p>Conan
<p>> I am running Red Hat 7.1 and am attempting to compile the SELinux
<br>> additions into the kernel,&nbsp; I get the following error message
when it
<br>> gets to part of the SELinux section:
<br>>
<br>> make[3]: Entering directory `/usr/src/selinux/module/selinux_plug/ss'
<br>> gcc -o checkpolicy ebitmap.cp.o queue.cp.o hashtab.cp.o symtab.cp.o
<br>> sidtab.cp.o avtab.cp.o policydb.cp.o services.cp.o y.tab.cp.o
<br>> lex.yy.cp.o checkpolicy.cp.o -lfl
<br>> /usr/bin/ld: cannot find -lfl
<br>> collect2: ld returned 1 exit status
<br>> make[3]: *** [checkpolicy] Error 1
<br>> make[3]: Leaving directory `/usr/src/selinux/module/selinux_plug/ss'
<br>> make[2]: *** [_subdir_ss] Error 2
<br>> make[2]: Leaving directory `/usr/src/selinux/module/selinux_plug'
<br>> make[1]: *** [_subdir_selinux_plug] Error 2
<br>> make[1]: Leaving directory `/usr/src/lsm/security'
<br>> make: *** [_dir_security] Error 2
<br>>
<br>> Thanks,
<br>> Ryan
<br>>
<br>>
<br>> --
<br>> You have received this message because you are subscribed to the
selinux list.
<br>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
<br>> the words "unsubscribe selinux" without quotes as the message.
<br>></blockquote>
</html>

--------------6C56E50507404BC508088855--


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
