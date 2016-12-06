From: william.c.roberts@intel.com
To: sds@tycho.nsa.gov, nnk@google.com, selinux@tycho.nsa.gov
Subject: [PATCH] quick selinux support for tracefs
Date: Tue,  6 Dec 2016 09:24:37 -0800
Message-Id: <1481045078-15000-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The following patch is on the android common tree. It allows the support
of setxattr on tracefs for restroecon commands.

https://android.googlesource.com/kernel/common/+/3a343a1540d4376d838c0a29bd5462d4e961e766%5E%21/

I figured I would submit it here, since it never made it out of there
tree.

[PATCH] quick selinux support for tracefs
