Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA12476
	for <selinux@tycho.nsa.gov>; Tue, 19 Nov 2002 09:26:58 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA12498
	for <selinux@tycho.nsa.gov>; Tue, 19 Nov 2002 14:24:51 GMT
Received: from mx.nas-smoothtransition.com (nas-vm-159.nas-smoothtransition.com [66.95.157.159] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id OAA12494
	for <selinux@tycho.nsa.gov>; Tue, 19 Nov 2002 14:24:50 GMT
From: "Frank Mayer" <mayerf@tresys.com>
To: "'Stephen D. Smalley'" <sds@epoch.ncsc.mil>, <selinux@tycho.nsa.gov>,
        <koichi@osss.is.tsukuba.ac.jp>
Subject: RE: login (new default_contexts)
Date: Tue, 19 Nov 2002 09:26:29 -0500
Message-ID: <000201c28fd7$a99d63c0$6600a8c0@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <200211191404.JAA14487@moss-shockers.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I must admit that I for one am confused about what changed with login
and default contexts.  I'll also admit I haven't tried to look through
the code to understand the changes yet, but perhaps someone can give a
quick synopsis.  Before one had to have a default context in
/etc/security/default_context to login.  From what I've seen here, it
sounds like the file is no longer needed, but instead default_contexts
is used, which has a different format.  

It looks like its specifying a default context for a role rather than a
user.  Is that correct? Does the old default context still work?  Or is
this replaced with the user's own .defaul_context?  I'm sure this was
probably discussed in list; I'd appreciate any pointers on what the
effect of the changes are.  

Thanks Frank


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
