Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tAHLa4kO000820
 for <selinux@tycho.nsa.gov>; Tue, 17 Nov 2015 16:36:04 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
Subject: BTRFS/SELinux patch just got merged in docker.
To: SELinux <selinux@tycho.nsa.gov>,
 Fedora SELinux Users <selinux@lists.fedoraproject.org>
Message-ID: <564B9DAF.5030903@redhat.com>
Date: Tue, 17 Nov 2015 16:35:43 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

https://github.com/docker/docker/pull/16452

This patch will allow you to run your docker containers with SELinux
locked down.  Prior to this you needed to
disable SELinux in docker (Not on the host).

The patch is doing a little bit of nastiness in that it is recursively
relabeling the image on container creation.
You could see a slow down on image creation of 1-2 seconds.  After the
container is created, there is no
slow down in start and stop of the container.

We would prefer to eventually get the kernel fixed to allow built in
btrfs labeling but this at least allows us to
fix this in userspace.  Now we need to fix overlayfs.

Dan
