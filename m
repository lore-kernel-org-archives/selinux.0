Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k27NDBkD009418
	for <selinux@tycho.nsa.gov>; Tue, 7 Mar 2006 18:13:11 -0500
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k27NBbVk028124
	for <selinux@tycho.nsa.gov>; Tue, 7 Mar 2006 23:11:38 GMT
Subject: Patch to add a "netuser" role and user
From: Erich Schubert <erich@debian.org>
To: SE Linux <selinux@tycho.nsa.gov>, cpebenito@tresys.com
Content-Type: multipart/mixed; boundary="=-7hJwGkk6hFwzKbTQ1K+b"
Date: Wed, 08 Mar 2006 00:13:09 +0100
Message-Id: <1141773189.5082.39.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-7hJwGkk6hFwzKbTQ1K+b
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,
the following patch adds a "netuser" user and role.
This is pretty much the same to user_u/user_r/user_t
except that these users can bind non-privileged tcp ports
(like user_u with the user_tcp_server boolean, no ssh port forwarding
though)

Maybe this patch (when reviewed) could serve as an example on how to add
new user roles?

best regards,
Erich Schubert
--=20
   erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
     This one's tricky. You have to use imaginary numbers, like     //\
                      eleventeen... --- Hobbes                      V_/_
   Jede Frau erwartet von einem Mann, dass er h=E4lt, was sie sich
                         von ihm verspricht.

--=-7hJwGkk6hFwzKbTQ1K+b
Content-Disposition: attachment; filename=netuser-diff
Content-Type: text/x-patch; name=netuser-diff; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Index: policy/rolemap
===================================================================
--- policy/rolemap	(Revision 26)
+++ policy/rolemap	(Arbeitskopie)
@@ -12,6 +12,7 @@
 	user_r user user_t
 	staff_r staff staff_t
 	sysadm_r sysadm sysadm_t
+	netuser_r netuser netuser_t
 
 	ifdef(`enable_mls',`
 		secadm_r secadm secadm_t
Index: policy/users
===================================================================
--- policy/users	(Revision 26)
+++ policy/users	(Arbeitskopie)
@@ -29,6 +29,7 @@
 gen_user(user_u, user, user_r sysadm_r system_r, s0, s0 - s15:c0.c255, c0.c255)
 ',`
 gen_user(user_u, user, user_r, s0, s0)
+gen_user(netuser_u, netuser, netuser_r, s0, s0)
 gen_user(staff_u, staff, staff_r sysadm_r ifdef(`enable_mls',`secadm_r'), s0, s0 - s15:c0.c255, c0.c255)
 gen_user(sysadm_u, sysadm, sysadm_r, s0, s0 - s15:c0.c255, c0.c255)
 ')
Index: policy/modules/system/userdomain.te
===================================================================
--- policy/modules/system/userdomain.te	(Revision 41)
+++ policy/modules/system/userdomain.te	(Arbeitskopie)
@@ -117,12 +117,19 @@
 	admin_user_template(sysadm)
 	unpriv_user_template(staff)
 	unpriv_user_template(user)
+	network_user_template(netuser)
 
 	# user role change rules:
 	# sysadm_r can change to user roles
 	role_change(sysadm, user)
 	role_change(sysadm, staff)
 
+	# netuser is rather flexible
+	role_change(sysadm, netuser)
+	role_change(staff, netuser)
+	role_change(netuser, user)
+	role_change(user, netuser)
+
 	# only staff_r can change to sysadm_r
 	role_change(staff, sysadm)
 
Index: policy/modules/system/userdomain.if
===================================================================
--- policy/modules/system/userdomain.if	(Revision 41)
+++ policy/modules/system/userdomain.if	(Arbeitskopie)
@@ -725,6 +725,38 @@
 
 #######################################
 ## <summary>
+##	The template for creating a user with network access.
+## </summary>
+## <desc>
+##	<p>
+##	This template creates a user domain, types, and
+##	rules for the user's tty, pty, home directories,
+##	tmp, and tmpfs files.
+##	</p>
+##	<p>
+##	This differs from the unpriv_user_template by allowing non-privileged network access.
+##	</p>
+## </desc>
+## <param name="userdomain_prefix">
+##	<summary>
+##	The prefix of the user domain (e.g., sysadm
+##	is the prefix for sysadm_t).
+##	</summary>
+## </param>
+#
+template(`network_user_template',`
+	##############################
+	#
+	# Declarations
+	#
+
+	# Inherit rules for ordinary users.
+	unpriv_user_template($1)
+	# like user_tcp_server
+	corenet_tcp_bind_generic_port($1_t)
+')
+#######################################
+## <summary>
 ##	The template for creating an administrative user.
 ## </summary>
 ## <desc>

--=-7hJwGkk6hFwzKbTQ1K+b--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
