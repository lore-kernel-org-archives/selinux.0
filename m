From: william.c.roberts@intel.com
To: sds@tycho.nsa.gov, nnk@google.com, selinux@tycho.nsa.gov
Subject: libsepol: fix checkpolicy dontaudit compiler bug
Date: Tue, 15 Nov 2016 11:39:59 -0800
Message-Id: <1479238801-13053-1-git-send-email-william.c.roberts@intel.com>
In-Reply-To: <[PATCH] libsepol: fix checkpolicy dontaudit compiler bug>
References: <[PATCH] libsepol: fix checkpolicy dontaudit compiler bug>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In continuing the recent discussions on the topics:
  - [PATCH] libsepol: fix checkpolicy dontaudit compiler bug
  - checkpolicy dontaudit compiler bug?

This is my proposed solution to the problem that avoids the
return via-pointer alloced approach.

Unfortunatly the proposed clear than set approach for
bitsetting won't work here, becuase the initial set off of
cur->data is required as noted by Stepehen's original patch.

ie a modification of this logic wont work:
void setbit(u32 *data, u32 value, u32 position) {
	*data = ((*data) & ~(1<<position)) | (value & 0x1 << position);
}

>From current master, with the old fix applied, and the new fix, the
output from sesearch will always yield the same hash:

$ sesearch --dontaudit -s su -c capability,capability2 ~/tmp/bullhead.policy | md5sum
ba1c1e09b910127daeb474d641265950  -

$ sesearch --dontaudit -s su -c capability,capability2 ~/tmp/marlin.policy | md5sum
ba1c1e09b910127daeb474d641265950  -

[PATCH 1/2] Revert "libsepol: fix checkpolicy dontaudit compiler bug"
[PATCH 2/2] libsepol: fix checkpolicy dontaudit compiler bug
