Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA12194
	for <selinux@tycho.nsa.gov>; Tue, 19 Nov 2002 08:57:13 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA05285
	for <selinux@tycho.nsa.gov>; Tue, 19 Nov 2002 13:55:12 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id NAA05281 for <selinux@tycho.nsa.gov>; Tue, 19 Nov 2002 13:55:12 GMT
Message-Id: <200211191404.JAA14487@moss-shockers.ncsc.mil>
Date: Tue, 19 Nov 2002 09:04:31 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: login
To: selinux@tycho.nsa.gov, koichi@osss.is.tsukuba.ac.jp
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> when I started SELinux, I was required to input at "Enter role", "Enter type".
> But I do not know what I should input at it.
> Please tell me.

If you are using the current release, I would only expect this to happen
if login isn't labeled correctly, e.g. if you failed to relabel the 
filesystem after installing the SELinux-patched login.  If you are using
an older release, this might happen if you are missing your 
/etc/security/default_context file.

You can try specifying "sysadm_r" and "sysadm_t" or "user_r" and "user_t"
as the role/type pair, depending on your entry in policy/users.  But you'll
want to fix the underlying cause, either relabeling your filesystem or
installing /etc/security/default_context.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
