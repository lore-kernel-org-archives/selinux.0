Date: Fri, 25 Jan 2002 07:03:05 -0800
From: Paul Krumviede <pwk@acm.org>
To: Timothy Wood <timothy@hallcomp.com>, Stephen Smalley <sds@tislabs.com>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: network and module problems
Message-ID: <78301711.1011942185@localhost>
In-Reply-To: <1011969383.1945.1.camel@phobos>
References: <1011969383.1945.1.camel@phobos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--On Friday, 25 January, 2002 09:36 -0500 Timothy Wood 
<timothy@hallcomp.com> wrote:

> On Thu, 2002-01-24 at 13:58, Stephen Smalley wrote:
>>
>> > module and by building it straight into the kernel.  Which brings me to
>> > the module problem.  Dmesg shows that it finds the nic but I never see
>> > the module as being loaded when I run lsmod and when I try to insmod it
>> > I get an error saying that it can't locate the card on the console and
>> > avc errors in the system log.
>>
>> If you build the module into the kernel, it won't show up in lsmod.
>> What AVC errors are being logged?  Did you run insmod after logging
>> into the sysadm_r role?  Also, is your kernel in permissive mode or
>> enforcing mode?
>
> I realise that.  I merely brought it up in regards to the time when the
> network was built as a module.
>
> kernel: avc: denied { read } for pid=268 exe=/sbin/insmod
> path=/etc/modules.conf.vm dev=08:01 ino=213709
> scontext=system-U:system_r:kmod_t
> tcontext=system_u:object_r:etc_runtime_t tclass=lnk_file

are you running this inside a VMware virtual machine? i had to create
a policy file for that environment (which is yet to be tested with the
latest release; i'll send it to the list once that happens). the VMware
dualconf script instantiates /etc/modules.conf (and some other
files for X11) as a symlink to the appropriate "real" file depending
on whether one boots the guest OS as a virtual machine or on the
real hardware.

-paul


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
