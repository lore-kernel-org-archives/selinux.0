From: Daniel De Graaf <dgdegra@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 0/4] Xen/FLASK policy updates for device contexts
Date: Thu, 12 Mar 2015 13:12:26 -0400
Message-Id: <1426180350-16259-1-git-send-email-dgdegra@tycho.nsa.gov>
Cc: xen-devel@lists.xenproject.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In order to support assigning security lables to ARM device tree nodes
in Xen's XSM policy, a new ocontext type is needed in the security
policy.

This addition requires a new policy version for Xen.  In order to keep
the build process for Xen policy sane, a method of determining the
highest Xen policy version (which is independent of the SELinux policy
version) supported by checkpolicy.

In addition to adding the new ocontext, the existing I/O memory range
ocontext is expanded to 64 bits in order to support hardware with more
than 44 bits of physical address space (32-bit count of 4K pages).

[PATCH 1/4] Expand Xen IOMEMCON to 64 bits
[PATCH 2/4] Add device tree ocontext nodes to Xen policy
[PATCH 3/4] checkpolicy: add output for Xen policy version support
[PATCH 4/4] checkpolicy: Expand allowed character set in paths
