Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBSLSr6R020625
	for <selinux@tycho.nsa.gov>; Fri, 28 Dec 2007 16:28:53 -0500
Received: from fg-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBSLSqSj027575
	for <selinux@tycho.nsa.gov>; Fri, 28 Dec 2007 21:28:53 GMT
Received: by fg-out-1718.google.com with SMTP id 16so1649298fgg.40
        for <selinux@tycho.nsa.gov>; Fri, 28 Dec 2007 13:28:39 -0800 (PST)
Message-ID: <cadfc0e40712281328m7f13fe70i7b9fdbfca9f19606@mail.gmail.com>
Date: Fri, 28 Dec 2007 15:28:39 -0600
From: "Xavier Toth" <txtoth@gmail.com>
To: "SE Linux" <selinux@tycho.nsa.gov>
Subject: mls policy dbus patch
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- serefpolicy-3.0.8/policy/mls        2007-11-27 14:43:26.000000000 -0600
+++ serefpolicy-3.0.8.new/policy/mls    2007-12-21 14:38:52.000000000 -0600
@@ -584,7 +584,11 @@
 #

 # these access vectors have no MLS restrictions
-# dbus { acquire_svc send_msg }
+# dbus { acquire_svc }
+mlsconstrain dbus { send_msg }
+        (( l1 eq l2 ) or
+         ( t1 == mlsdbussend ) or
+         ( t2 == mlsdbusrecv ));



--- serefpolicy-3.0.8/policy/modules/kernel/mls.te      2007-11-27
14:43:26.000000000 -0600
+++ serefpolicy-3.0.8.new/policy/modules/kernel/mls.te  2007-12-21
14:35:30.000000000 -0600
@@ -61,3 +61,6 @@
 attribute mlsfdshare;

 attribute mlstranslate;
+
+attribute mlsdbusrecv;
+attribute mlsdbussend;
--- serefpolicy-3.0.8/policy/modules/kernel/mls.if      2007-11-27
14:43:26.000000000 -0600
+++ serefpolicy-3.0.8.new/policy/modules/kernel/mls.if  2007-12-21
14:37:31.000000000 -0600
@@ -859,3 +859,42 @@

        typeattribute $1 mlsdbdowngrade;
 ')
+########################################
+## <summary>
+##      Make specified domain MLS trusted
+##      for send to dbus.
+## </summary>
+## <param name="domain">
+##      <summary>
+##      Domain allowed access.
+##      </summary>
+## </param>
+## <rolecap/>
+#
+interface(`mls_dbus_send',`
+       gen_require(`
+               attribute mlsdbussend;
+       ')
+
+       typeattribute $1 mlsdbussend;
+')
+
+########################################
+## <summary>
+##      Make specified domain MLS trusted
+##      for receiving from dbus.
+## </summary>
+## <param name="domain">
+##      <summary>
+##      Domain allowed access.
+##      </summary>
+## </param>
+## <rolecap/>
+#
+interface(`mls_dbus_recv',`
+       gen_require(`
+               attribute mlsdbusrecv;
+       ')
+
+       typeattribute $1 mlsdbusrecv;
+')

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
