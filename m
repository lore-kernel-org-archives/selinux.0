Subject: Re: matchpathcon_init overhead
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov, SELinux-dev@tresys.com,
   Tom London <selinux@gmail.com>, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
In-Reply-To: <1133447048.26593.442.camel@moss-spartans.epoch.ncsc.mil>
References: <1133385496.26593.405.camel@moss-spartans.epoch.ncsc.mil>
	 <438E23C6.6040509@redhat.com>
	 <1133439793.26593.410.camel@moss-spartans.epoch.ncsc.mil>
	 <438EFDB3.3040004@redhat.com>
	 <1133447048.26593.442.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 01 Dec 2005 10:26:45 -0500
Message-Id: <1133450805.26593.453.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-12-01 at 09:24 -0500, Stephen Smalley wrote:
> Ok.  Attached is a patch relative to the prior one for libselinux that
> also makes the context validation/canonicalization optional at
> matchpathcon_init time, deferring it to a successful matchpathcon by
> default unless a new flag is set via set_matchpathcon_flags.  This
> avoids any need to change the majority of users (rpm, udev,
> install, ...) to pick up the new behavior.  Also attached is a patch for
> setfiles that sets the flag so that it retains the original behavior of
> validating/canonicalizing during init.  Seems like restorecon should
> have the same behavior as install, since it is often used selectively on
> a few files, so I didn't patch it.  Seem sane?

These patches are included in libselinux 1.27.28 and policycoreutils
1.27.33.  Thus, you should see improved performance in udev and install
due to the lazy context canonicalization immediately without needing to
modify them, but you can further optimize them by having them also call
matchpathcon_init_prefix() with a suitable prefix once during startup
prior to any matchpathcon() calls.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
