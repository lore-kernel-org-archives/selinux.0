Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA2DpQXZ005341
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 08:51:26 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA2DpPAw018472
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 13:51:26 GMT
Subject: Re: dynamic context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Chad Hanson <chanson@TrustedCS.com>,
   Darrel Goeddel <DGoeddel@TrustedCS.com>, selinux@tycho.nsa.gov,
   Frank Mayer <mayerf@tresys.com>
In-Reply-To: <20041101225820.GP9643@lkcl.net>
References: <36282A1733C57546BE392885C06185924D9100@chaos.tcs.tcs-sec.com>
	 <1099342548.21386.239.camel@moss-spartans.epoch.ncsc.mil>
	 <20041101225820.GP9643@lkcl.net>
Content-Type: text/plain
Message-Id: <1099403267.31739.22.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 02 Nov 2004 08:47:48 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-11-01 at 17:58, Luke Kenneth Casson Leighton wrote:
>  e.g. if you _do_ implement exec_mls_up/downgrade() then you
>  can actually express that simply as a domain_auto_trans()
>  and an exec()?
> 
>  which _actually_ means that you really should abandon MLS altogether
>  and rewrite your applications to use selinux TE instead?
> 
>  ... i'm just following a logical progression here, but i feel i must
>  have missed something.  clues anyone?

TE is an access matrix, so it can represent a MLS policy, but the
resulting representation would be huge for any significant number of MLS
levels.  A native implementation of MLS is more efficient and easier to
analyze.  There is benefit in a hybrid TE/MLS model.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
