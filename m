Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3UCkXRb021214
	for <selinux@tycho.nsa.gov>; Fri, 30 Apr 2004 08:46:33 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i3UCiJZx004541
	for <selinux@tycho.nsa.gov>; Fri, 30 Apr 2004 12:44:19 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i3UCiIJv004535
	for <selinux@tycho.nsa.gov>; Fri, 30 Apr 2004 12:44:18 GMT
Subject: Re: I thought we decided that root was root
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Nick Gray <nagray@austin.rr.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1083278176.5793.2.camel@hawaii.efficax.net>
References: <1083278176.5793.2.camel@hawaii.efficax.net>
Content-Type: text/plain
Message-Id: <1083329181.30875.29.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 30 Apr 2004 08:46:21 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-04-29 at 18:36, Nick Gray wrote:
> I thought the consensus was that the root account should have the
> default of sysadm_r. I just created a C2T2 system and I came up with
> staff again?

Do you mean FC2 test3?  I think that the system defaults
(/etc/security/default_contexts) are set to prefer staff_r or user_r
over sysadm_r, and the root-specific defaults (/root/.default_contexts)
are set to prefer sysadm_r for console logins, but not for xdm logins or
ssh logins. Naturally, you can customize that if you want to do so, but
the ability to login directly via xdm or ssh to sysadm_r is a tunable
(enabled by default in the Fedora policy, disabled in ours), so note
that people running with a tighter policy will still fall back to
staff_r as the default.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
