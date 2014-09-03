Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s83Hwqwm028102
 for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2014 13:58:52 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
 (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s83HwsIu030933
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2014 13:58:54 -0400
Subject: [PATCH] selinux: fix a problem with IPv6 traffic denials in
 selinux_ip_postroute()
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Wed, 03 Sep 2014 13:58:52 -0400
Message-ID: <20140903175852.10236.79433.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Florian Westphal <fwestpha@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

A previous commit c0828e50485932b7e019df377a6b0a8d1ebd3080 ("selinux:
process labeled IPsec TCP SYN-ACK packets properly in
selinux_ip_postroute()") mistakenly left out a 'break' from a switch
statement which caused problems with IPv6 traffic.

Thanks to Florian Westphal for reporting and debugging the issue.

Reported-by: Florian Westphal <fwestpha@redhat.com>
Signed-off-by: Paul Moore <pmoore@redhat.com>
---
 security/selinux/hooks.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6c90d49..e1e0827 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4993,6 +4993,7 @@ static unsigned int selinux_ip_postroute(struct sk_buff *skb, int ifindex,
 			case PF_INET6:
 				if (IP6CB(skb)->flags & IP6SKB_XFRM_TRANSFORMED)
 					return NF_ACCEPT;
+				break;
 			default:
 				return NF_DROP_ERR(-ECONNREFUSED);
 			}
