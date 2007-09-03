Subject: Re: [PATCH] Suppress rule generation for dontaudit rules
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Joshua Brindle <method@manicmethod.com>, selinux@tycho.nsa.gov
In-Reply-To: <1188390605.26572.143.camel@moss-spartans.epoch.ncsc.mil>
References: <2ad2d21fc72476558d8f.1187187301@localhost.localdomain>
	 <1187289925.909.75.camel@moss-spartans.epoch.ncsc.mil>
	 <46C4A449.9010102@manicmethod.com>
	 <1187875363.1451.475.camel@moss-spartans.epoch.ncsc.mil>
	 <1187971210.6753.4.camel@localhost.localdomain>
	 <1188390605.26572.143.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 03 Sep 2007 12:18:11 -0400
Message-Id: <1188836291.2876.12.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-08-29 at 08:30 -0400, Stephen Smalley wrote:
> On Fri, 2007-08-24 at 12:00 -0400, Karl MacMillan wrote:
> > On Thu, 2007-08-23 at 09:22 -0400, Stephen Smalley wrote:
> > > On Thu, 2007-08-16 at 15:23 -0400, Joshua Brindle wrote:
> > > > Stephen Smalley wrote:
> > > > > On Wed, 2007-08-15 at 10:15 -0400, Karl MacMillan wrote:
> > > > >   
> > > > >> The current policy generation code incorrectly generates allow rules for dontaudit messages. This patch fixes that.
> > > > >>
> > [...]
> > > > 
> > > > Merged into 1.0.9
> > > 
> > > Reverted.  Didn't work.
> > > 
> > 
> > That's because it was wildly wrong - I thought I tested that, but I
> > guess not. Correct patch below:
> > 
> > 
> > diff -r e962f4f773fc sepolgen/src/sepolgen/audit.py
> > --- a/sepolgen/src/sepolgen/audit.py	Wed Aug 22 15:55:24 2007 -0400
> > +++ b/sepolgen/src/sepolgen/audit.py	Thu Aug 23 15:11:09 2007 -0400
> > @@ -421,6 +421,8 @@ class AuditParser:
> >          """
> >          av_set = access.AccessVectorSet()
> >          for avc in self.avc_msgs:
> > +            if avc.denial == True:
> > +                continue
> >              if avc_filter:
> >                  if avc_filter.filter(avc):
> >                      av_set.add(avc.scontext.type, avc.tcontext.type, avc.tclass,
> > 
> > Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>
> 
> Causes all avc messages to be discarded, yielding no output from
> audit2allow -a (with a number of avc messages in audit.log).  NAK.
> Third time's the charm?
> 

We can hope - this version includes a test. If this isn't right someone
else will have to fix this bug.

Suppress rule generation for dontaudit rules.

The current policy generation code incorrectly generates allow rules for dontaudit messages. This patch fixes that.

diff -r e962f4f773fc sepolgen/src/sepolgen/audit.py
--- a/sepolgen/src/sepolgen/audit.py	Wed Aug 22 15:55:24 2007 -0400
+++ b/sepolgen/src/sepolgen/audit.py	Wed Aug 29 16:01:09 2007 -0400
@@ -402,7 +402,7 @@ class AuditParser:
             self.__parse(l)
         self.__post_process()
 
-    def to_access(self, avc_filter=None):
+    def to_access(self, avc_filter=None, only_denials=True):
         """Convert the audit logs access into a an access vector set.
 
         Convert the audit logs into an access vector set, optionally
@@ -421,6 +421,8 @@ class AuditParser:
         """
         av_set = access.AccessVectorSet()
         for avc in self.avc_msgs:
+            if avc.denial != True and only_denials:
+                continue
             if avc_filter:
                 if avc_filter.filter(avc):
                     av_set.add(avc.scontext.type, avc.tcontext.type, avc.tclass,
diff -r e962f4f773fc sepolgen/tests/test_audit.py
--- a/sepolgen/tests/test_audit.py	Wed Aug 22 15:55:24 2007 -0400
+++ b/sepolgen/tests/test_audit.py	Mon Sep 03 11:49:09 2007 -0400
@@ -46,6 +46,8 @@ type=AVC_PATH msg=audit(1162850461.778:1
 type=AVC_PATH msg=audit(1162850461.778:1113):  path="/etc/rc.d/init.d/innd"
 """
 
+granted1 = """type=AVC msg=audit(1188833848.190:34): avc:  granted  { getattr } for  pid=4310 comm="ls" name="foo.pp" dev=sda5 ino=295171 scontext=user_u:system_r:unconfined_t:s0 tcontext=user_u:object_r:user_home_t:s0 tclass=file"""
+
 path1 = """type=AVC_PATH msg=audit(1162852201.019:1225):  path="/usr/lib/sa/sa1"
 """
 
@@ -62,6 +64,26 @@ class TestAVCMessage(unittest.TestCase):
         self.assertEquals(avc.tcontext, sc)
         self.assertEquals(avc.tclass, "")
         self.assertEquals(avc.accesses, [])
+
+    def test_granted(self):
+        avc = sepolgen.audit.AVCMessage(granted1)
+        avc.from_split_string(granted1.split())
+
+        self.assertEquals(avc.scontext.user, "user_u")
+        self.assertEquals(avc.scontext.role, "system_r")
+        self.assertEquals(avc.scontext.type, "unconfined_t")
+        self.assertEquals(avc.scontext.level, "s0")
+
+        self.assertEquals(avc.tcontext.user, "user_u")
+        self.assertEquals(avc.tcontext.role, "object_r")
+        self.assertEquals(avc.tcontext.type, "user_home_t")
+        self.assertEquals(avc.tcontext.level, "s0")
+        
+        self.assertEquals(avc.tclass, "file")
+        self.assertEquals(avc.accesses, ["getattr"])
+
+        self.assertEquals(avc.denial, False)
+
 
     def test_from_split_string(self):
         # syslog message
@@ -148,4 +170,23 @@ class TestAuditParser(unittest.TestCase)
         self.assertEquals(len(a.compute_sid_msgs), 0)
         self.assertEquals(len(a.invalid_msgs), 0)
         self.assertEquals(len(a.policy_load_msgs), 0)
+
+class TestGeneration(unittest.TestCase):
+    def test_generation(self):
+        parser = sepolgen.audit.AuditParser()
+        parser.parse_string(log1)
+        avs = parser.to_access()
+
+        self.assertEqual(len(avs), 1)
+
+    def test_genaration_granted(self):
+        parser = sepolgen.audit.AuditParser()
+        parser.parse_string(granted1)
+        avs = parser.to_access()
+
+        self.assertEqual(len(avs), 0)
         
+        avs = parser.to_access(only_denials=False)
+        
+        self.assertEqual(len(avs), 1)
+



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
