Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBGCXfJI005278
 for <selinux@tycho.nsa.gov>; Fri, 16 Dec 2016 07:33:41 -0500
From: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Reply-To: russell@coker.com.au
Subject: Another getcon() vs getcon_raw() issue in systemd
Date: Fri, 16 Dec 2016 23:33:27 +1100
Message-ID: <4028608.pKKk40ccRB@russell.coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

http://selinux.tycho.nsa.narkive.com/cZUV3wmW/selinux-set-callback-problem

The above URL has the archive of the last time I raised an issue like this. 
Thanks to Nicolas Iooss for pointing out the solution.

type=USER_AVC msg=audit(1481891298.695:687055): pid=1 uid=0 auid=4294967295 
ses=4294967295 subj=system_u:system_r:init_t:s0 msg='avc:  denied  { status } 
for auid=n/a uid=0 gid=0 cmdline="/lib/systemd/systemd-machined" 
scontext=system_u:system_r:systemd_machined_t:SystemLow 
tcontext=system_u:system_r:init_t:s0 tclass=system  exe="/lib/systemd/systemd" 
sauid=0 hostname=? addr=? terminal=?'

Now in Debian/Unstable we have a similar issue with systemd 232-7 giving 
audit.log entries like the above.

# sed -e s/SystemLow/s0/ </var/log/audit/audit.log | audit2allow -l

#============= systemd_machined_t ==============

#!!!! This avc is allowed in the current policy
allow systemd_machined_t init_t:system status;

As an interesting twist it seems that I have some other problem with systemd-
machined in that I have policy allowing the operation in question but it is 
rejected anyway.  Audit2why says:

        Was caused by:
                Unknown - would be allowed by active policy
                Possible mismatch between this policy and the one under which 
the audit message was generated.

                Possible mismatch between current in-memory boolean settings 
vs. permanent ones.

Any suggestions from systemd experts on where to look for a solution would be 
appreciated.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/
