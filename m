Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2RKVwVT011464
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2007 16:31:58 -0400
Received: from an-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2RKVuFA003471
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2007 20:31:56 GMT
Received: by an-out-0708.google.com with SMTP id d33so2311427and
        for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2007 13:31:56 -0700 (PDT)
Message-ID: <e739902b0703271331s55aed820i76b0c380a5f81b12@mail.gmail.com>
Date: Tue, 27 Mar 2007 13:31:55 -0700
From: "Ryan Bradetich" <rbradetich@gmail.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: Separating libselinux/libsepol (Was: Re: BusyBox: load_policy applet)
Cc: "Karl MacMillan" <kmacmillan@mentalrootkit.com>,
        "Stephen Smalley" <sds@tycho.nsa.gov>,
        "Yuichi Nakamura" <ynakam@hitachisoft.jp>, busybox@kaigai.gr.jp,
        selinux@tycho.nsa.gov, "Chad Sellers" <csellers@tresys.com>
In-Reply-To: <1175021034.29300.67.camel@sgc>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070323151513.395798cf.ynakam@hitachisoft.jp>
	 <1174918097.3864.83.camel@moss-spartans.epoch.ncsc.mil>
	 <1174925566.28830.61.camel@sgc>
	 <1174927054.12204.45.camel@localhost.localdomain>
	 <1174939981.28830.84.camel@sgc>
	 <1174999512.3864.278.camel@moss-spartans.epoch.ncsc.mil>
	 <1175010151.29300.39.camel@sgc>
	 <1175010498.3864.370.camel@moss-spartans.epoch.ncsc.mil>
	 <1175011333.19343.33.camel@localhost.localdomain>
	 <1175021034.29300.67.camel@sgc>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 3/27/07, Christopher J. PeBenito <cpebenito@tresys.com> wrote:
> On Tue, 2007-03-27 at 12:02 -0400, Karl M
> A PDA is going to have more backed storage than RAM.  I would argue that
> the tunables solution is the better solution from a memory optimization
> perspective.  Why waste precious RAM on unused configuration rules in
> conditionals, when you have roomier flash-backed storage for tunables?

Maybe I am confused on the difference between a boolean and a tunable
again.  My understanding is that currently there is no difference, but
in the future boolean will be represented as run-time policy changes
and tunables will be represented as compile-time policy changes.

While I generally agree that I would prefer compile time options over
run-time options due to space and processor burden, I also like the
run-time option.  The SCADA industry is a real-time network, so I can
easily imagine situations where the power engineers I work with will
give me requirements like the following:

When the contact input on IN101 goes high, the following action(s)
need to occur within x  time period.

If the x time period is less than the time it takes to re-compile and
load the new policy, I would need to make the time vs space trade-off
and use a run-time check.


My gut feeling would be something like:

I would use tunables (compile-time) options for policy that is driven
by device settings.
I would use run-time (run-time) options for policy that is driven by
SCADA events.


Just offering an alternative embedded use for SELinux that is not a PDA :)

Thanks,

- Ryan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
