Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7K4DGrT001429
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 00:13:16 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7K4CT4v023193
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 04:12:31 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 91F3961AF7
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 14:13:08 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 19267-05 for <selinux@tycho.nsa.gov>;
	Fri, 20 Aug 2004 14:13:08 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 04EC461AF6
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 14:13:08 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 91C8EB57DB
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 14:13:06 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
Subject: Fwd: OpenSSH 3.9 released
Date: Fri, 20 Aug 2004 14:13:05 +1000
To: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408201413.05986.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

"* Make sshd(8) re-execute itself on accepting a new connection. This security 
measure ensures that all execute-time randomisations are reapplied for each 
connection rather than once, for the master process' lifetime. This includes 
mmap and malloc mappings, shared library addressing, shared library mapping 
order, ProPolice and StackGhost cookies on systems that support such things"

This has some interesting potential.  Maybe we should change the policy to 
have a sshd_listener_t domain that binds to port 22 and then 
domain_auto_trans(sshd_listener_t, sshd_exec_t, sshd_t) for the real work?

"* Implemented the ability to pass selected environment variables between the 
client and the server. See "AcceptEnv" in sshd_config(5) and "SendEnv" in 
ssh_config(5) for details"

This one could be used to solve the problem of selecting roles from a SSH 
client without breaking compatibility.

"* Portable OpenSSH: Re-introduce support for PAM password authentication, in 
addition to the keyboard-interactive driver. PAM password authentication is 
less flexible, and doesn't support pre-authentication password expiry but 
runs in-process so Kerberos tokens, etc are retained"

Just when we got sshd working nicely without using pam_selinux.so...


----------  Forwarded Message  ----------

Subject: OpenSSH 3.9 released
Date: Fri, 20 Aug 2004 12:45
From: "Peter Maas" <fedora@rooker.dyndns.org>
To: "Development discussions related to Fedora Core" 
<fedora-devel-list@redhat.com>

Openssh 3.9 has been released, its up to you guys to decide if its important
enough for FC3 or if it will wait till FC4.
_______________

[openssh-unix-announce] OpenSSH 3.9 released

OpenSSH 3.9 has just been released. It will be available from the
mirrors listed at http://www.openssh.com/ shortly.

OpenSSH is a 100% complete SSH protocol version 1.3, 1.5 and 2.0
implementation and includes sftp client and server support.

We would like to thank the OpenSSH community for their continued
support to the project, especially those who contributed source and
bought T-shirts or posters.

We have a new design of T-shirt available, more info on
        http://www.openbsd.org/tshirts.html#18

For international orders use http://https.openbsd.org/cgi-bin/order
and for European orders, use http://https.openbsd.org/cgi-bin/order.eu


Changes since OpenSSH 3.8:
============================

* Added new "IdentitiesOnly" option to ssh(1), which specifies that it
should
  use keys specified in ssh_config, rather than any keys in ssh-agent(1)

* Make sshd(8) re-execute itself on accepting a new connection. This
security
  measure ensures that all execute-time randomisations are reapplied for
each
  connection rather than once, for the master process' lifetime. This
includes
  mmap and malloc mappings, shared library addressing, shared library
mapping
  order, ProPolice and StackGhost cookies on systems that support such
things

* Add strict permission and ownership checks to programs reading
~/.ssh/config
  NB ssh(1) will now exit instead of trying to process a config with poor
  ownership or permissions

* Implemented the ability to pass selected environment variables between the
  client and the server. See "AcceptEnv" in sshd_config(5) and "SendEnv" in
  ssh_config(5) for details

* Added a "MaxAuthTries" option to sshd(8), allowing control over the
maximum
  number of authentication attempts permitted per connection

* Added support for cancellation of active remote port forwarding sessions.
  This may be performed using the ~C escape character, see "Escape
Characters"
  in ssh(1) for details

* Many sftp(1) interface improvements, including greatly enhanced "ls"
support
  and the ability to cancel active transfers using SIGINT (^C)

* Implement session multiplexing: a single ssh(1) connection can now carry
  multiple login/command/file transfer sessions. Refer to the
"ControlMaster"
  and "ControlPath" options in ssh_config(5) for more information

* The sftp-server has improved support for non-POSIX filesystems (e.g. FAT)

* Portable OpenSSH: Re-introduce support for PAM password authentication, in
  addition to the keyboard-interactive driver. PAM password authentication
  is less flexible, and doesn't support pre-authentication password expiry
but
  runs in-process so Kerberos tokens, etc are retained

* Improved and more extensive regression tests

* Many bugfixes and small improvements

Checksums:
==========

- MD5 (openssh-3.9.tgz) = 93f48bfcc1560895ae53de6bfc41689b
- MD5 (openssh-3.9p1.tar.gz) = 8e1774d0b52aff08f817f3987442a16e


Reporting Bugs:
===============

- please read http://www.openssh.com/report.html
  and http://bugzilla.mindrot.org/

OpenSSH is brought to you by Markus Friedl, Niels Provos, Theo de Raadt,
Kevin Steves, Damien Miller, Ben Lindstrom, Darren Tucker and Tim Rice.

ChangeLog: http://openbsd.md5.com.ar/pub/OpenBSD/OpenSSH/portable/ChangeLog

___________
Peter Maas


--
fedora-devel-list mailing list
fedora-devel-list@redhat.com
http://www.redhat.com/mailman/listinfo/fedora-devel-list

-------------------------------------------------------

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
