Subject: Re: [PATCH] Suppress rule generation for dontaudit rules
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Joshua Brindle <method@manicmethod.com>, selinux@tycho.nsa.gov
In-Reply-To: <1187875363.1451.475.camel@moss-spartans.epoch.ncsc.mil>
References: <2ad2d21fc72476558d8f.1187187301@localhost.localdomain>
	 <1187289925.909.75.camel@moss-spartans.epoch.ncsc.mil>
	 <46C4A449.9010102@manicmethod.com>
	 <1187875363.1451.475.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 24 Aug 2007 12:00:10 -0400
Message-Id: <1187971210.6753.4.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-23 at 09:22 -0400, Stephen Smalley wrote:
> On Thu, 2007-08-16 at 15:23 -0400, Joshua Brindle wrote:
> > Stephen Smalley wrote:
> > > On Wed, 2007-08-15 at 10:15 -0400, Karl MacMillan wrote:
> > >   
> > >> The current policy generation code incorrectly generates allow rules for dontaudit messages. This patch fixes that.
> > >>
[...]
> > 
> > Merged into 1.0.9
> 
> Reverted.  Didn't work.
> 

That's because it was wildly wrong - I thought I tested that, but I
guess not. Correct patch below:


diff -r e962f4f773fc sepolgen/src/sepolgen/audit.py
--- a/sepolgen/src/sepolgen/audit.py	Wed Aug 22 15:55:24 2007 -0400
+++ b/sepolgen/src/sepolgen/audit.py	Thu Aug 23 15:11:09 2007 -0400
@@ -421,6 +421,8 @@ class AuditParser:
         """
         av_set = access.AccessVectorSet()
         for avc in self.avc_msgs:
+            if avc.denial == True:
+                continue
             if avc_filter:
                 if avc_filter.filter(avc):
                     av_set.add(avc.scontext.type, avc.tcontext.type, avc.tclass,

Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
