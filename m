From: gawain.lynch@felicity-consulting.com.au
To: Chris Crowther <shadow@shad0w.org>
Cc: owner-selinux@tycho.nsa.gov, SELinux@tycho.nsa.gov
Subject: Re: your mail
MIME-Version: 1.0
Message-ID: <OF80957966.799B47D4-ONCA256A19.001AABA7@felicity.net.au>
Date: Sat, 24 Mar 2001 15:55:24 +1100
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > /home/frankeh/slinux/kernel/include/linux/flask/avc.h:13:31:
> > linux/flask/flask.h: No such file or directory
> > /home/frankeh/slinux/kernel/include/linux/flask/security.h:49:32:
> > config/flask/audit.h: No such file or directory
> > 
> > Looks like various files are missing in the distribution.
> > Any ideas ?

>                The header files get auto-created by the build, but 
they're not
> there when make dep is run, so you get all the errors, but the Kernel 
does
> compile.

I am having the same issue with the current release, I let 
tool/build-kernel run twice, but both times it exits with the error below:

        In file included from /usr/include/errno.h:36,
                         from scripts/split-include.c:26:
        /usr/include/bits/errno.h:25: linux/errno.h: No such file or 
directory
        make: *** [scripts/split-include] Error 1

I have also tried patching fresh source here and I get the same issues.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
