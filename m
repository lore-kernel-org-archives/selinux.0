Date: Mon, 10 Dec 2001 16:59:01 -0800
From: Paul Krumviede <pwk@acm.org>
To: Johan Camp <johan.camp@student.kuleuven.ac.be>
cc: SELinux@tycho.nsa.gov
Subject: Re: problems after installing selinux
Message-ID: <192900656.1008003541@localhost>
In-Reply-To: <3C155620.91A01E40@student.kuleuven.ac.be>
References: <3C155620.91A01E40@student.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

do you see messages in dmesg such as

AVC:  allocated 14760 bytes during initialization.
SELinux:  module inserted

or, from messages,

Dec 10 16:49:15 zfc kernel: security:  starting up (compiled Nov 27 2001)
Dec 10 16:49:15 zfc kernel: security:  loading policy configuration from 
/ss_policy
Dec 10 16:49:15 zfc kernel: security:  3 users, 6 roles, 372 types
Dec 10 16:49:15 zfc kernel: security:  29 classes, 70479 rules


if not, i'd check to see if the SELinux kernel configuration
flags are set correctly (for example, make sure that
CONFIG_SECURITY_SELINUX=y is present in the
kernel configuration file) and that a policy configuration exists in 
/ss_policy.

-paul

--On Tuesday, 11 December, 2001 01:41 +0100 Johan Camp 
<johan.camp@student.kuleuven.ac.be> wrote:

> Paul Krumviede wrote:
>>
>> --On Monday, 10 December, 2001 22:55 +0100 Johan Camp
>> <johan.camp@student.kuleuven.ac.be> wrote:
>>
>> > Hi
>> >
>> > I recently installed selinux (the 2.4-14-lsm kernel) on my SuSE 7.2
>> > system. After compiling and installing the kernel and all other
>> > utilities (exactly as described in the selinux/README file). I have the
>> > folowing problem:
>> >
>> > - when entering the 'ls --context' command I get the message "Sorry,
>> > --context can be used only on a flask-enabled kernel".
>> >
>> > - when entering the 'ps -e --context' command, all processes have SID =
>> > 3 and CONTEXT = -
>> >
>> > Can anyone tell me how I can solve this problem?
>>
>> this is what happens when a non-selinux kernel is booted. did you
>> fix up /etc/lilo.conf and run lilo to make sure the new kernel is
>> available at boot time?
>
> Yes, I am sure of that. Another indicator is that the tty login used to
> show "suse linux 2.4-4" and now shows "2.4-14-lsm", so this should be
> correct (in a more scientific approach, I checked the lilo.conf file in
> which '/boot/vmlinuz' is indicated as kernel image. 'ls -l
> /boot/vmlinuz' shows this file was put there on dec 10 2002).
>
> Any other suggestions are welcome
>
> Thanx
>
>
> Johan Camp
> KULeuven
>
> ps: oh yes, and I didn't forget to select the "NSA SELinux" option in
> the make menuconfig menu either.
>



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
