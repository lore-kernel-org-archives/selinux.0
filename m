Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7HF9urT014228
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 11:09:56 -0400 (EDT)
Received: from mcfeely.r00td0wn.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7HF9sKV018778
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 15:09:55 GMT
Message-ID: <41221FC2.8050403@diyab.net>
Date: Tue, 17 Aug 2004 11:09:54 -0400
From: Timothy Wood <timothy@diyab.net>
MIME-Version: 1.0
To: Colin Walters <walters@verbum.org>
CC: Stephen Smalley <sds@epoch.ncsc.mil>, selinux@tycho.nsa.gov,
   Nalin The Nalinator Dahyabhai <nalin@redhat.com>,
   Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [patch] setting default role from ssh
References: <1092513257.4515.28.camel@nexus.verbum.private>	 <1092665369.16631.53.camel@moss-spartans.epoch.ncsc.mil> <1092670862.9971.20.camel@nexus.verbum.private>
In-Reply-To: <1092670862.9971.20.camel@nexus.verbum.private>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Colin Walters wrote:
| On Mon, 2004-08-16 at 10:09 -0400, Stephen Smalley wrote:
|
| I wonder if the BSD people are really actively using it.  I guess though
| even if they weren't, the OpenSSH developers would be averse to breaking
| backwards compatibility for those who were.
|
|

It is still used.  Although the way they use it, from what I have run
into, is more like a way to define the authentication method you want to
use.  For example if you wanted to log in using skey you would use

username:skey@hostname

so maybe, as colin posted, using this

username/role:selinux@hostname

would be best.  If selinux is specified as the style it splits the
username and the desired role seperated by the / and tries to login
using that?

Timothy,
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBIh/CPT0XLCkCs2ARArh8AKCE3bwnVg8mI+D35asQn1kL4h+IIACfQDxk
SFnMIQK0+7Tw1lfvwOERxEs=
=L90+
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
