Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7HJjnrT016096
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 15:45:49 -0400 (EDT)
Received: from wowbagger.gapholdings.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7HJj92E015446
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 19:45:09 GMT
Date: Tue, 17 Aug 2004 15:51:35 +0000
From: Eric Andreychek <Eric.Andreychek@rwcwarranty.com>
To: SELinux@tycho.nsa.gov
Subject: Port Binding Being Allowed
Message-ID: <20040817155135.GF19197@rwcwarranty.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Howdy,

I'm setting up an SELinux box using Hardened Gentoo, the 2.6.7-r7 kernel, with
SMP enabled.  The goal is to set up a multi-user box with some reasonable
security measures in place.

I'm hoping to restrict who can bind to a local port (ie, disallow someone from
running a daemon).  It's my impression that this is the default, but it
unfortunatly doesn't seem to be working for me.

Specifically, as user_r, I can do this:

  nc -l -p 9001

Which sets up netcat to listen on port 9001.  I can then telnet to that port as
another user with:

  telnet localhost 9001

The above works fine, it telnets into the port and I can send data across.

As the user who ran netcat,  I type 'id' and get:

 uid=1001(eric) gid=100(users) groups=100(users) context=user_u:user_r:user_t

So your first thought, I'm sure, is to say "Comment out the tunable, dummy!"
Ahh, but it already is!  In fact, I went a step further, and added this to my
local.te:

  neverallow user_t port_t:tcp_socket { accept bind name_bind listen connect } ;

Afterwards, to load it, I did the following:

  make policy
  make load

  echo 1 > /selinux/enforce

After running the above, I see this in the dmesg:

 avc:  granted  { load_policy } for  pid=5236 exe=/usr/sbin/load_policy
 scontext=eric_s:sysadm_r:load_policy_t tcontext=system_u:object_r:security_t
 tclass=security

 avc:  granted  { setenforce } for  pid=5134 exe=/bin/bash
 scontext=eric_s:sysadm_r:sysadm_t tcontext=system_u:object_r:security_t
 tclass=security

And cat /selinux/enforce shows this:

  # cat /selinux/enforce
  1

When I grep my /etc/security/selinux/src/policy/policy.conf for the relevent
neverallow line, it shows:

 # grep neverallow.*user policy.conf
 neverallow user_t port_t:tcp_socket { accept bind name_bind listen connect } ;

Selinux is definitely working to a certain extent though, as the user 'eric'
can't use dmesg, can't run su (even when put in the wheel group), and is
limited as to what processes show up in a 'ps aux'.  Doing any of those
generates a number of deny messages.  Running netcat does not generate any
messages at all.

The more detailed messages when I ran the make load and policy are:

 # make policy
   * Policy version: 17
   * Kernel version: 17
   * Compiling policy.17
  /usr/bin/checkpolicy:  loading policy configuration from policy.conf
  security:  5 users, 5 roles, 486 types, 1 bools
  security:  31 classes, 36950 rules
  /usr/bin/checkpolicy:  policy configuration loaded
  /usr/bin/checkpolicy:  writing binary representation (version 17) to
  policy.17

 # make load
   make: Nothing to be done for `load'.

 # make reload
   * Loading policy.17

To be sure, I did run the netcat *after* putting SELinux into enforce mode, not
beforehand.

Do you have any thoughts at all as to what might be going on here?  I'd be
happy to provide any further details.

Thanks a lot for any help!
  -Eric

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBIimHR5UKaDAjAG4RAmSgAKCmGYVkY9ruQtmka/nZ+Du+l4x41QCfbL3h
c6kx4XmyJj3Enqq922dqPhw=
=oANC
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
