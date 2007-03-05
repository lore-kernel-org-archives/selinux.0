Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l25EgGPi011875
	for <selinux@tycho.nsa.gov>; Mon, 5 Mar 2007 09:42:16 -0500
Received: from wx-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l25EhfFQ009384
	for <selinux@tycho.nsa.gov>; Mon, 5 Mar 2007 14:43:41 GMT
Received: by wx-out-0506.google.com with SMTP id s17so1822715wxc
        for <selinux@tycho.nsa.gov>; Mon, 05 Mar 2007 06:43:41 -0800 (PST)
Message-ID: <45EC2C10.6050603@kaigai.gr.jp>
Date: Mon, 05 Mar 2007 23:41:20 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: cpebenito@tresys.com
Subject: Re: [ANN] SE-PostgreSQL 8.2.3-1.0 alpha release
References: <45EC0D21.2070706@kaigai.gr.jp>
In-Reply-To: <45EC0D21.2070706@kaigai.gr.jp>
Content-Type: multipart/mixed;
 boundary="------------010509040709020800040501"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010509040709020800040501
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Hello,

The attached patch adds new object classes, access vectors and
booleans related to database.
SE-PostgreSQL uses them to manage the various kinds of database
objects such as tables, columns, tuples and so on.

The most of security policies are provided as a binary security
policy within RPM package. But it requires the definition of new
object classes, access vectors and booleans in the base policy.

Please apply it.

BTW, SE-PostgreSQL does 'semodule -i' in the %post section of RPM
installation script after a verification whether an older version
of sepostgresql.pp has been already installed, or not.
I think the description of script can become easier, if semodule
has 'install or upgrade if older version was installed' option.
How is the idea?
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--------------010509040709020800040501
Content-Type: text/x-patch;
 name="policy-sepgsql.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policy-sepgsql.patch"

Index: refpolicy/policy/flask/security_classes
===================================================================
--- refpolicy/policy/flask/security_classes	(revision 2204)
+++ refpolicy/policy/flask/security_classes	(working copy)
@@ -97,4 +97,12 @@
 
 class dccp_socket
 
+# SE-PostgreSQL relation
+class database			# userspace
+class table			# userspace
+class procedure			# userspace
+class column			# userspace
+class tuple			# userspace
+class blob			# userspace
+
 # FLASK
Index: refpolicy/policy/flask/access_vectors
===================================================================
--- refpolicy/policy/flask/access_vectors	(revision 2204)
+++ refpolicy/policy/flask/access_vectors	(working copy)
@@ -80,6 +80,20 @@
 }
 
 #
+#  Define a common prefix for userspace database object access vectors.
+#
+
+common database
+{
+	create
+	drop
+	getattr
+	setattr
+	relabelfrom
+	relabelto
+}
+
+#
 # Define the access vectors.
 #
 # class class_name [ inherits common_name ] { permission_name ... }
@@ -648,3 +662,58 @@
 	node_bind
 	name_connect
 }
+
+# definition for SE-PostgreSQL
+class database
+inherits database
+{
+	access
+	install_module
+	load_module
+	get_param
+	set_param
+}
+
+class table
+inherits database
+{
+	select
+	update
+	insert
+	delete
+	lock
+}
+
+class procedure
+inherits database
+{
+	execute
+	entrypoint
+}
+
+class column
+inherits database
+{
+	select
+	update
+	insert
+}
+
+class tuple
+{
+	relabelfrom
+	relabelto
+	select
+	update
+	insert
+	delete
+}
+
+class blob
+inherits database
+{
+	read
+	write
+	import
+	export
+}
Index: refpolicy/policy/mcs
===================================================================
--- refpolicy/policy/mcs	(revision 2204)
+++ refpolicy/policy/mcs	(working copy)
@@ -98,4 +98,28 @@
 mlsconstrain process { sigkill sigstop }
 	(( h1 dom h2 ) or ( t1 == mcskillall ));
 
+# MCS policy for SE-PostgreSQL
+#-------------------------------
+
+# Any database object must be dominated by the relabeling subject
+# clearance, also the objects are single-level.
+mlsconstrain { database table procedure column blob } { create relabelto }
+	((h1 dom h2) and ( l1 domby h2 ) and ( l2 eq h2 ));
+mlsconstrain tuple { insert relabelto }
+	(( h1 dom h2 ) and ( l1 domby h2 ) and ( l2 eq h2 ));
+
+# Access control for any database objects based on MCS rules.
+mlsconstrain database { drop setattr relabelfrom access install_module load_module get_param set_param }
+	( h1 dom h2 );
+mlsconstrain table { drop setattr relabelfrom select update insert delete }
+	( h1 dom h2 );
+mlsconstrain column { drop setattr relabelfrom select update insert }
+	( h1 dom h2 );
+mlsconstrain tuple { relabelfrom select update delete }
+	( h1 dom h2 );
+mlsconstrain procedure { execute }
+	( h1 dom h2 );
+mlsconstrain blob { drop setattr relabelfrom read write }
+	( h1 dom h2 );
+
 ') dnl end enable_mcs
Index: refpolicy/policy/global_tunables
===================================================================
--- refpolicy/policy/global_tunables	(revision 2204)
+++ refpolicy/policy/global_tunables	(working copy)
@@ -11,6 +11,27 @@
 
 ## <desc>
 ## <p>
+## Enable to output SE-PostgreSQL allowed audit message
+## </p>
+## </desc>
+gen_tunable(sepgsql_enable_auditallow, false)
+
+## <desc>
+## <p>
+## Disable to output SE-PostgreSQL denied audit messages
+## </p>
+## </desc>
+gen_tunable(sepgsql_enable_auditdeny, true)
+
+## <desc>
+## <p>
+## Disable to output SE-PostgreSQL audit message per tuple
+## </p>
+## </desc>
+gen_tunable(sepgsql_enable_audittuple, false)
+
+## <desc>
+## <p>
 ## Allow cvs daemon to read shadow
 ## </p>
 ## </desc>

--------------010509040709020800040501--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
