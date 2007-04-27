Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3RAqvVX003616
	for <selinux@tycho.nsa.gov>; Fri, 27 Apr 2007 06:52:57 -0400
Received: from ik-out-1112.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3RAqtEq000350
	for <selinux@tycho.nsa.gov>; Fri, 27 Apr 2007 10:52:56 GMT
Received: by ik-out-1112.google.com with SMTP id b32so498505ika
        for <selinux@tycho.nsa.gov>; Fri, 27 Apr 2007 03:52:55 -0700 (PDT)
Message-ID: <4631D4F4.20901@gmail.com>
Date: Fri, 27 Apr 2007 18:48:20 +0800
From: Ken YANG <spng.yang@gmail.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: James Morris <jmorris@namei.org>, Stephen Smalley <sds@tycho.nsa.gov>,
        SELinux List <selinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: can not boot with strict policy
References: <462CA1F0.2000400@gmail.com> <1177340494.24282.28.camel@moss-spartans.epoch.ncsc.mil> <Line.LNX.4.64.0704231341100.3793@d.namei> <200704261645.50811.russell@coker.com.au>
In-Reply-To: <200704261645.50811.russell@coker.com.au>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> On Tuesday 24 April 2007 03:42, James Morris <jmorris@namei.org> wrote:
>>> Boot with "enforcing=0 single" to come up permissive into single-user
>>> mode, then run /sbin/fixfiles relabel -F to forcible relabel everything,
>>> then reboot.
>> I wonder if we could automate this, so that the autorelabel is also run
>> on boot if you switch between different types of policy.
> 
> There are a few ways of doing this.  For my Kickstart configuration of MLS 
> systems and Play machines I used to create an /etc/init.d script that would 
> put the machine in enforcing mode and configure grub with enforcing=1 and 
> then put enforcing=0 on the grub command-line before the final reboot of the 
> install.
> 
> For a more general solution you might want to have /sbin/init search 
> for /.changing-policy-type as a reason to boot in permissive mode.


the general solution sounds good, which can make the process
automatically like the ".autorelabel" way.

by the way, changing policy from targeted to strict also had other
problems in FC. I am not sure whether the problem occurred in other
distribution too.

before rc.sysinit executes, "/dev" has the "tmpfs_t" type because:

fs_use_trans tmpfs gen_context(system_u:object_r:tmpfs_t,s0);

only after rc.sysinit executed, "/dev" had been relabel to "device_t":

if [ -n "$SELINUX_STATE" -a -x /sbin/restorecon ] && LC_ALL=C fgrep -q " 
/dev " /proc/mounts ; then
         /sbin/restorecon  -R /dev 2>/dev/null
fi

so there is the problem:

avc: denied {search} for pid=1 comm="init" name="/" dev=tmpfs ino=824
scontext=system_u:system_r:init_t:s0
tcontext=system_u:object_r:tmpfs_t:s0 tclass=dir

the "name" field in avc messages is obscure, i deduce the conclusion
from the inode that the target is "/dev", not "/"

but if "distro_redhat" tunables had not been turned on, init will not
have search and other permission to perform certain operations on
tmpfs_t

but because my policy is from svn, the default value of DISTRO
is null.

i doubt whether other distribution has the same problem?
are there some measures to avoid this kind of problem? because
not everyone, especially newbie like me, can figure out this part.


additionally, i am using the "te.vim" from Thomas Bleher to make
te file highlight, but i also want to make fc and if file highlight.
any guides? except SLIDE



> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
