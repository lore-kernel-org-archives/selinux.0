Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA21232
	for <selinux@tycho.nsa.gov>; Wed, 24 Oct 2001 18:21:49 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA29782
	for <selinux@tycho.nsa.gov>; Wed, 24 Oct 2001 22:21:16 GMT
Received: from khaipur.xiat.org ([66.125.68.98])
	by jazzband.ncsc.mil  with ESMTP id WAA29778
	for <selinux@tycho.nsa.gov>; Wed, 24 Oct 2001 22:21:15 GMT
Date: Wed, 24 Oct 2001 15:11:47 -0700
From: Paul Krumviede <pwk@acm.org>
To: Stephen Smalley <sds@tislabs.com>,
        "White, Tom (AZ15)" <tom.white@honeywell.com>
cc: selinux@tycho.nsa.gov
Subject: Re: Problems with install
Message-ID: <26054764.1003936307@localhost>
In-Reply-To: <Pine.GSO.4.33.0110241516450.10838-100000@raven>
References: <Pine.GSO.4.33.0110241516450.10838-100000@raven>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

i've had occasion to wonder about the formatting of the
README file. in the BUILDING section, one is presented
with two options. the final paragraph ("To build the SELinux
module..."), while it seems to be intended for use with
the second config/build option, isn't indented. a naive
reading of the build instructions might cause someone
to (re-)build the SELinux module as if it were a loadable
kernel module, and that might cause problems.

-paul

--On Wednesday, 24 October, 2001 15:23 -0400 Stephen Smalley 
<sds@tislabs.com> wrote:

>
> On Wed, 24 Oct 2001, White, Tom (AZ15) wrote:
>
>> I am trying to implement the SELinux patch on a Red Hat 7.1 box. I did
>> the Kernel build following the documentation on the NSA web site.  I got
>> to step 2 in the INSTALLING section and when I do a make install in the
>> module directory I get the following output:
>
> Which release of SELinux are you using, and which download option did you
> use?
>
>> [root@warthog module]# make install
>> rm -f selinux_plug/include/asm selinux_plug/arch/machine
>> ( cd selinux_plug/include ; ln -sf asm-i386 asm)
>> ( cd selinux_plug/arch ; ln -sf i386 machine)
>
> Based on this output, it looks like you are using an older release.
> As of the most recent release, the creation of the architecture symbolic
> links was moved into the selinux_plug Makefiles.  In any event, this
> should have happened during the kernel build, so something is wrong here.
>
>> cd ../../lsm/include/asm; install unistd.h /usr/local/selinux/include/asm
>> cd selinux_plug/ss; install checkpolicy /usr/local/selinux/bin
>> install: cannot stat `checkpolicy': No such file or directory
>> make: *** [install] Error 1
>
> The checkpolicy program should have been compiled during the kernel build.
> Again, this suggests that your kernel build didn't really succeed.  Did
> you enable SELinux in the kernel configuration?
>
> --
> Stephen D. Smalley, NAI Labs
> ssmalley@nai.com
>
>
>
>
> --
> You have received this message because you are subscribed to the selinux
> list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without
> quotes as the message.
>



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
