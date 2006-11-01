Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kA10lXl9002005
	for <selinux@tycho.nsa.gov>; Tue, 31 Oct 2006 19:47:33 -0500
Received: from atlrel7.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kA10jsKW027267
	for <selinux@tycho.nsa.gov>; Wed, 1 Nov 2006 00:45:55 GMT
Message-ID: <4547EE97.5040101@hp.com>
Date: Tue, 31 Oct 2006 19:47:19 -0500
From: Matt Anderson <mra@hp.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@tycho.nsa.gov, redhat-lspp@redhat.com,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: New MLS constraint?
References: <4533B60E.8010802@hp.com> <1161020854.26428.32.camel@sgc>
In-Reply-To: <1161020854.26428.32.camel@sgc>
Content-Type: multipart/mixed;
 boundary="------------080805070508050600070108"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080805070508050600070108
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Christopher J. PeBenito wrote:
> We could add another 'or' on the above constraint:
> 
> or ( (t2 == mlsfilewrite_in_range) and (l1 dom l2) and (h1 domby h2) )
> 
> I believe that would be the constraint you were looking for.  I don't
> like the name of that attribute, but I couldn't come up with a better
> one off the top of my head. :)
> 

Attached is a patch which I've tested against selinux-policy-2.4.2-1
that implements this additional constraint.  The name is still a bit
forced, but it works.

-matt

--------------080805070508050600070108
Content-Type: text/x-patch;
 name="writeinrange.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="writeinrange.patch"

--- policy/mls	2006-10-27 14:50:37.000000000 -0400
+++ policy/mls-	2006-10-30 10:40:40.000000000 -0500
@@ -89,6 +89,7 @@
 mlsconstrain { file lnk_file fifo_file dir chr_file blk_file sock_file } { write create setattr relabelfrom append unlink link rename mounton }
 	(( l1 eq l2 ) or
 	 (( t1 == mlsfilewritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
+         (( t2 == mlsfilewritewithinrange ) and ( l1 dom l2) and (h1 domby h2 )) or
 	 ( t1 == mlsfilewrite ) or
 	 ( t2 == mlstrustedobject ));
 
--- policy/modules/kernel/mls.te	2006-10-27 13:50:41.000000000 -0500
+++ policy/modules/kernel/mls.te-	2006-10-30 17:19:18.000000000 -0600
@@ -10,6 +10,7 @@
 attribute mlsfilereadtoclr;
 attribute mlsfilewrite;
 attribute mlsfilewritetoclr;
+attribute mlsfilewritewithinrange;
 attribute mlsfileupgrade;
 attribute mlsfiledowngrade;
 
--- policy/modules/kernel/mls.if	2006-10-30 12:07:32.000000000 -0500
+++ policy/modules/kernel/mls.if-	2006-10-30 12:07:22.000000000 -0500
@@ -470,3 +470,24 @@
 
 	typeattribute $1 mlstranslate;
 ')
+
+########################################
+## <summary>
+##	Make specified domain trusted to
+##	be written to within its MLS range.
+##	The subject's MLS range must be a
+##	proper subset of the object's MLS range.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`mls_file_write_within_range',`
+	gen_require(`
+		attribute mlsfilewritewithinrange;
+	')
+
+	typeattribute $1 mlsfilewritewithinrange;
+')
--- policy/modules/services/cups.te    2006-10-30 14:41:21.000000000 -0500
+++ policy/modules/services/cups.te-   2006-10-30 14:59:54.000000000 -0500
@@ -223,6 +223,7 @@
 	mls_fd_use_all_levels(cupsd_t)
 	mls_file_downgrade(cupsd_t)
 	mls_file_write_down(cupsd_t)
+        mls_file_write_within_range(printer_device_t)
 	mls_file_read_up(cupsd_t)
 	mls_rangetrans_target(cupsd_t)
 	mls_socket_write_all_levels(cupsd_t)

--------------080805070508050600070108--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
