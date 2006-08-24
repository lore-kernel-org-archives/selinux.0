Subject: Re: Bug in restorecon for symlinks in root dir
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Erich Schubert <erich@debian.org>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov
In-Reply-To: <1156354840.2883.4.camel@wintermute.xmldesign.de>
References: <1156205841.22905.33.camel@wintermute.xmldesign.de>
	 <1156346855.8506.62.camel@moss-spartans.epoch.ncsc.mil>
	 <1156354840.2883.4.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 11:27:32 -0400
Message-Id: <1156433253.8506.175.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-08-23 at 19:40 +0200, Erich Schubert wrote:
> Hi Stephen,
> > restorecon reset //lib64 context user_u:object_r:root_t:s0->system_u:object_r:default_t:s0
> > versus the expected result of:
> > restorecon reset /lib64 context user_u:object_r:root_t:s0->system_u:object_r:lib_t:s0
> 
> Ah, I was already wondering why this was happening already...
> 
> > The following seems to work, although it is a bit strange.  Possibly the
> > entire approach there needs to be reworked.
> > +			p = strcpy(path, "");
> 
> Yep, that should work better. The problem is that realpath("") doesn't
> work for obvious reasons. I wonder what realpath does to a trailing
> slash.
> 
> Do we need some handling for double slashes? I.e. will
> restorecon /etc//shadow work as expected? Does it work correctly for
> links like //lib64?
> I assume it will, but I didn't verify it.

restorecon /etc//shadow or //lib64/libc.so.6 appear to work correctly,
but restorecon //lib64 would end up with default_t even with this patch.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
