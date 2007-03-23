Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2NJG9L1005602
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 15:16:09 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2NJG8sr004278
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 19:16:08 GMT
Message-ID: <46042767.8050508@redhat.com>
Date: Fri, 23 Mar 2007 15:15:51 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Samba guys reviewed samba policy and fixed some of the ports used
 by samba
Content-Type: multipart/mixed;
 boundary="------------030703070906060908080001"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030703070906060908080001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Also added new ports for squid.

--------------030703070906060908080001
Content-Type: text/x-patch;
 name="corenet_port_type.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="corenet_port_type.patch"

--- nsaserefpolicy/policy/modules/kernel/corenetwork.if.in	2007-02-19 11:32:51.000000000 -0500
+++ serefpolicy-2.5.10/policy/modules/kernel/corenetwork.if.in	2007-03-22 15:06:58.000000000 -0400
@@ -1977,3 +1977,57 @@
 
 	typeattribute $1 corenet_unconfined_type;
 ')
+
+########################################
+## <summary>
+##	Define type to be a network port type
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Type to be used for network ports.
+##	</summary>
+## </param>
+#
+interface(`corenet_port_type',`
+	gen_require(`
+		attribute port_type;
+	')
+
+	typeattribute $1 port_type;
+')
+
+########################################
+## <summary>
+##	Define network type to be a reserved port (lt 1024) 
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Type to be used for network ports.
+##	</summary>
+## </param>
+#
+interface(`corenet_reserved_port_type',`
+	gen_require(`
+		attribute reserved_port_type;
+	')
+
+	typeattribute $1 reserved_port_type;
+')
+
+########################################
+## <summary>
+##	Define network type to be a rpc port ( 512 lt PORT lt 1024) 
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Type to be used for network ports.
+##	</summary>
+## </param>
+#
+interface(`corenet_rpc_port_type',`
+	gen_require(`
+		attribute rpc_port_type;
+	')
+
+	typeattribute $1 rpc_port_type;
+')

--------------030703070906060908080001--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
