Message-ID: <4564ADE1.4060202@redhat.com>
Date: Wed, 22 Nov 2006 15:06:57 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: More  small fixes to policycoreutils
References: <6FE441CD9F0C0C479F2D88F959B015885C7D9F@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015885C7D9F@exchange.columbia.tresys.com>
Content-Type: multipart/mixed;
 boundary="------------010408000107090807070507"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010408000107090807070507
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fix handling of translations in python correctly.

Fix rewrite of the translations library not to insert extra lines.

--------------010408000107090807070507
Content-Type: text/x-patch;
 name="seobject.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="seobject.diff"

diff --exclude-from=exclude --exclude='*.po' --exclude='*.pot' -N -u -r nsapolicycoreutils/semanage/seobject.py policycoreutils-1.33.4/semanage/seobject.py
--- nsapolicycoreutils/semanage/seobject.py	2006-11-16 17:14:26.000000000 -0500
+++ policycoreutils-1.33.4/semanage/seobject.py	2006-11-22 14:11:25.000000000 -0500
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
-	(rc, trans) = selinux.selinux_raw_to_trans_context(context)
+ 	(rc, trans) = selinux.selinux_raw_to_trans_context(context)
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

--------------010408000107090807070507--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
