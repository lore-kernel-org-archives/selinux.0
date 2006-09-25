Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8PI6jcl021659
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 14:06:45 -0400
Received: from atlrel6.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8PI5gAk023402
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 18:05:42 GMT
Message-Id: <20060925180642.032407000@hp.com>
References: <20060925180412.715069000@hp.com>
Date: Mon, 25 Sep 2006 14:04:17 -0400
From: paul.moore@hp.com
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Cc: tgraf@suug.ch, jmorris@redhat.com, sds@epoch.ncsc.mil,
        Paul Moore <paul.moore@hp.com>
Subject: [PATCH v2 5/8] Netlink: add nla_validate_nested()
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add a new function, nla_validate_nested(), to validate nested Netlink
attributes.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 include/net/netlink.h |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+)

Index: net-2.6.19/include/net/netlink.h
===================================================================
--- net-2.6.19.orig/include/net/netlink.h
+++ net-2.6.19/include/net/netlink.h
@@ -146,6 +146,7 @@
  *   nla_ok(nla, remaining)		does nla fit into remaining bytes?
  *   nla_next(nla, remaining)		get next netlink attribute
  *   nla_validate()			validate a stream of attributes
+ *   nla_validate_nested()		validate a stream of nested attributes
  *   nla_find()				find attribute in stream of attributes
  *   nla_find_nested()			find attribute in nested attributes
  *   nla_parse()			parse and validate stream of attrs
@@ -951,6 +952,24 @@ static inline int nla_nest_cancel(struct
 }
 
 /**
+ * nla_validate_nested - Validate a stream of nested attributes
+ * @start: container attribute
+ * @maxtype: maximum attribute type to be expected
+ * @policy: validation policy
+ *
+ * Validates all attributes in the nested attribute stream against the
+ * specified policy. Attributes with a type exceeding maxtype will be
+ * ignored. See documenation of struct nla_policy for more details.
+ *
+ * Returns 0 on success or a negative error code.
+ */
+static inline int nla_validate_nested(struct nlattr *start, int maxtype,
+				      struct nla_policy *policy)
+{
+	return nla_validate(nla_data(start), nla_len(start), maxtype, policy);
+}
+
+/**
  * nla_for_each_attr - iterate over a stream of attributes
  * @pos: loop counter, set to current attribute
  * @head: head of attribute stream

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
