Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA21370
	for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2002 15:57:50 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA12522
	for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2002 19:57:23 GMT
Received: from lyta.coker.com.au ([209.151.19.136])
	by jazzswing.ncsc.mil  with ESMTP id TAA12498
	for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2002 19:57:16 GMT
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 019997C76
	for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2002 15:54:16 -0400 (EDT)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Fwd: Re: OpenSSH 3.3p1 - not functioning as advertised.
Date: Wed, 26 Jun 2002 15:54:16 -0400
MIME-Version: 1.0
Message-Id: <20020626195417.019997C76@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When running SE Linux there is no need to run as a separate process.  It is
easy to limit a root process to less access than a user process normally
 gets.

In fact for the SE Linux policy I had to give the sshd_t domain MORE privs
because of this change in sshd, I had to allow it the sys_chroot capability
which it previously did not require.

One thing I would like to see in a future version of OpenSSH is to have it
exec() itself when (and only when) it wants to run as a less privileged
co-process.  Then I could use the rule
domain_auto_trans(sshd_t, sshd_exec_t, sshd_separation_t)
to trigger a change in domain to sshd_separation_t when sshd exec's itself,
and sshd_separation_t would have significantly less access to the system than
a chroot'd UID=sshd co-process would normally have.

Of course chroot is incompatable with exec(), so this would have to be a
configuration option, as you wouldn't want to turn off the chroot() for
non-SE systems.


Also I believe that there is some DARPA funded development work on
Domain-Type Enforcement for BSD, it would be good if the people working on
OpenSSH would get some input from them too...

--
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
