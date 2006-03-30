From: James Athey <jathey@tresys.com>
To: SELinux@tycho.nsa.gov
Subject: [PATCH] typo fix for corenetwork.if.m4
Date: Thu, 30 Mar 2006 13:31:18 -0500
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_2PCLEq8uK3pi3Du"
Message-Id: <200603301331.18106.jathey@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_2PCLEq8uK3pi3Du
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The generated interfaces for netifs in corenetwork.if.m4 have a typo in 
corenet_raw_sendrecv_$1_if, where

corenet_raw_send_$1(dollarsone)
corenet_raw_receive_$1(dollarsone)

should read

corenet_raw_send_$1_if(dollarsone)
corenet_raw_receive_$1_if(dollarsone)

A patch is attached.

~James Athey


--Boundary-00=_2PCLEq8uK3pi3Du
Content-Type: text/x-diff;
  charset="us-ascii";
  name="corenetwork.if.m4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="corenetwork.if.m4.patch"

Index: policy/modules/kernel/corenetwork.if.m4
===================================================================
--- policy/modules/kernel/corenetwork.if.m4	(revision 1654)
+++ policy/modules/kernel/corenetwork.if.m4	(working copy)
@@ -139,8 +139,8 @@
 ## <infoflow type="both" weight="10"/>
 #
 interface(`corenet_raw_sendrecv_$1_if',`
-	corenet_raw_send_$1(dollarsone)
-	corenet_raw_receive_$1(dollarsone)
+	corenet_raw_send_$1_if(dollarsone)
+	corenet_raw_receive_$1_if(dollarsone)
 ')
 '') dnl end create_netif_interfaces

--Boundary-00=_2PCLEq8uK3pi3Du--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
