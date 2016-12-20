From: Gary Tierney <gary.tierney@gmx.com>
To: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, sgrubb@redhat.com
Subject: [PATCH v2 0/2]
Date: Tue, 20 Dec 2016 01:28:45 +0000
Message-Id: <cover.1482195891.git.gary.tierney@gmx.com>
In-Reply-To: <20161219160041.GB5359@workstation>
References: <20161219160041.GB5359@workstation>
In-Reply-To: <20161219160041.GB5359@workstation>
References: <20161219160041.GB5359@workstation>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Have updated the patches to print error messages for failures which result in
indeterminate state and warnings for failures to load policy from userspace.
Also updated the patches to remove the function name from log messages.

Steve,

Does your work on AUDIT_MAC_STATUS_FAIL/AUDIT_MAC_LOAD_FAIL messages (I'm
assuming that's what Stephen's referencing in his previous mail) obsolete the
printk logs in the first patch?  An AUDIT_MAC_POLICY_LOAD message would still
be logged presently even if one of sel_make_{bools,classes,policycap} fails, so
I'm not sure if you would also want an
AUDIT_MAC_STATUS_FAIL/AUDIT_MAC_LOAD_FAIL message when that happens, though I
think you might want one in the first case when security_load_policy() fails
(or anything up until that point).

Gary Tierney (2):
  selinux: log errors when loading new policy
  selinux: default to security isid in sel_make_bools() if no sid is
    found

 security/selinux/selinuxfs.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

-- 
2.7.4
