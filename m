Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9VErLWt019345
	for <selinux@tycho.nsa.gov>; Fri, 31 Oct 2003 09:53:21 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9VEr2C7002902
	for <selinux@tycho.nsa.gov>; Fri, 31 Oct 2003 14:53:02 GMT
Received: from extern.mail.waldi.eu.org (wavehammer.waldi.eu.org [82.139.196.55])
	by jazzswing.ncsc.mil  with ESMTP id h9VEr1uw002881
	for <selinux@tycho.nsa.gov>; Fri, 31 Oct 2003 14:53:01 GMT
Date: Fri, 31 Oct 2003 15:53:12 +0100
From: Bastian Blank <bastian@waldi.eu.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov
Subject: Re: successfull loaded policy on s390, 64bit
Message-ID: <20031031145312.GA9652@wavehammer.waldi.eu.org>
References: <20031024210709.GA17189@wavehammer.waldi.eu.org> <Pine.LNX.4.53.0310301830290.6332@rmt-desk.bmc.com> <20031031085045.GA29900@wavehammer.waldi.eu.org> <1067609436.30233.370.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1067609436.30233.370.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Oct 31, 2003 at 09:10:36AM -0500, Stephen Smalley wrote:
> And how different is your userland from the upstream at this point?

- some 32/64 bit fixes
- uses enums instead of integers in roleop/op (policy_parse.y)

just look into svn://bblank.thinkmo.de/selinux/selinux/trunk, i hope it
includes any fix, need to recheck that this evening.

bastian

-- 
Oblivion together does not frighten me, beloved.
		-- Thalassa (in Anne Mulhall's body), "Return to Tomorrow",
		   stardate 4770.3.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
