Message-ID: <46B09165.9030907@redhat.com>
Date: Wed, 01 Aug 2007 09:57:57 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Joshua Brindle <jbrindle@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Problem with semanage, looks like we don't handle the <<none>>
 context type?
References: <46AF3C5E.8080700@redhat.com> <46AFA0C8.90608@tresys.com>	 <46AFA242.1010903@redhat.com>	 <1185971344.15215.247.camel@moss-spartans.epoch.ncsc.mil> <1185973320.15215.258.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1185973320.15215.258.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------090907030502030600020309"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090907030502030600020309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Smalley wrote:
> On Wed, 2007-08-01 at 08:29 -0400, Stephen Smalley wrote:
>   
>> On Tue, 2007-07-31 at 16:57 -0400, Daniel J Walsh wrote:
>>     
>>> Joshua Brindle wrote:
>>>       
>>>> Daniel J Walsh wrote:
>>>>         
>>>>> cat /tmp/test.py
>>>>> #!/usr/bin/python
>>>>> from semanage import *
>>>>> sh = semanage_handle_create()
>>>>> rc, con = semanage_context_from_string(sh, "<<none>>")
>>>>> rc,fcontext = semanage_fcontext_create(sh)
>>>>> semanage_fcontext_set_con(sh, fcontext, con)
>>>>>
>>>>>
>>>>> # python /tmp/test.py
>>>>> Segmentation fault
>>>>>           
>>>> Granted the segfault needs to be fixed but what exactly are you trying 
>>>> to accomplish? <<none>> is not a type, its just something matchpathcon 
>>>> uses to short circuit its labeling behavior.
>>>>
>>>>         
>>> I have a request from someone who wants to setup a directory that 
>>> shortcuts the labeling behaviour.  IE wants restorecon and friends to do 
>>> nothing in the directory.
>>>       
>> libsemanage maps a NULL context to <<none>>.
>>     
>
> Also, you never did a semanage_context_create() in the above.
>
>   

rc, con = semanage_context_from_string(sh, "<<none>>")
Should do the same, well at least

rc, con = semanage_context_from_string(sh, "system_u:object_r:etc_t")

Should


Anyways I worked on this a little further,  I now have creation working and modification partially working.

I can create a <<none>> entry as described in a previous mail, and I can modify it to a normal context.  But I have 
no way of modifying a normal context to a <<none>> without deleting and recreating the entry.

                       rc = semanage_fcontext_set_con(self.sh, fcontext, None)

Segfaults.

Attached patch has the relevant changes to seobject.py






--------------090907030502030600020309
Content-Type: text/x-patch;
 name="seobject.py.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="seobject.py.patch"

--- nsapolicycoreutils/semanage/seobject.py	2007-07-16 14:20:41.000000000 -0400
+++ policycoreutils-2.0.22/semanage/seobject.py	2007-08-01 09:54:14.000000000 -0400
@@ -1024,14 +1025,31 @@
 	def __init__(self):
 		semanageRecords.__init__(self)
 		
-	def add(self, target, type, ftype = "", serange = "", seuser = "system_u"):
+        def createcon(self, target, seuser = "system_u"):
+                (rc, con) = semanage_context_create(self.sh)
+                if rc < 0:
+                       raise ValueError(_("Could not create context for %s") % target)
 		if seuser == "":
 			seuser = "system_u"
+
+                rc = semanage_context_set_user(self.sh, con, seuser)
+                if rc < 0:
+                       raise ValueError(_("Could not set user in file context for %s") % target)
+		
+                rc = semanage_context_set_role(self.sh, con, "object_r")
+                if rc < 0:
+                       raise ValueError(_("Could not set role in file context for %s") % target)
+
 		if is_mls_enabled == 1:
-			if serange == "":
-				serange = "s0"
-			else:
-				serange = untranslate(serange)
+                       rc = semanage_context_set_mls(self.sh, con, "s0")
+                       if rc < 0:
+                              raise ValueError(_("Could not set mls fields in file context for %s") % target)
+
+                return con
+               
+	def add(self, target, type, ftype = "", serange = "", seuser = "system_u"):
+		if is_mls_enabled == 1:
+                       serange = untranslate(serange)
 			
 		if type == "":
 			raise ValueError(_("SELinux Type is required"))
