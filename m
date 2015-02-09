Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t19N6iD0025091
 for <selinux@tycho.nsa.gov>; Mon, 9 Feb 2015 18:06:44 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
 (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t19N6go9001555
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <selinux@tycho.nsa.gov>; Mon, 9 Feb 2015 18:06:42 -0500
Subject: [PATCH 3/4] selinux-testsuite: enable task_setscheduler to work
 with cgroups
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Mon, 09 Feb 2015 18:06:41 -0500
Message-ID: <20150209230641.2579.48731.stgit@localhost>
In-Reply-To: <20150209230426.2579.84520.stgit@localhost>
References: <20150209230426.2579.84520.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On recent systemd based distributions, systemd manages cgroups
automatically and we may be running in a cgroup by default.
Unfortunately, this can cause problems when trying to set the
scheduler policy so we need to move the target process to the root
cgroup (no scheduler policy restrictions in the root cgroup) before
we attempt to change the scheduler settings.

Signed-off-by: Paul Moore <pmoore@redhat.com>
---
 0 files changed

diff --git a/tests/task_setscheduler/test b/tests/task_setscheduler/test
index f1b71eb..f63db07 100755
--- a/tests/task_setscheduler/test
+++ b/tests/task_setscheduler/test
@@ -12,6 +12,15 @@ if ( ($pid = fork()) == 0 ) {
 
 sleep 1; # Give it a second to start
 
+$cgroup_cpu = "/sys/fs/cgroup/cpu/tasks";
+if ( -w $cgroup_cpu ) {
+	# We can only set the scheduler policy fo SCHED_{RR,FIFO} in the root
+	# cgroup so move our target process to the root cgroup.
+	open(my $fd, ">>", $cgroup_cpu);
+	print $fd $pid;
+	close $fd;
+}
+
 # Verify that test_setsched_yes_t can change the scheduling.
 # SCHED_OTHER	0	priority must == 0
 # SCHED_FIFO	1	priority 1..99
