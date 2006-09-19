Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8JLSxXB024377
	for <selinux@tycho.nsa.gov>; Tue, 19 Sep 2006 17:28:59 -0400
Received: from e31.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8JLSTL7022337
	for <selinux@tycho.nsa.gov>; Tue, 19 Sep 2006 21:28:29 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8JLSuiR011236
	for <selinux@tycho.nsa.gov>; Tue, 19 Sep 2006 17:28:56 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k8JLStT0221848
	for <selinux@tycho.nsa.gov>; Tue, 19 Sep 2006 15:28:56 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k8JLStXZ027906
	for <selinux@tycho.nsa.gov>; Tue, 19 Sep 2006 15:28:55 -0600
Date: Tue, 19 Sep 2006 16:17:20 -0500
From: Joy Latten <latten@austin.ibm.com>
Message-Id: <200609192117.k8JLHKIC013043@faith.austin.ibm.com>
To: netdev@vger.kernel.org, redhat-lspp@redhat.com, selinux@tycho.nsa.gov
Subject: ipsec acquire has security context although I am not using it.
Cc: davem@davemloft.net, jmorris@namei.org
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


When using ipsec while selinux is enabled in my kernel, 
my racoon daemon fails to establish an SA. I believe the
ACQUIRE sent from kernel has a security context although I 
am not using this feature with ipsec. As a result, racoon
fails to establish the SA, because it is looking for a policy
with security context. I noticed the security context contains garbage. 

I am using a pseries, power5, ppc64 box, and it appears
that since policy->security structure is not really initialized
or zero'd out when not using, it is possible it may contain garbage
on my pseries and a call such as "if (policy->security)" may 
come back as true such that security context is included in
my acquire message although I believe it should not be. 

Hopefully, the below patch is acceptable. I have compiled and
tested it.

Regards,
Joy Latten


diff -urpN linux-2.6.17.orig/net/xfrm/xfrm_policy.c linux-2.6.17.patch/net/xfrm/xfrm_policy.c
--- linux-2.6.17.orig/net/xfrm/xfrm_policy.c	2006-09-19 02:11:33.000000000 -0500
+++ linux-2.6.17.patch/net/xfrm/xfrm_policy.c	2006-09-19 04:33:50.000000000 -0500
@@ -319,6 +319,7 @@ struct xfrm_policy *xfrm_policy_alloc(gf
 		init_timer(&policy->timer);
 		policy->timer.data = (unsigned long)policy;
 		policy->timer.function = xfrm_policy_timer;
+		policy->security = NULL;
 	}
 	return policy;
 }

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
