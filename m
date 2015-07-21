Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6L0cScS011402
 for <selinux@tycho.nsa.gov>; Mon, 20 Jul 2015 20:38:29 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
 (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
 by mx1.redhat.com (Postfix) with ESMTPS id D2C62A0BAE
 for <selinux@tycho.nsa.gov>; Tue, 21 Jul 2015 00:38:26 +0000 (UTC)
Received: from msrb-laptop.redhat.com (vpn1-4-186.ams2.redhat.com
 [10.36.4.186])
 by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 t6L0cOdB022792
 for <selinux@tycho.nsa.gov>; Mon, 20 Jul 2015 20:38:25 -0400
From: Michal Srb <msrb@redhat.com>
To: selinux@tycho.nsa.gov
Subject: Improve Python 3 support in policycoreutils
Date: Tue, 21 Jul 2015 02:38:18 +0200
Message-Id: <1437439102-9911-1-git-send-email-msrb@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


Hello,

These patches try to add Python 3 support to the following places under policycoreutils/:

audit2allow/
sandbox/
scripts/
semanage/ (except seobject.py)

Patch for the seobject.py should follow later.

Thanks
Michal
