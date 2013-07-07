Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r67ErWMl017251
	for <selinux@tycho.nsa.gov>; Sun, 7 Jul 2013 10:53:32 -0400
Received: by mail-ie0-f173.google.com with SMTP id k13so8256475iea.18
        for <selinux@tycho.nsa.gov>; Sun, 07 Jul 2013 07:53:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130707083310.GA32412@siphos.be>
References: <20130705183902.GA26996@siphos.be>
	<2894544.bL1dEvHUlK@sifl>
	<20130706063952.GA29221@siphos.be>
	<CAPzO=NxsvuEjfd8G4MVzRu=s=N39JifP-Kr-zowvKxq4Tt+Sqw@mail.gmail.com>
	<CAOFCXec9Lox=mkSpzmkF+LCsFBWVcRfL3E8u5yM4nYBHveORNA@mail.gmail.com>
	<20130706192147.GA23809@siphos.be>
	<20130707083310.GA32412@siphos.be>
Date: Sun, 7 Jul 2013 10:53:30 -0400
Message-ID: <CAOFCXefGJKvCpjAu3UxLwYJgxrnXd7+rEkHvwxnsh=8GHn_R2A@mail.gmail.com>
Subject: Re: Labeled IPSec trying to match policy for peer label? (solved)
From: Chad Hanson <dahchanson@gmail.com>
To: Sven Vermeulen <sven.vermeulen@siphos.be>
Cc: Paul Moore <paul@paul-moore.com>, SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Glad to hear you found the issue. Everything else looked good,
especially once you added the MCS range.

On Sun, Jul 7, 2013 at 4:33 AM, Sven Vermeulen <sven.vermeulen@siphos.be> wrote:
> On Sat, Jul 06, 2013 at 09:21:47PM +0200, Sven Vermeulen wrote:
>> On Sat, Jul 06, 2013 at 11:40:46AM -0400, Chad Hanson wrote:
>> > Are you running with MLS policy? I am curious since the last output
>> > showed: system_u:object_r:ipsec_spd_t:s0-s0:c0.c1023. I would expect
>> > the following SPD context for MLS:
>> > system_u:object_r:ipsec_spd_t:s0-s15:c0.c1023.  If not using MLS,  you
>> > would always fail in within_range()  at
>> >
>> > if (!mls_ready)    /*mls may not be enabled */
>> >            return 0
>> >
>> > There should be a log message at the startup of racoon if MLS is
>> > disabled. I didn't originally notice your original SPD context wasn't
>> > ranged: system_u:object_r:ipsec_spd_t:s0. This typically would be
>> > system_u:object_r:ipsec_spd_t:s0-s15:c0.c1023 on a MLS system.
>>
>> I'm running an MLS-enabled policy (but its MCS, so only a single sensitivity
>> level but multiple categories). I was thinking about the range as well, but
>> that doesn't seem to help.
>
> Meh, it *was* the mls_ready variable - it was still 0.
>
> I didn't see any logs because ipsec-tools initializes its logging (ploginit)
> /after/ it calls the init_avc, so the log message about MLS being disabled
> was never shown.
>
> Turns out I had to allow racoon_t getattr rights on the security_t
> filesystem and everything works now. I didn't catch it with permissive mode
> because I changed to permissive mode /after/ racoon was started.
>
> Thanks for all the help!
>
>         Sven Vermeulen

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
