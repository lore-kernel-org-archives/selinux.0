Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA3IH8XZ016971
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 13:17:08 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA3IH3JZ009568
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 18:17:07 GMT
Date: Wed, 3 Nov 2004 18:27:44 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Karl MacMillan <kmacmillan@tresys.com>, Frank Mayer <mayerf@tresys.com>,
   "'Darrel Goeddel'" <dgoeddel@TrustedCS.com>, selinux@tycho.nsa.gov,
   "'Chad Hanson'" <chanson@TrustedCS.com>
Subject: Re: dynamic context transitions
Message-ID: <20041103182744.GG5061@lkcl.net>
References: <000501c4bf9b$a157d2e0$6701a8c0@columbia.tresys.com> <1099316236.21386.31.camel@moss-spartans.epoch.ncsc.mil> <4186DCE7.9030401@tresys.com> <1099409596.31739.150.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1099409596.31739.150.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Nov 02, 2004 at 10:33:17AM -0500, Stephen Smalley wrote:

> only limited benefit).  On the other hand, what happens if we simply
> reject this functionality?  Will the developers of all of these "legacy"
> applications rush to restructure their applications to better support
> least privilege and isolation for SELinux?  

 using the samba example [again - sorry about this] if there were an
 alternately-funded open source SMB server rather than what we have at
 present which is that samba has a total monopoly position, then it
 would be a straightfoward matter of installing "the competitor" to
 samba.

 like where famd got replaced and there _was_ an alternative: famd was
 dropped, and it wasn't necessary to provide a set[f/e]uid-like function
 in SELinux.

 like there is dcron and vixiecron etc. you _can_ choose.

 ... it is painfully clear that because it takes several
 man-years of development to get anywhere _near_ the level of
 functionality required for an SMB server, everyone is stuck
 with and beholden to the arbitrary decisions made by the
 samba developers.

 just like everyone in the windows world is stuck with, and beholden to,
 microsoft.

 [btw it so happens that the samba developers would _love_ to see an
  open source competitor to samba.  and see samba not be necessary at
  all.]

> Or will they just leave them
> as they are, either not running on SELinux at all 

 not a realistic option!

> or running in a single
> domain with the maximal set of permissions required for operation all
> the time?  

 better than not running SELinux at all.

> Is that truly preferable?

 imo, yes it is, because whilst some projects may not be
 persuaded to redesign for better security, others will.

 l.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
