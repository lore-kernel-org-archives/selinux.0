Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r66JLtqS010476
	for <selinux@tycho.nsa.gov>; Sat, 6 Jul 2013 15:21:55 -0400
Received: by mail-we0-f181.google.com with SMTP id p58so2760855wes.12
        for <selinux@tycho.nsa.gov>; Sat, 06 Jul 2013 12:21:53 -0700 (PDT)
Date: Sat, 6 Jul 2013 21:21:47 +0200
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: Chad Hanson <dahchanson@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: Labeled IPSec trying to match policy for peer label?
Message-ID: <20130706192147.GA23809@siphos.be>
References: <20130705183902.GA26996@siphos.be>
 <2894544.bL1dEvHUlK@sifl>
 <20130706063952.GA29221@siphos.be>
 <CAPzO=NxsvuEjfd8G4MVzRu=s=N39JifP-Kr-zowvKxq4Tt+Sqw@mail.gmail.com>
 <CAOFCXec9Lox=mkSpzmkF+LCsFBWVcRfL3E8u5yM4nYBHveORNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAOFCXec9Lox=mkSpzmkF+LCsFBWVcRfL3E8u5yM4nYBHveORNA@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Jul 06, 2013 at 11:40:46AM -0400, Chad Hanson wrote:
> Are you running with MLS policy? I am curious since the last output
> showed: system_u:object_r:ipsec_spd_t:s0-s0:c0.c1023. I would expect
> the following SPD context for MLS:
> system_u:object_r:ipsec_spd_t:s0-s15:c0.c1023.  If not using MLS,  you
> would always fail in within_range()  at
> 
> if (!mls_ready)    /*mls may not be enabled */
>            return 0
> 
> There should be a log message at the startup of racoon if MLS is
> disabled. I didn't originally notice your original SPD context wasn't
> ranged: system_u:object_r:ipsec_spd_t:s0. This typically would be
> system_u:object_r:ipsec_spd_t:s0-s15:c0.c1023 on a MLS system.

I'm running an MLS-enabled policy (but its MCS, so only a single sensitivity
level but multiple categories). I was thinking about the range as well, but
that doesn't seem to help.

Right now, my spdadd statements include the c0.c1023 range, and I'm trying
to generate communication through both a s0:c0.c1023-ranged process as well as
"just" s0 to see what happens. Still no luck.

spdadd 10.1.2.0/24 10.1.3.0/24 any -ctx 1 1
  "system_u:object_r:ipsec_spd_t:s0-s0:c0.c1023" -P out ipsec
  esp/tunnel/192.168.100.152-192.168.100.153/require;

spdadd 10.1.3.0/24 10.1.2.0/24 any -ctx 1 1
  "system_u:object_r:ipsec_spd_t:s0-s0:c0.c1023" -P in ipsec
  esp/tunnel/192.168.100.153-192.168.100.152/require;

There is no logging related to MLS.

I also changed SELinux from enforcing to permissive but that didn't change
the behavior here. I'm going to start inserting the necessary print
statements in the code to see when (and why) the association isn't set up.

Wkr,
	Sven Vermeulen

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
