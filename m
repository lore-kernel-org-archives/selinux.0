Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u669hUeJ015341
 for <selinux@tycho.nsa.gov>; Wed, 6 Jul 2016 05:43:30 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
 (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1150A8F232
 for <selinux@tycho.nsa.gov>; Wed,  6 Jul 2016 09:43:28 +0000 (UTC)
Received: from moo.home.annexia.org (ovpn-204-45.brq.redhat.com [10.40.204.45])
 by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 u669hQMO007869
 for <selinux@tycho.nsa.gov>; Wed, 6 Jul 2016 05:43:27 -0400
From: "Richard W.M. Jones" <rjones@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: If autorelabel, force permissive mode.
Date: Wed,  6 Jul 2016 10:43:21 +0100
Message-Id: <1467798202-6412-1-git-send-email-rjones@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Unsubscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/options/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=unsubscribe>
List-Archive: <http://prometheus.infosec.tycho.ncsc.mil/pipermail/selinux/>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
List-Subscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/listinfo/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=subscribe>

The autorelabel feature has been broken in Fedora for a while.
virt-builder relies on this feature to enable SELinux in guests since
we are unable to set filesystem labels when generating the image.  So
it comes down to me to try to fix this.  There was a discussion on the
Fedora development list which explains the background and the reasons
why autorelabel is broken:

http://thread.gmane.org/gmane.linux.redhat.fedora.devel/220453

The plan to fix autorelabel (also formulated in the above thread) is
in two parts:

(1) [This patch] If the autorelabel condition is detected when loading
policy very early during boot, we set SELinux to permissive mode
(overriding the contents of /etc/selinux/config and the command line).

(2) We install a systemd "generator".  If the autorelabel condition is
detected, then the generator redirects the default target to a new,
very minimal selinux-autorelabel.target.  This will relabel the
filesystem, remove /.autorelabel and reboot.  After the reboot the
system will boot normally, with correct filesystem labels and of
course with SELinux enabled.

During relabelling (unlike currently) only a very minimal set of
services are enabled, just enough to be able to mount the filesystem.
This should ensure there is no danger from having SELinux permissive
while relabelling.

This patch is actually against the fedora-selinux.git tree, although
it probably applies upstream too.

Rich.
