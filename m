Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0HFYWcA022236
 for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2017 10:34:32 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
 (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4751D3B74F
 for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2017 15:34:30 +0000 (UTC)
Received: from dhcp-10-19-62-196.boston.devel.redhat.com
 (vpn-232-93.phx2.redhat.com [10.3.232.93])
 by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 v0HFYTdN009963
 for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2017 10:34:30 -0500
To: SELinux <selinux@tycho.nsa.gov>
From: Daniel J Walsh <dwalsh@redhat.com>
Subject: Has anyone ever looked into adding labeling support for the cgroup
 file system
Message-ID: <11517275-0f09-97cd-0353-312c890a4a09@redhat.com>
Date: Tue, 17 Jan 2017 10:34:29 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In order to allow processes to modify the cgroup hierarchy in a
container from an SELinux point of view, we need to allow read/write
access to cgroup_t, which means that a container process could break out
and modify all cgroups, we want to allow them to only modify the portion
of the hierarchy handed to them.

Would be a nice security improvement for docker.
