Message-ID: <4B7AFAA8.6090200@gmail.com>
Date: Tue, 16 Feb 2010 12:06:00 -0800
From: "Justin P. mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Alan Rouse <alan.rouse@ericsson.com>,
        "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Re: SELinux Policy in OpenSUSE 11.2
References: <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>	 <4B7AB835.5080008@gmail.com>	 <5A5E55DF96F73844AF7DFB0F48721F0F529A558718@EUSAACMS0703.eamcs.ericsson.se> <1266348497.5252.123.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1266348497.5252.123.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 02/16/2010 11:28 AM, Stephen Smalley wrote:
> On Tue, 2010-02-16 at 13:04 -0500, Alan Rouse wrote:
>> Dominick, thanks for the reply.   These AVC messages occur during
>> normal bootup (not from a command line), so it is the boot process
>> which is starting these in the wrong context.
>>
>> OpenSuSE 11.2 is still using System V init startup, but Fedora 12 is
>> using upstart.  Perhaps that explains why the recent refpolicy is not
>> starting OpenSuse processes in the right context.  Is the current
>> refpolicy known to work in System V init -based systems?
>
> Current refpolicy should still work fine for distributions using
> sysvinit.  Distributions using upstart have to enable a policy
> tunable/boolean.
>
> What build.conf settings are you using?  I expect that the distro_suse
> settings are obsolete, as no one has actively maintained support for
> SUSE in the upstream policy since Thomas Bleher gave up on maintaining
> SUSE SELinux packages.
>
> If you want SELinux to work with SUSE, then:
> a) you'll need to at least file bugs in their bugzilla so that they have
> some reason to believe anyone cares, and
> b) ideally you'll help track down and fix some of the problems and
> submit those fixes to them (if the fixes involve changes to system
> packages, not just policy changes) or to refpolicy as appropriate.
>


ahh.. I remember this:
http://oss.tresys.com/pipermail/refpolicy/2009-September/001447.html

from what I remember I think this had todo with some packages
not having switches turned on with SELinux support
(but if setsebool -P init_upstart=1 like you had posted
works then this has nothing todo with the packages(gnome)).

In general I came to the conclusion,
well SELinux support is there(more of an mls environment(no xserver))
And figured if I'm going to get this I probably am going to have to 
re-build all of the gnome stuff(enabling the SELinux switches)which is
a pretty big job(but could be wrong).

I don't mind giving another go at this,
(or if someone else wants to dive in(have at it))
firstly I need to get some bugs taken care of
in the kernel.

Justin P. Mattock





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
