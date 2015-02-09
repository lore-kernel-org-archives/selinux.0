Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t19N6Rv6025085
 for <selinux@tycho.nsa.gov>; Mon, 9 Feb 2015 18:06:27 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
 (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t19N6N8x001510
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <selinux@tycho.nsa.gov>; Mon, 9 Feb 2015 18:06:24 -0500
Subject: [PATCH 0/4] Fix the selinux-testsuite for RHEL5,6,7 and Rawhide
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Mon, 09 Feb 2015 18:06:22 -0500
Message-ID: <20150209230426.2579.84520.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This patchset allows the SELinux testsuite to run on current versions
of RHEL5, RHEL6, RHEL7, and Fedora Rawhide.  RHEL4 should also work,
but I don't have a RHEL4 system handy to test.

Patches for other SELinux distributions are welcome.

---

Paul Moore (3):
      selinux-testsuite: add improved OS detection
      selinux-testsuite: allow the file test to work with all coreutils versions
      selinux-testsuite: enable task_setscheduler to work with cgroups

Stephen Smalley (1):
      selinux-testsuite: allow unconfined_t entrypoint to test_nnp_bounded_exec_t
