Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tA9DhSeU026528
 for <selinux@tycho.nsa.gov>; Mon, 9 Nov 2015 08:43:28 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
 (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
 by mx1.redhat.com (Postfix) with ESMTPS id ADFC819F240
 for <selinux@tycho.nsa.gov>; Mon,  9 Nov 2015 13:43:16 +0000 (UTC)
Received: from localhost.localdomain (ovpn-200-45.brq.redhat.com
 [10.40.200.45])
 by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 tA9DhFQc009620
 for <selinux@tycho.nsa.gov>; Mon, 9 Nov 2015 08:43:16 -0500
From: Miroslav Grepl <mgrepl@redhat.com>
Subject: get_default_context() hit the SIMPLE_TRANSACTION_LIMIT
To: SELinux <selinux@tycho.nsa.gov>
Message-ID: <5640A2F2.3080703@redhat.com>
Date: Mon, 9 Nov 2015 14:43:14 +0100
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

We are trying to get pam_selinux + systemd-user working on Fedora
Rawhide to avoid systemd-user running with init_t. The problem is with
init_t domain which is unconfined domain by default on Fedora.


echo -n system_u:system_r:init_t:s0 unconfined_u > /sys/fs/selinux/user
sh: echo: write error: Numerical result out of range


causes failsafe_context is used for SELinux user context as a result of
pam_selinux. With disabled unconfined.pp module it works as expected.

The problem is also described here

https://bugzilla.redhat.com/show_bug.cgi?id=1274345


-- 
Miroslav Grepl
Senior Software Engineer, SELinux Solutions
Red Hat, Inc.
