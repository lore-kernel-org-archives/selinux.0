Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9FJUBWt028119
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 15:30:11 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9FJUAmR021599
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 19:30:10 GMT
Received: from Cantor.suse.de (ns.suse.de [195.135.220.2])
        by jazzband.ncsc.mil  with ESMTP id h9FJU9jp021595 for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 19:30:09 GMT
Date: Wed, 15 Oct 2003 21:30:05 +0200
From: Thorsten Kukuk <kukuk@suse.de>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SELinux Mailinglist <selinux@tycho.nsa.gov>
Subject: Re: Question about chsh/chfn/passwd patches
Message-ID: <20031015193005.GA18974@suse.de>
References: <20031015034406.GA1644@suse.de> <1066241019.7399.79.camel@moss-spartans.epoch.ncsc.mil> <20031015183117.GA5967@suse.de> <1066243290.7399.120.camel@moss-spartans.epoch.ncsc.mil> <20031015190453.GA24248@suse.de> <1066245388.7399.158.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1066245388.7399.158.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Oct 15, Stephen Smalley wrote:

> On Wed, 2003-10-15 at 15:04, Thorsten Kukuk wrote:
> > Ok, I think it is trivial to do a getfscreatecon, call setfscreatecon
> > with the permissions of the passwd file and restore the original
> > fscreate values afterwards.
> 
> Actually, this would be getfilecon() and then setfscreatecon().

No, I mean at first getfscreatecon. You cannot assume that a program
calling a library modifying /etc/passwd does not create any other files.
And in the later case it could be that we don't wish that this files
will be created with the passwd context. Only think about useradd and
creating home directories.
So you have to backup the original values at first and restore them
afterwards.

> > But it would be interesting to know how somebody could be able to do
> > something forbidden with the following:
> > 
> > Create temporary file with mkstemp, mode 0600, owner root:root.
> > Copy EA attributes.
> 
> You're assuming that root is god.  Not so with a mandatory access
> control scheme like SELinux.

No, I don't assume that root is god. 

-- 
Thorsten Kukuk       http://www.suse.de/~kukuk/        kukuk@suse.de
SuSE Linux AG        Deutschherrnstr. 15-19        D-90429 Nuernberg
--------------------------------------------------------------------    
Key fingerprint = A368 676B 5E1B 3E46 CFCE  2D97 F8FD 4E23 56C6 FB4B

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
