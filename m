Message-ID: <1456423369.3702.42.camel@redhat.com>
Subject: Strange AVC with latest rawhide kernel.
From: Daniel J Walsh <dwalsh@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
 pmoore@redhat.com, mgrepl@redhat.com
Cc: selinux@tycho.nsa.gov
Date: Thu, 25 Feb 2016 13:02:49 -0500
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

audit2allow -wla
type=AVC msg=audit(1456422969.279:1434): avc:  denied  { entrypoint }
for  pid=23847 comm="exe" path="/usr/bin/bash" dev="dm-2" ino=25165968
scontext=system_u:system_r:svirt_lxc_net_t:s0:c337,c895
tcontext=system_u:object_r:svirt_sandbox_file_t:s0:c337,c895
tclass=file permissive=0
	Was caused by:
		Unknown - would be allowed by active policy
		Possible mismatch between this policy and the one under
which the audit message was generated.

		Possible mismatch between current in-memory boolean
settings vs. permanent ones.

When trying to run a docker container on Rawhide, I am seeing this AVC.
The policy as audit2allow -w shows allows svirt_sandbox_file_t as an
entrypoint for svirt_lxc_net_t.

# sesearch -A -s svirt_lxc_net_t -t svirt_sandbox_file_t -c file -p
entrypoint
Found 1 semantic av rules:
   allow svirt_sandbox_domain file_type : file entrypoint ; 

But when I run try to start the container, docker blocks the access.  I
don't see any constraints that would block this, and don't think
NO_NEW_PRIV is enabled any way, and I don't think it would be involved
here. 

Any idea why SELinux is blocking the access?
