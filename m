Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l09FHGuB008003
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 10:17:16 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l09FI4eY017028
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 15:18:05 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l09FI4D3005600
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 10:18:04 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l09FI3GQ003089
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 10:18:03 -0500
Received: from [10.12.32.53] (redsox.boston.devel.redhat.com [10.12.32.53])
	by mail.boston.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l09FI3cZ003262
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 10:18:03 -0500
Message-ID: <45A3B22E.4040502@redhat.com>
Date: Tue, 09 Jan 2007 10:18:06 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: patch to make seobject.py work correctly.
Content-Type: multipart/mixed;
 boundary="------------040708010502090704070300"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040708010502090704070300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch should be upstreamable as controversial parts removed.

--------------040708010502090704070300
Content-Type: text/x-patch;
 name="policycoreutils-seobject.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-seobject.patch"

--- nsapolicycoreutils/semanage/seobject.py	2007-01-09 09:06:59.000000000 -0500
+++ policycoreutils-1.33.10/semanage/seobject.py	2007-01-09 10:09:19.000000000 -0500
@@ -94,23 +94,25 @@
 	return re.search("^" + reg +"$",raw)
 
 def translate(raw, prepend = 1):
-	if prepend == 1:
-		context = "a:b:c:%s" % raw
+        filler="a:b:c:"
+        if prepend == 1:
+		context = "%s%s" % (filler,raw)
 	else:
 		context = raw
 	(rc, trans) = selinux.selinux_raw_to_trans_context(context)
 	if rc != 0:
 		return raw
 	if prepend:
-		trans = trans.strip("a:b:c")
+		trans = trans[len(filler):]
 	if trans == "":
 		return raw
 	else:
 		return trans
 	
 def untranslate(trans, prepend = 1):
+        filler="a:b:c:"
  	if prepend == 1:
-		context = "a:b:c:%s" % trans
+		context = "%s%s" % (filler,trans)
 	else:
 		context = trans
 
@@ -118,7 +120,7 @@
 	if rc != 0:
 		return trans
 	if prepend:
-		raw = raw.strip("a:b:c")	
+		raw = raw[len(filler):]
 	if raw == "":
 		return trans
 	else:
@@ -157,7 +159,7 @@
 	def out(self):
 		rec = ""
 		for c in self.comments:
-			rec += c +"\n"
+			rec += c
 		keys = self.ddict.keys()
 		keys.sort()
 		for k in keys:

--------------040708010502090704070300--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
