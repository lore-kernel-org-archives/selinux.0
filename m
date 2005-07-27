Subject: Re: [RFC][PATCH 1/3] Reduce avtab node size
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Valdis.Kletnieks@vt.edu
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>
In-Reply-To: <200507271636.j6RGaCc1004671@turing-police.cc.vt.edu>
References: <1122320487.3029.21.camel@moss-spartans.epoch.ncsc.mil>
	 <200507262053.j6QKrPuY003850@turing-police.cc.vt.edu>
	 <1122478335.19989.133.camel@moss-spartans.epoch.ncsc.mil>
	 <200507271636.j6RGaCc1004671@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Wed, 27 Jul 2005 13:01:36 -0400
Message-Id: <1122483696.19989.151.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-07-27 at 12:36 -0400, Valdis.Kletnieks@vt.edu wrote:
> Much better.  Patch applied clean, compiled clean.  System boots, runs as expected,
> and attempts to intentionally generate AVC messages do in fact generate the
> expected messages.  Before-and-after memory stats:
> 
> Stock 2.6.13-rc3-mm1:
> slabinfo - version: 2.1 (statistics)
> # name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail> : globalstat <listallocs> <maxobjs> <grown> <reaped> <error> <maxfreeable> <nodeallocs> <remotefrees> : cpustat <allochit> <allocmiss> <freehit> <freemiss>
> avtab_node        583563 583632     44   84    1 : tunables   32   16    0 : slabdata   6948   6948      0 : globalstat  583564 583564  6948    0 				   0    0    0    0 : cpustat 541880  41683      0      0
> 
> With patch:
> slabinfo - version: 2.1 (statistics)
> # name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail> : globalstat <listallocs> <maxobjs> <grown> <reaped> <error> <maxfreeable> <nodeallocs> <remotefrees> : cpustat <allochit> <allocmiss> <freehit> <freemiss>
> avtab_node        606400 606425     28  127    1 : tunables   32   16    0 : slabdata   4775   4775      0 : globalstat  606410 606410  4775    0 				   0    0    0    0 : cpustat 568201  38199      0      0

Looks like you have CONFIG_DEBUG_SLAB enabled.  With it disabled, the
objsize (on x86) is 32 bytes before the patch and 16 bytes afterward.

> Got over 8M of memory back (2173 4K pages) - pretty significant on a 256M laptop. ;)
> As a result, I probably can't do a meaningful macro-benchmark on the speed, because
> the 8M of memory will outweigh any code slowdowns...
> 
> Not sure why the number of active objects went up from 583K to 606K - I *did* do
> a yum update and went from strict policy 1.25.3-3 to 1.25.3-5.  If anybody cares, I
> can back that off and see if it goes back down....

Some increase in the number of objects is expected; the old code stored
all access vectors (allow, dontaudit, auditallow) for the same (source
type, target type, target class) triple in a single avtab node, whereas
the new code splits that into multiple nodes, with only one vector per
node, because the number of such nodes with multiple vectors is
relatively small.  Yields a small increase in the number of nodes but
you still end up saving significant memory due to the reduction in the
node size.

Note that the second patch set which I'm still developing should
significantly reduce the number of nodes (by a factor > 10) by not
expanding attributes, thereby saving even further memory.  This will
slow down the kernel's access vector computation, but only on a cache
miss.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
