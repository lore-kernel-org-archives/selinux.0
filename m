Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB8J6xIi007338
	for <selinux@tycho.nsa.gov>; Wed, 8 Dec 2004 14:06:59 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB8J71u3029668
	for <selinux@tycho.nsa.gov>; Wed, 8 Dec 2004 19:07:02 GMT
Subject: Re: [2.6 patch] selinux: possible cleanups
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Adrian Bunk <bunk@stusta.de>
Cc: James Morris <jmorris@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
   selinux@tycho.nsa.gov
In-Reply-To: <1102089296.29971.110.camel@moss-spartans.epoch.ncsc.mil>
References: <20041128190139.GD4390@stusta.de>
	 <1102089296.29971.110.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1102532326.26951.129.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 08 Dec 2004 13:58:46 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-12-03 at 10:54, Stephen Smalley wrote:
> - Shouldn't the AVC_CALLBACK_* definitions other than RESET be removed
> since you are removing the other avc_ss interfaces?

Actually, we'd have to keep at least the GRANT definition as well, since
that is used from avc_has_perm_noaudit() for the permissive mode case,
and I suppose we might as well leave the others alone and not disturb
the avc_update_node() code.  So the only changes I'd suggest are
removing the security_member_sid diffs (as it is now used) and including
your follow-up diff for making avtab_insert static.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
