Message-Id: <200507271636.j6RGaCc1004671@turing-police.cc.vt.edu>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>
Subject: Re: [RFC][PATCH 1/3] Reduce avtab node size 
In-Reply-To: Your message of "Wed, 27 Jul 2005 11:32:15 EDT."
             <1122478335.19989.133.camel@moss-spartans.epoch.ncsc.mil>
From: Valdis.Kletnieks@vt.edu
References: <1122320487.3029.21.camel@moss-spartans.epoch.ncsc.mil> <200507262053.j6QKrPuY003850@turing-police.cc.vt.edu>
            <1122478335.19989.133.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1122482172_4035P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Wed, 27 Jul 2005 12:36:12 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1122482172_4035P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <4650.1122482156.1@turing-police.cc.vt.edu>

On Wed, 27 Jul 2005 11:32:15 EDT, Stephen Smalley said:

> This patch, relative to the prior one, fixes both bugs - the diff for
> conditional.c solves the double free problem on the error handling path
> and the diff for avtab.c solves the false conflict detection.  
> 
> diff -X /home/sds/dontdiff -rup linux-2.6.13-rc3-mm1-avtab/security/selinux/ss/avtab.c linux-2.6.13-rc3-mm1-avtab2/security/selinux/ss/avtab.c

Much better.  Patch applied clean, compiled clean.  System boots, runs as expected,
and attempts to intentionally generate AVC messages do in fact generate the
expected messages.  Before-and-after memory stats:

Stock 2.6.13-rc3-mm1:
slabinfo - version: 2.1 (statistics)
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail> : globalstat <listallocs> <maxobjs> <grown> <reaped> <error> <maxfreeable> <nodeallocs> <remotefrees> : cpustat <allochit> <allocmiss> <freehit> <freemiss>
avtab_node        583563 583632     44   84    1 : tunables   32   16    0 : slabdata   6948   6948      0 : globalstat  583564 583564  6948    0 				   0    0    0    0 : cpustat 541880  41683      0      0

With patch:
slabinfo - version: 2.1 (statistics)
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail> : globalstat <listallocs> <maxobjs> <grown> <reaped> <error> <maxfreeable> <nodeallocs> <remotefrees> : cpustat <allochit> <allocmiss> <freehit> <freemiss>
avtab_node        606400 606425     28  127    1 : tunables   32   16    0 : slabdata   4775   4775      0 : globalstat  606410 606410  4775    0 				   0    0    0    0 : cpustat 568201  38199      0      0

Got over 8M of memory back (2173 4K pages) - pretty significant on a 256M laptop. ;)
As a result, I probably can't do a meaningful macro-benchmark on the speed, because
the 8M of memory will outweigh any code slowdowns...

Not sure why the number of active objects went up from 583K to 606K - I *did* do
a yum update and went from strict policy 1.25.3-3 to 1.25.3-5.  If anybody cares, I
can back that off and see if it goes back down....


--==_Exmh_1122482172_4035P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFC57f8cC3lWbTT17ARAprhAJ9FB1/TdbiEs4/O9oJpS5N89+/bJACeMTxg
NtBMeGOPo9KzNTuHynlZwy4=
=oO9w
-----END PGP SIGNATURE-----

--==_Exmh_1122482172_4035P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
