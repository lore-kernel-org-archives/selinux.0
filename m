Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i75CYmrT004726
	for <selinux@tycho.nsa.gov>; Thu, 5 Aug 2004 08:34:48 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i75CYDn4003220
	for <selinux@tycho.nsa.gov>; Thu, 5 Aug 2004 12:34:13 GMT
Subject: RE: Now that SELinux supports booleans should we replace tunables
	with booleans?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Cc: Russell Coker <russell@coker.com.au>, Daniel J Walsh <dwalsh@redhat.com>,
   selinux-dev@tresys.com
In-Reply-To: <1091709011.11061.44.camel@moss-spartans.epoch.ncsc.mil>
References: <200404141453.i3EEr2Jx015745@gotham.columbia.tresys.com>
	 <1091472796.23449.248.camel@moss-spartans.epoch.ncsc.mil>
	 <1091709011.11061.44.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1091709228.11061.47.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 05 Aug 2004 08:33:48 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-08-05 at 08:30, Stephen Smalley wrote:
> Dan has raised the issue of how to handle policy reloads when using
> booleans, as a policy reload will reset the boolean values to the
> compile-time default settings.  We could certainly extend load_policy to
> also set the booleans based on the same configuration file used at boot
> time, but that will leave open a window between the policy reload and
> the setting of the booleans where the active policy will fall back to
> the compile-time defaults.  That could break running processes or create
> a window of vulnerability, depending on whether the compile-time
> defaults are more secure or less secure than the configuration file
> settings.  We could have the policy Makefile patch the boolean default
> settings based on the configuration file, so that a policy rebuild would
> change the compile-time defaults to match the desired settings, but that
> requires policy sources, which may not be available (e.g. the policy
> reload may have been triggered by a binary policy update, and the end
> system may not have policy sources installed).  Thoughts?

Actually, it would be easy to create a simple utility that patches a
binary policy to change the boolean default values, so that would be a
possibility.  

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
