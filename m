Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9FJ4tWt027888
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 15:04:55 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9FJ4smR020181
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 19:04:54 GMT
Received: from Cantor.suse.de (ns.suse.de [195.135.220.2])
        by jazzband.ncsc.mil  with ESMTP id h9FJ4rjp020178 for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 19:04:53 GMT
Date: Wed, 15 Oct 2003 21:04:53 +0200
From: Thorsten Kukuk <kukuk@suse.de>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SELinux Mailinglist <selinux@tycho.nsa.gov>
Subject: Re: Question about chsh/chfn/passwd patches
Message-ID: <20031015190453.GA24248@suse.de>
References: <20031015034406.GA1644@suse.de> <1066241019.7399.79.camel@moss-spartans.epoch.ncsc.mil> <20031015183117.GA5967@suse.de> <1066243290.7399.120.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1066243290.7399.120.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Oct 15, Stephen Smalley wrote:

> On Wed, 2003-10-15 at 14:31, Thorsten Kukuk wrote:
> > Ok, since I copy always all attributes if I modify /etc/passwd and
> > /etc/shadow (to make sure to preserve ACLs and security attributes),
> > I don't need it.
> 
> The problem with simply preserving attributes via setxattr is that you
> cannot create the new file immediately with the desired attributes, so
> there is a window where the new file exists with the default attribute
> value, typically inherited from the parent directory.  Note that this is
> particularly a concern for /etc/passwd and /etc/shadow, since they live
> in the same parent directory but have differing protection requirements.

Ok, I think it is trivial to do a getfscreatecon, call setfscreatecon
with the permissions of the passwd file and restore the original
fscreate values afterwards.

But it would be interesting to know how somebody could be able to do
something forbidden with the following:

Create temporary file with mkstemp, mode 0600, owner root:root.
Copy EA attributes.

  Thorsten

-- 
Thorsten Kukuk       http://www.suse.de/~kukuk/        kukuk@suse.de
SuSE Linux AG        Deutschherrnstr. 15-19        D-90429 Nuernberg
--------------------------------------------------------------------    
Key fingerprint = A368 676B 5E1B 3E46 CFCE  2D97 F8FD 4E23 56C6 FB4B

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
