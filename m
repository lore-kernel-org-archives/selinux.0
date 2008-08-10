Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7A1T151015634
	for <selinux@tycho.nsa.gov>; Sat, 9 Aug 2008 21:29:01 -0400
Received: from sender-02.it.helsinki.fi (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7A1Sn2t015423
	for <selinux@tycho.nsa.gov>; Sun, 10 Aug 2008 01:28:50 GMT
Received: from ruuvi.it.helsinki.fi (ruuvi.it.helsinki.fi [128.214.205.65])
	by sender-02.it.helsinki.fi (8.13.8/8.13.8) with ESMTP id m7A1SmrM017633
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Sun, 10 Aug 2008 04:28:48 +0300
Received: from ruuvi.it.helsinki.fi (localhost.localdomain [127.0.0.1])
	by ruuvi.it.helsinki.fi (8.13.1/8.13.1) with ESMTP id m7A1SmO9009747
	for <selinux@tycho.nsa.gov>; Sun, 10 Aug 2008 04:28:48 +0300
Received: from localhost (vmkari@localhost)
	by ruuvi.it.helsinki.fi (8.13.1/8.13.1/Submit) with ESMTP id m7A1Slqw009744
	for <selinux@tycho.nsa.gov>; Sun, 10 Aug 2008 04:28:48 +0300
Date: Sun, 10 Aug 2008 04:28:47 +0300 (EEST)
From: Vesa-Matti J Kari <vmkari@cc.helsinki.fi>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH] selinux: conditional expression type validation was
 off-by-one
In-Reply-To: <Pine.LNX.4.64L.0808081307500.24884@ruuvi.it.helsinki.fi>
Message-ID: <Pine.LNX.4.64L.0808100425170.9655@ruuvi.it.helsinki.fi>
References: <200808061546.m76Fkwq1005199@ruuvi.it.helsinki.fi>
 <alpine.LRH.1.10.0808070945400.15561@tundra.namei.org>
 <Pine.LNX.4.64L.0808081307500.24884@ruuvi.it.helsinki.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


This is the same off-by-one bug that was already fixed in the kernel.
(According to my understanding neither of these bugs has security
implications)

Signed-off-by: Vesa-Matti Kari <vmkari@cc.helsinki.fi>
---

 include/sepol/policydb/conditional.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
Index: libsepol/include/sepol/policydb/conditional.h
===================================================================
--- libsepol/include/sepol/policydb/conditional.h	(revision 2950)
+++ libsepol/include/sepol/policydb/conditional.h	(working copy)
@@ -48,7 +48,7 @@
 #define COND_XOR	5	/* bool ^ bool */
 #define COND_EQ		6	/* bool == bool */
 #define COND_NEQ	7	/* bool != bool */
-#define COND_LAST	8
+#define COND_LAST	COND_NEQ
 	uint32_t expr_type;
 	uint32_t bool;
 	struct cond_expr *next;

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
