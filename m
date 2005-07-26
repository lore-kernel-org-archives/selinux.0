Message-Id: <200507262053.j6QKrPuY003850@turing-police.cc.vt.edu>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>
Subject: Re: [RFC][PATCH 1/3] Reduce avtab node size 
In-Reply-To: Your message of "Mon, 25 Jul 2005 15:41:27 EDT."
             <1122320487.3029.21.camel@moss-spartans.epoch.ncsc.mil>
From: Valdis.Kletnieks@vt.edu
References: <1122320487.3029.21.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1122411205_2654P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Tue, 26 Jul 2005 16:53:25 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1122411205_2654P
Content-Type: text/plain; charset=us-ascii

On Mon, 25 Jul 2005 15:41:27 EDT, Stephen Smalley said:

> This patch set has three patches - the patch for the kernel, the patch
> for libsepol, and the patch for checkpolicy.  The kernel patch is below.
> As usual, the patched kernel will still read old binary policy versions
> as well, and even better, it will translate such old binary policy
> versions into the more compact in-memory representation, so the memory
> savings can be realized even without an updated libsepol/checkpolicy.
> 
> ---
> 
>  security/selinux/include/security.h |    3 
>  security/selinux/ss/avtab.c         |  189 +++++++++++++++++++++------------
>  security/selinux/ss/avtab.h         |   37 +++---
>  security/selinux/ss/conditional.c   |  204 +++++++++++++++++++--------------
---
>  security/selinux/ss/policydb.c      |    7 +
>  security/selinux/ss/services.c      |   43 +++----
>  6 files changed, 275 insertions(+), 208 deletions(-)

I gave this a whirl, with bad results...  It applied cleanly to my 2.6.13-rc3-mm1,
and built OK, but died at system boot.  Partial hand-copied output follows -
(I didn't have a serial console, and I'm having some CTS issues..)

security: conflicting type rules when adding type rule for true.

..

unable to handle kernel paging request at 6b6b6b73
..
show_stack
show_registers
die
do_pagefault
error_code
cond_list_destroy
policydb_destroy
policydb_read
security_load_policy
sel_write_load
vfs_write
sys_write
syscall_call
...
and then it panics because it tried to kill init.

This ring any bells, or suggest debugging next steps?

--==_Exmh_1122411205_2654P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFC5qLFcC3lWbTT17ARApHQAKDlkHq6zmWfazL8GPgpyR1G9Uq/5gCfdsZ/
bQMeE3YFJSPyz0uPOiyjjiU=
=CbDF
-----END PGP SIGNATURE-----

--==_Exmh_1122411205_2654P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
