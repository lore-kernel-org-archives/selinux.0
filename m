Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9FJZxWt028179
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 15:35:59 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9FJZwmR021918
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 19:35:58 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h9FJZvjp021912 for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 19:35:57 GMT
Subject: Re: Question about chsh/chfn/passwd patches
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Thorsten Kukuk <kukuk@suse.de>
Cc: SELinux Mailinglist <selinux@tycho.nsa.gov>
In-Reply-To: <20031015193005.GA18974@suse.de>
References: <20031015034406.GA1644@suse.de>
	 <1066241019.7399.79.camel@moss-spartans.epoch.ncsc.mil>
	 <20031015183117.GA5967@suse.de>
	 <1066243290.7399.120.camel@moss-spartans.epoch.ncsc.mil>
	 <20031015190453.GA24248@suse.de>
	 <1066245388.7399.158.camel@moss-spartans.epoch.ncsc.mil>
	 <20031015193005.GA18974@suse.de>
Content-Type: text/plain
Message-Id: <1066246556.7399.174.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 15 Oct 2003 15:35:56 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-10-15 at 15:30, Thorsten Kukuk wrote:
> No, I mean at first getfscreatecon. You cannot assume that a program
> calling a library modifying /etc/passwd does not create any other files.
> And in the later case it could be that we don't wish that this files
> will be created with the passwd context. Only think about useradd and
> creating home directories.
> So you have to backup the original values at first and restore them
> afterwards.

Sorry, I misunderstood you.  Yes, the libuser and pam pwdb patches do
this as well.

> No, I don't assume that root is god.

Then you're assuming full revocation support, which doesn't exist, at
least not yet.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
