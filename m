Subject: Re: patch to make seobject.py work correctly.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <45A3B22E.4040502@redhat.com>
References: <45A3B22E.4040502@redhat.com>
Content-Type: text/plain
Date: Tue, 09 Jan 2007 15:16:16 -0500
Message-Id: <1168373776.7993.149.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-01-09 at 10:18 -0500, Daniel J Walsh wrote:
> This patch should be upstreamable as controversial parts removed.

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

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
