Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9FJGVWt028005
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 15:16:31 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9FJGUmR020882
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 19:16:30 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h9FJGTjp020879 for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 19:16:29 GMT
Subject: Re: Question about chsh/chfn/passwd patches
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Thorsten Kukuk <kukuk@suse.de>
Cc: SELinux Mailinglist <selinux@tycho.nsa.gov>
In-Reply-To: <20031015190453.GA24248@suse.de>
References: <20031015034406.GA1644@suse.de>
	 <1066241019.7399.79.camel@moss-spartans.epoch.ncsc.mil>
	 <20031015183117.GA5967@suse.de>
	 <1066243290.7399.120.camel@moss-spartans.epoch.ncsc.mil>
	 <20031015190453.GA24248@suse.de>
Content-Type: text/plain
Message-Id: <1066245388.7399.158.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 15 Oct 2003 15:16:28 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-10-15 at 15:04, Thorsten Kukuk wrote:
> Ok, I think it is trivial to do a getfscreatecon, call setfscreatecon
> with the permissions of the passwd file and restore the original
> fscreate values afterwards.

Actually, this would be getfilecon() and then setfscreatecon().
getfilecon (which simply is a wrapper around getxattr that encapsulates
the attribute name for SELinux and provides automatic allocation of the
buffer) gets the context of a specified file, whereas getfscreatecon()
gets the fscreate context of the current process.

> But it would be interesting to know how somebody could be able to do
> something forbidden with the following:
> 
> Create temporary file with mkstemp, mode 0600, owner root:root.
> Copy EA attributes.

You're assuming that root is god.  Not so with a mandatory access
control scheme like SELinux.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
