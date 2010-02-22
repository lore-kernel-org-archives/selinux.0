Message-ID: <4B8300B8.7060501@gmail.com>
Date: Mon, 22 Feb 2010 14:10:00 -0800
From: "Justin P. mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Alan Rouse <alan.rouse@ericsson.com>, Dominick Grift <domg472@gmail.com>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: SELinux Policy in OpenSUSE 11.2
References: <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>	 <4B7EDC9A.40801@gmail.com>	 <5A5E55DF96F73844AF7DFB0F48721F0F52E316B01D@EUSAACMS0703.eamcs.ericsson.se>	 <1266614711.32011.107.camel@moss-pluto.epoch.ncsc.mil>	 <4B7F06F1.4070305@gmail.com>	 <1266847250.15933.23.camel@moss-pluto.epoch.ncsc.mil>	 <dd18b0c31002221127j4c22e9d1v94c037e86e7bb74e@mail.gmail.com>	 <dd18b0c31002221129s4be9b56cha13b7be39c2cba36@mail.gmail.com>	 <4B82E190.5060306@gmail.com>	 <1266870268.15933.132.camel@moss-pluto.epoch.ncsc.mil> <dd18b0c31002221325ie418a7ep589e9ac0fe98f1f5@mail.gmail.com>
In-Reply-To: <dd18b0c31002221325ie418a7ep589e9ac0fe98f1f5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 02/22/2010 01:25 PM, Justin Mattock wrote:
>> You don't need to rebuild sysvinit; it already has the selinux support
>> in opensuse.
>>
>> The only issue is how they have configured /etc/inittab (which you still
>> haven't sent) or how they have set up their init scripts.  Things to
>> look for:
>> - Does /etc/inittab invoke the rc scripts directly or indirectly via a
>> shell command?
>> - Are the scripts under /etc/init.d and /etc/rc.d labeled properly (e.g.
>> with initrc_exec_t)?  Otherwise they won't transition properly.
>> - Do the scripts under /etc/init.d and /etc/rc.d have a #! header?  If
>> not, then an attempt to execve() them will fail and it will fall back on
>> the caller to feed them to the shell, at which point you won't have the
>> normal domain transition.
>>
>> --
>> Stephen Smalley
>> National Security Agency
>>
>>
>
> my bad.. got tied up looking for the avc's denial
> of init. attached is inittab-orig of what suse has.
>
> I'll throw in the inittab from my other system to see
> if it changes things, then if not look at the file labels
>


alright here's what I see in /etc/init*

for /etc/init.d
I have all init.d daemons labeled as
system_u:object_r:initrc_exec_t.

in that directory there is rc0.d that is labeled
system_u:object_r:etc_t
inside rc0.d the label is the same.
there also is boot.d
which is labeled the same as rc0.d

ls -lZ /sbin/init
system_u:object_r:init_exec_t

ls -Z /etc/init.d/rc*
has system_u:object_r:etc_t
(I'll go through each one to make sure).

head /etc/init.d/rc*
shows all files having
#! /bin/sh
(I can send you those, but might be too big
of a file).

I think this might be label related
due to the system booting the first time without
any issues, then crashing after lebeling



Justin P. Mattock


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
