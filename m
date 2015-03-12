From: Daniel De Graaf <dgdegra@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH v2 0/3] Xen/FLASK policy updates for device contexts
Date: Thu, 12 Mar 2015 16:40:29 -0400
Message-Id: <1426192832-991-1-git-send-email-dgdegra@tycho.nsa.gov>
Cc: xen-devel@lists.xenproject.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In order to support assigning security lables to ARM device tree nodes
in Xen's XSM policy, a new ocontext type is needed in the security
policy.

In addition to adding the new ocontext, the existing I/O memory range
ocontext is expanded to 64 bits in order to support hardware with more
than 44 bits of physical address space (32-bit count of 4K pages).

Changes from v1:
 - Use policy version 30 instead of forking the version numbers for Xen;
   this removes the need for v1's patch 3.
 - Report an error when attempting to use an I/O memory range that
   requires a 64-bit representation with an old policy output version
   that cannot support this
 - Fix a few incorrect references to PCIDEVICECON
 - Reorder patches to clarify the allowed characterset of device tree
   paths

[PATCH 1/3] checkpolicy: Expand allowed character set in paths
[PATCH 2/3] libsepol, checkpolicy: widen Xen IOMEM ocontext entries
[PATCH 3/3] libsepol, checkpolicy: add device tree ocontext nodes to
