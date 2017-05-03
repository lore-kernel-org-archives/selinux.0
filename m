Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v43AUrfJ029545
 for <selinux@tycho.nsa.gov>; Wed, 3 May 2017 06:30:54 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 08B91C04B32C
 for <selinux@tycho.nsa.gov>; Wed,  3 May 2017 10:30:53 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 04/19] sepolicy: Move svirt man page out of libvirt into its
 own
Date: Wed,  3 May 2017 12:30:21 +0200
Message-Id: <20170503103036.17514-5-plautrba@redhat.com>
In-Reply-To: <20170503103036.17514-1-plautrba@redhat.com>
References: <20170503103036.17514-1-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Dan Walsh <dwalsh@redhat.com>

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/sepolicy/sepolicy/manpage.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/sepolicy/sepolicy/manpage.py b/python/sepolicy/sepolicy/manpage.py
index b268680a..4cebb299 100755
--- a/python/sepolicy/sepolicy/manpage.py
+++ b/python/sepolicy/sepolicy/manpage.py
@@ -37,7 +37,7 @@ typealias_types = {
 "httpd_t":("phpfpm_t"),
 }
 
-equiv_dict = {"smbd": ["samba"], "httpd": ["apache"], "virtd": ["virt", "libvirt", "svirt", "svirt_tcg", "svirt_lxc_t", "svirt_lxc_net_t"], "named": ["bind"], "fsdaemon": ["smartmon"], "mdadm": ["raid"]}
+equiv_dict = {"smbd": ["samba"], "httpd": ["apache"], "virtd": ["virt", "libvirt"], "named": ["bind"], "fsdaemon": ["smartmon"], "mdadm": ["raid"]}
 
 equiv_dirs = ["/var"]
 modules_dict = None
-- 
2.12.2
