Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uB6EwdR8014986
 for <selinux@tycho.nsa.gov>; Tue, 6 Dec 2016 09:58:39 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
 (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 95BD33D8
 for <selinux@tycho.nsa.gov>; Tue,  6 Dec 2016 14:58:36 +0000 (UTC)
Received: from Thinkpad_450.brq.redhat.com ([10.40.3.114])
 by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 uB6EwZQ7026747
 for <selinux@tycho.nsa.gov>; Tue, 6 Dec 2016 09:58:36 -0500
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] python/sepolicy/sepolicy/gui: Reflect sepolicy changes into
 gui
Date: Tue,  6 Dec 2016 15:58:32 +0100
Message-Id: <1481036313-11915-1-git-send-email-vmojzis@redhat.com>
In-Reply-To: <15202ae0-3133-0a2e-950c-1d4bf59c4eb9@redhat.com>
References: <15202ae0-3133-0a2e-950c-1d4bf59c4eb9@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This patch should get sepolicy gui working again, however it's still unusable due to SETools-4 speed (initial policy analysis takes a few hours at this point, but can be significantly optimised).
