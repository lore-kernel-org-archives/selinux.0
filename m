Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA15847
	for <selinux@tycho.nsa.gov>; Tue, 4 Feb 2003 12:13:36 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h14HDZI00749
	for <selinux@tycho.nsa.gov>; Tue, 4 Feb 2003 17:13:35 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h14HDZf00745 for <selinux@tycho.nsa.gov>; Tue, 4 Feb 2003 17:13:35 GMT
Message-Id: <200302041721.MAA05297@moss-shockers.ncsc.mil>
Date: Tue, 4 Feb 2003 12:21:07 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: SELinux question?
To: tom@lemuria.org, dwalsh@redhat.com, russell@coker.com.au
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>So they did it because it was easier to wrap the application then to 
>change the code, correct?

See selinux/utils/spasswd/README.  Originally, spasswd was only a
wrapper that served as a "gate" for allowing ordinary users to change
their own passwords while preventing the superuser from arbitrarily
changing other user's passwords.  At that time, the functionality was
easily provided by a wrapper, and there was still a case where direct
execution of the ordinary passwd program was legitimate (execution by
an authorized administrator in sysadm_t to change another user's password).

The wrapper was later extended by Russell Coker to also relabel
/etc/passwd and /etc/shadow after an update in order to support
different security contexts on /etc/passwd and /etc/shadow.  With this
change, it became necessary for authorized administrators to also run
wrapper programs (sadminpasswd, svipw, sadduser, etc) in order to also
preserve these contexts.  

As noted in the README, it would be preferable to modify the base
utilities to use the _secure interfaces to create each file with its
proper context rather than relying on a wrapper to relabel them after
the transaction.  Otherwise, there is a window in which the /etc/passwd
file is left in a more restricted context than desired in order to
preserve the protection of /etc/shadow.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
