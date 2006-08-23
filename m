Subject: Re: Bug in restorecon for symlinks in root dir
From: Erich Schubert <erich@debian.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov
In-Reply-To: <1156346855.8506.62.camel@moss-spartans.epoch.ncsc.mil>
References: <1156205841.22905.33.camel@wintermute.xmldesign.de>
	 <1156346855.8506.62.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-15
Date: Wed, 23 Aug 2006 19:40:39 +0200
Message-Id: <1156354840.2883.4.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Stephen,
> restorecon reset //lib64 context user_u:object_r:root_t:s0->system_u:object_r:default_t:s0
> versus the expected result of:
> restorecon reset /lib64 context user_u:object_r:root_t:s0->system_u:object_r:lib_t:s0

Ah, I was already wondering why this was happening already...

> The following seems to work, although it is a bit strange.  Possibly the
> entire approach there needs to be reworked.
> +			p = strcpy(path, "");

Yep, that should work better. The problem is that realpath("") doesn't
work for obvious reasons. I wonder what realpath does to a trailing
slash.

Do we need some handling for double slashes? I.e. will
restorecon /etc//shadow work as expected? Does it work correctly for
links like //lib64?
I assume it will, but I didn't verify it.

best regards,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
   It's not denial. I'm just selective about the reality I accept.   //\
       Signatur befindet sich auf der Rückseite dieser E-Mail.       V_/_



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
