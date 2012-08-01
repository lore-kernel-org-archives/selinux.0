Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q711MtrB000872
	for <selinux@tycho.nsa.gov>; Tue, 31 Jul 2012 21:22:55 -0400
Received: by qadb17 with SMTP id b17so2361292qad.12
        for <selinux@tycho.nsa.gov>; Tue, 31 Jul 2012 18:22:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOdLEaqPwc44Yvgu_62jcLvR6diLN3E_7ooi_aSsZuYAOmU2PA@mail.gmail.com>
References: <CAOdLEaqaTsS8bFwytn5h-86J1=qoMzAyKr85PBqS1eS2KV=7Dw@mail.gmail.com>
	<1462896.os7DYYHbcz@sifl>
	<CAOdLEaqPwc44Yvgu_62jcLvR6diLN3E_7ooi_aSsZuYAOmU2PA@mail.gmail.com>
Date: Tue, 31 Jul 2012 21:22:54 -0400
Message-ID: <CAHC9VhQ8pFVx9GXE==Ogc7Vo6U2erXat77Cq-ynAiqR-e0BbaA@mail.gmail.com>
Subject: Re: Consistent crash in selinux_ipv4_postroute?
From: Paul Moore <paul@paul-moore.com>
To: Sam Gandhi <samgandhi9@gmail.com>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
        selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jul 31, 2012 at 9:04 PM, Sam Gandhi <samgandhi9@gmail.com> wrote:
> Paul,
>
> See reply in-line.
>
> On Tue, Jul 31, 2012 at 2:38 PM, Paul Moore <paul@paul-moore.com> wrote:
>> On Tuesday, July 31, 2012 01:44:12 PM Sam Gandhi wrote:
>>> I am running latest linux kernel (top of Linus's tree and I am getting
>>> following crash consistently.
>>>
>>> I am wondering if anybody else is seen this crash with latest linux kernel?
>>
>> NOTE: I've CC'd the SELinux list as this is tied to SELinux and not the LSM in
>> general.
>>
>> I haven't tried Linus' latest, my bleeding-edge system is suffering other
>> problems at the moment, but I can take a look.  Is there any particular trick
>> you use to reproduce the problem?
>
> No steps to reproduce, I just boot the board and let it sit and I see
> the attached panic.

Okay, easy enough.

>> Also, what distribution and what SELinux
>> policy are you using?
>
> This is our own home grown SELinux policy based on openmoko opensource
> selinux policy. I am running this on a embedded platform. The generic
> SELinux policies are too big and I never figured out how to get rid of
> all the normal linux workstation type things from that policy -- stuff
> like syslog,mail, etc. I found openmoko with our custom rules suffice
> so we have stuck to building policy that way.

I was afraid of that ...

Also, just in case you were not aware of it, you may want to check out
the SELinux dummy policy documented in
Documentation/security/SELinux.txt as a basis for building a very
minimal SELinux policy.

>>Since you are hitting postroute_compat() that means you
>> don't have the netpeer policy capability enabled ...
>>
> Yes, I see that netpeer cap is not enabled.
>
>> Also, this looks like an ARM system, yes?  Have you been able to reproduce it
>> on a x86[_64] based system?
>
> Yes this is ARM system and I have not tried reproducing this on X86/64 system
>
>  I will rerun mdp and make sure I got all the base attributes correct etc.
>
>>
>> Finally, it looks like the kernel has been tainted.  What non-standard modules
>> are you loading and what were the previous kernel warnings?
>
> These are modules developed by company where I am working as
> consultant. FWIW, same code base, same SELinux worked fine for 3.5-rc4
> for days...

Anytime I see a module loaded into the kernel that is not part of the
mainline tree I get a little nervous.

Would it be possible for you to lookup the actual line which caused
the NULL pointer deref in gdb (the necessary info is in the kernel
oops message you posted)?  Since it is unlikely I'll be able to
reproduce your environment this may help us get to the root cause
quicker.

-Paul

-- 
paul moore
www.paul-moore.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
