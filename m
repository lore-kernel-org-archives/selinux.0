Message-ID: <4797B92E.7050901@redhat.com>
Date: Wed, 23 Jan 2008 17:01:18 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: I am more worried about open then read and write, SELinux needs open
 access checks.
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

One of the things I have talked about in the past was separating the
access for open from read/write.


An example of where this is a problem is the following AVC from a
bugzilla I got today.
type=AVC msg=audit(1201052518.765:1352): avc: denied { write } for
pid=5767 comm="dbus-daemon" path="/home/zack/startx.log" dev=sda3
ino=2227350
scontext=unconfined_u:unconfined_r:unconfined_dbusd_t:s0-s0:c0.c1023
tcontext=unconfined_u:object_r:user_home_t:s0 tclass=file


This indicates that zack started x windows with startx.  With its
standard output directed to /home/zack/startx.log.  The avc indicates
that dbus has suddenly started trying to write files in the users home
directory.

My choice is to allow it or dontaudit it.

Neither is correct.  I really want to know if a confined application
suddenly opens a file in the users homedir for writing, but if the
processes is handed an open file descriptor, I want to allow it.

This is a fundamental flaw in the usability of SELinux.  Handling of
stdin/stdout/stderr are always generating AVC messages that we either
cover up or allow, and this can prevent us from discovering a real
cracker situation.

I would like to propose that we add one or more avc's to deal with
opening a file.  open or open_read open_write.  Leave the existing
access for those that are worried about leaking file descriptors and
information flow, but allow us to concentrate on real vulnerability s
versus noicy avc messages.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkeXuS4ACgkQrlYvE4MpobOx7gCg6g4GRpNEv7OxeHJSdVG6oqI1
tq4AmwWwa/sZVbvpFb480LJRcfn7BjLN
=jPAC
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
