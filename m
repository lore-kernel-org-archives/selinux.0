Subject: Re: [PATCH] fix checkpolicy segfaults when using role dominance
	statements
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: Joshua Brindle <jbrindle@tresys.com>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
In-Reply-To: <4329ED38.1030400@trustedcs.com>
References: <4329ED38.1030400@trustedcs.com>
Content-Type: text/plain
Date: Fri, 16 Sep 2005 13:36:39 -0400
Message-Id: <1126892199.27393.45.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-09-15 at 16:52 -0500, Darrel Goeddel wrote:
> This patch fixes two segfaults in the code path handling a
> role dominance statement such as:
> 
> dominance { role big_r { role little_r; } }
> 
> Look correct?

Thanks, merged.  It would likely help if there was a real user of role
dominance in the example policy (and reference policy) so that this code
path is exercised on a regular basis.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
