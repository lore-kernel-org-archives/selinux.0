Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA08843
	for <selinux@tycho.nsa.gov>; Wed, 25 Jul 2001 10:26:26 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA16932
	for <selinux@tycho.nsa.gov>; Wed, 25 Jul 2001 14:25:32 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id OAA16928
	for <selinux@tycho.nsa.gov>; Wed, 25 Jul 2001 14:25:31 GMT
Received: from coalpipe.epoch.ncsc.mil (coalpipe [144.51.25.11])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA21757
	for <selinux@tycho.nsa.gov>; Wed, 25 Jul 2001 10:26:23 -0400 (EDT)
Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id XAA06876
	for <selinux@tycho.nsa.gov>; Tue, 24 Jul 2001 23:47:49 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id DAA24464
	for <selinux@tycho.nsa.gov>; Wed, 25 Jul 2001 03:46:55 GMT
Received: from relay2.nai.com (relay2.nai.com [161.69.3.67])
	by jazzswing.ncsc.mil  with ESMTP id DAA24460
	for <selinux@tycho.nsa.gov>; Wed, 25 Jul 2001 03:46:55 GMT
Received: from scwsout1.nai.com (undef-3-73.nai.com [161.69.3.73] (may be forged))
	by relay2.nai.com (8.9.3/8.9.3) with SMTP id WAA14697
	for <selinux@tycho.nsa.gov>; Tue, 24 Jul 2001 22:47:47 -0500 (CDT)
Message-ID: <DBF2F9C6F6BAD211BB1B00A0C99D97024D5BB3@dns-205.dhcp-77.nai.com>
From: "Smalley, Stephen" <Stephen_Smalley@nai.com>
To: "'Steve Eckmann'" <eckmann@computer.org>
Cc: selinux@tycho.nsa.gov
Subject: RE: running programs
Date: Tue, 24 Jul 2001 20:39:02 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>Yes, I hadn't looked for the avc denied message (I'm used to
>seeing them when I run at the console but did the "ping" test
>in an xterm), but it's there: create denied for rawip_socket.

Right.  So you could define a special domain just for the ping
program (and perhaps related utilities), say ping_t with an
entrypoint type ping_exec_t, and authorize it to create and use
raw IP sockets, e.g. allow ping_t self:rawip_socket rw_socket_perms;

>It's not that I need to prevent ordinary users from executing
>this particular program; I just thought that doing so would
>increase my understanding of selinux configuration. After I turn
>on security I can't execute tiger (a shell script) as root or as
>an ordinary user. I think the interesting parts of the avc denied
>message are:

>  { execute }
>  exe=/bin/bash
>  path=/usr/local/src/tara-2.0.0/tiger
>  tclass=file

Actually, the scontext and tcontext information is very important - it
shows the real reason for the failure (it shows the relevant domain and
type for which execute permission was denied).  In this case, it seems
likely that the type of files in /usr/local/src is not one of the types
to which execute access is granted by the policy configuration,
typically using the can_exec_any macro in macros.te.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
