Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA3IaXXZ017177
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 13:36:33 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA3IaWJZ011328
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 18:36:33 GMT
Date: Wed, 3 Nov 2004 18:47:23 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Frank Mayer <mayerf@tresys.com>
Cc: "'Stephen Smalley'" <sds@epoch.ncsc.mil>,
   "'Chad Hanson'" <chanson@TrustedCS.com>,
   "'Darrel Goeddel'" <DGoeddel@TrustedCS.com>, selinux@tycho.nsa.gov
Subject: Re: dynamic context transitions
Message-ID: <20041103184723.GJ5061@lkcl.net>
References: <1099405366.31739.65.camel@moss-spartans.epoch.ncsc.mil> <00bc01c4c0e9$59d01aa0$1e0c010a@columbia.tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <00bc01c4c0e9$59d01aa0$1e0c010a@columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

okay.

following up on the idea of "it is acceptable to do single-process
dynamic context transition on an MLS up-or-down but not to provide a
'generic' method to do same":

would it be reasonable to have an equivalent to domain_auto_trans
which tracks, in selinux domain context terms, the MLS operations

mls_upgrade_auto_trans(some_exec_t, in_some_context_t, to_some_context_t)

and also have an mls_downgrade_auto_trans()

anyone grok?

l.

-- 
--
you don't have to BE MAD   | this space    | my brother wanted to join mensa,
  to work, but   IT HELPS  |   for rent    | for an ego trip - and get kicked 
 you feel better!  I AM    | can pay cash  | out for a even bigger one.
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
