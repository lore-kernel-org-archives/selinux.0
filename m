Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9FI3nWt027324
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 14:03:49 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9FI3mmR016111
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 18:03:48 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h9FI3ljp016108 for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 18:03:48 GMT
Subject: Re: Question about chsh/chfn/passwd patches
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Thorsten Kukuk <kukuk@suse.de>
Cc: SELinux Mailinglist <selinux@tycho.nsa.gov>,
   Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <20031015034406.GA1644@suse.de>
References: <20031015034406.GA1644@suse.de>
Content-Type: text/plain
Message-Id: <1066241019.7399.79.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 15 Oct 2003 14:03:39 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-10-14 at 23:44, Thorsten Kukuk wrote:
> I have a question about the passwd/chfn/chsh patches.
> 
> passwd only calls checkAccess. chfn/chsh additional calls 
> setupDefaultContext. 
> 
> I don't understand what the last function makes. For what is it good,
> and why don't we need to call it from passwd?

IIRC, for the RH passwd program, this is handled by the libuser patch.
The call is necessary to preserve the security attributes on /etc/passwd
and /etc/shadow when they are rewritten for updates.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
