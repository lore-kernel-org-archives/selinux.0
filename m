Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8FFhZLa014094
	for <selinux@tycho.nsa.gov>; Mon, 15 Sep 2003 11:43:35 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8FFfqLY022640
	for <selinux@tycho.nsa.gov>; Mon, 15 Sep 2003 15:41:52 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h8FFfosG022630
	for <selinux@tycho.nsa.gov>; Mon, 15 Sep 2003 15:41:50 GMT
Subject: Re: Problem relabeling journalfile
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Dale Amon <amon@vnl.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <20030915152948.GC8988@vnl.com>
References: <20030915145004.GB8988@vnl.com>
	 <1063637616.13311.110.camel@moss-spartans.epoch.ncsc.mil>
	 <20030915152948.GC8988@vnl.com>
Content-Type: text/plain
Message-Id: <1063640607.13311.156.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 15 Sep 2003 11:43:27 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-09-15 at 11:29, Dale Amon wrote:
> This might be a reasonable thing to add to standard the file_contexts:
> 
> #
> # Journal files
> /.journal	<<none>>

Patch below.  Note that you should escape dot since it will otherwise be
interpreted as "any character" by the regular expression matching code,
and we should include entries for common filesystem mount points to
cover most cases, similar to the existing entries for lost+found.  We
can likely drop out the persistent label mapping entries entirely aside
from backward compatibility support for the old SELinux.

Index: policy/file_contexts/types.fc
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/file_contexts/types.fc,v
retrieving revision 1.7
diff -u -r1.7 types.fc
--- policy/file_contexts/types.fc	10 Jul 2003 14:45:07 -0000	1.7
+++ policy/file_contexts/types.fc	15 Sep 2003 15:39:07 -0000
@@ -346,6 +346,17 @@
 /usr/local/\.\.\.security(/.*)?	system_u:object_r:file_labels_t
 
 #
+# Journal files
+#
+/\.journal			<<none>>
+/usr/\.journal			<<none>>
+/boot/\.journal			<<none>>
+/home/\.journal			<<none>>
+/var/\.journal			<<none>>
+/tmp/\.journal			<<none>>
+/usr/local/\.journal		<<none>>
+
+#
 # Lost and found directories.
 #
 /lost\+found(/.*)?		system_u:object_r:lost_found_t



-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
