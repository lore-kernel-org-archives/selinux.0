Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w85Loh8K007678
 for <selinux@tycho.nsa.gov>; Wed, 5 Sep 2018 17:50:45 -0400
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr
 [89.156.252.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 0F20A561235
 for <selinux@tycho.nsa.gov>; Wed,  5 Sep 2018 23:49:15 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Wed,  5 Sep 2018 23:49:06 +0200
Message-Id: <20180905214906.11016-2-nicolas.iooss@m4x.org>
In-Reply-To: <20180905214906.11016-1-nicolas.iooss@m4x.org>
References: <20180905214906.11016-1-nicolas.iooss@m4x.org>
Subject: [PATCH 2/2] semanage: add a missing space in ibendport help
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Currently, in:

    # semanage ibendport --help
    usage: semanage ibendport [-h] [-n] [-N] [-s STORE] [ --add -t TYPE
    -z IBDEV_NAME -r RANGE ( port ) | --delete -z IBDEV_NAME -r RANGE(
    port ) | --deleteall  | --extract  | --list -C | --modify -t TYPE -z
    IBDEV_NAME -r RANGE ( port ) ]

... a space is missing between "RANGE" and "( port )" in the usage of
--delete. Add it by splitting the string correctly in the usage line
definition.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/semanage/semanage | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/semanage/semanage b/python/semanage/semanage
index e32d1e8ad387..f4be97507c18 100644
--- a/python/semanage/semanage
+++ b/python/semanage/semanage
@@ -62,7 +62,7 @@ usage_ibpkey = "semanage ibpkey [-h] [-n] [-N] [-s STORE] ["
 usage_ibpkey_dict = {' --add': ('-t TYPE', '-x SUBNET_PREFIX', '-r RANGE', '(', 'ibpkey_name', '|', 'pkey_range', ')'), ' --modify': ('-t TYPE', '-x SUBNET_PREFIX', '-r RANGE', '(', 'ibpkey_name', '|', 'pkey_range', ')'), ' --delete': ('-x SUBNET_PREFIX', '(', 'ibpkey_name', '|', 'pkey_range', ')'), ' --list': ('-C',), ' --extract': ('',), ' --deleteall': ('',)}
 
 usage_ibendport = "semanage ibendport [-h] [-n] [-N] [-s STORE] ["
-usage_ibendport_dict = {' --add': ('-t TYPE', '-z IBDEV_NAME', '-r RANGE', '(', 'port', ')'), ' --modify': ('-t TYPE', '-z IBDEV_NAME', '-r RANGE', '(', 'port', ')'), ' --delete': ('-z IBDEV_NAME', '-r RANGE''(', 'port', ')'), ' --list': ('-C',), ' --extract': ('',), ' --deleteall': ('',)}
+usage_ibendport_dict = {' --add': ('-t TYPE', '-z IBDEV_NAME', '-r RANGE', '(', 'port', ')'), ' --modify': ('-t TYPE', '-z IBDEV_NAME', '-r RANGE', '(', 'port', ')'), ' --delete': ('-z IBDEV_NAME', '-r RANGE', '(', 'port', ')'), ' --list': ('-C',), ' --extract': ('',), ' --deleteall': ('',)}
 
 usage_node = "semanage node [-h] [-n] [-N] [-S STORE] ["
 usage_node_dict = {' --add': ('-M NETMASK', '-p PROTOCOL', '-t TYPE', '-r RANGE', 'node'), ' --modify': ('-M NETMASK', '-p PROTOCOL', '-t TYPE', '-r RANGE', 'node'), ' --delete': ('-M NETMASK', '-p PROTOCOL', 'node'), ' --list': ('-C',), ' --extract': ('',), ' --deleteall': ('',)}
-- 
2.18.0