@@ -1051,33 +1069,23 @@
 			raise ValueError(_("Could not create file context for %s") % target)
 		
 		rc = semanage_fcontext_set_expr(self.sh, fcontext, target)
-		(rc, con) = semanage_context_create(self.sh)
-		if rc < 0:
-			raise ValueError(_("Could not create context for %s") % target)
-
-		rc = semanage_context_set_user(self.sh, con, seuser)
-		if rc < 0:
-			raise ValueError(_("Could not set user in file context for %s") % target)
-		
-		rc = semanage_context_set_role(self.sh, con, "object_r")
-		if rc < 0:
-			raise ValueError(_("Could not set role in file context for %s") % target)
-
-		rc = semanage_context_set_type(self.sh, con, type)
-		if rc < 0:
-			raise ValueError(_("Could not set type in file context for %s") % target)
+                if type != "<<none>>":
+                       con = self.createcon(target, seuser)
 
-		if serange != "":
-			rc = semanage_context_set_mls(self.sh, con, serange)
-			if rc < 0:
-				raise ValueError(_("Could not set mls fields in file context for %s") % target)
+                       rc = semanage_context_set_type(self.sh, con, type)
+                       if rc < 0:
+                              raise ValueError(_("Could not set type in file context for %s") % target)
+
+                       if serange != "":
+                              rc = semanage_context_set_mls(self.sh, con, serange)
+                              if rc < 0:
+                                     raise ValueError(_("Could not set mls fields in file context for %s") % target)
+                       rc = semanage_fcontext_set_con(self.sh, fcontext, con)
+                       if rc < 0:
+                              raise ValueError(_("Could not set file context for %s") % target)
 
 		semanage_fcontext_set_type(fcontext, file_types[ftype])
 
-		rc = semanage_fcontext_set_con(self.sh, fcontext, con)
-		if rc < 0:
-			raise ValueError(_("Could not set file context for %s") % target)
-
 		rc = semanage_begin_transaction(self.sh)
 		if rc < 0:
 			raise ValueError(_("Could not start semanage transaction"))
@@ -1090,7 +1098,8 @@
 		if rc < 0:
 			raise ValueError(_("Could not add file context for %s") % target)
 
-		semanage_context_free(con)
+                if type != "<<none>>":
+                       semanage_context_free(con)
 		semanage_fcontext_key_free(k)
 		semanage_fcontext_free(fcontext)
 
@@ -1112,16 +1121,29 @@
 		if rc < 0:
 			raise ValueError(_("Could not query file context for %s") % target)
 
-		con = semanage_fcontext_get_con(fcontext)
+                if setype != "<<none>>":
+                       con = semanage_fcontext_get_con(fcontext)
 			
-		if serange != "":
-			semanage_context_set_mls(self.sh, con, untranslate(serange))
-		if seuser != "":
-			semanage_context_set_user(self.sh, con, seuser)	
-		if setype != "":
-			semanage_context_set_type(self.sh, con, setype)
-
-		rc = semanage_begin_transaction(self.sh)
+                       if con == None:
+                              con = self.createcon(target)
+                              
+                       if serange != "":
+                              semanage_context_set_mls(self.sh, con, untranslate(serange))
+                       if seuser != "":
+                              semanage_context_set_user(self.sh, con, seuser)
+                              
+                       if setype != "":
+                              semanage_context_set_type(self.sh, con, setype)
+
+                       rc = semanage_fcontext_set_con(self.sh, fcontext, con)
+                       if rc < 0:
+                              raise ValueError(_("Could not set file context for %s") % target)
+                else:
+                       rc = semanage_fcontext_set_con(self.sh, fcontext, None)
+                       if rc < 0:
+                              raise ValueError(_("Could not set file context for %s") % target)
+                       
+                rc = semanage_begin_transaction(self.sh)
 		if rc < 0:
 			raise ValueError(_("Could not start semanage transaction"))
 

--------------090907030502030600020309--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
