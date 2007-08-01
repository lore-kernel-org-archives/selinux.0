Subject: Re: Problem with semanage, looks like we don't handle the <<none>>
	context type?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <46B09165.9030907@redhat.com>
References: <46AF3C5E.8080700@redhat.com> <46AFA0C8.90608@tresys.com>
	 <46AFA242.1010903@redhat.com>
	 <1185971344.15215.247.camel@moss-spartans.epoch.ncsc.mil>
	 <1185973320.15215.258.camel@moss-spartans.epoch.ncsc.mil>
	 <46B09165.9030907@redhat.com>
Content-Type: text/plain
Date: Wed, 01 Aug 2007 10:07:26 -0400
Message-Id: <1185977246.15215.272.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-08-01 at 09:57 -0400, Daniel J Walsh wrote:
> Stephen Smalley wrote:
> > On Wed, 2007-08-01 at 08:29 -0400, Stephen Smalley wrote:
> >   
> >> On Tue, 2007-07-31 at 16:57 -0400, Daniel J Walsh wrote:
> >>     
> >>> Joshua Brindle wrote:
> >>>       
> >>>> Daniel J Walsh wrote:
> >>>>         
> >>>>> cat /tmp/test.py
> >>>>> #!/usr/bin/python
> >>>>> from semanage import *
> >>>>> sh = semanage_handle_create()
> >>>>> rc, con = semanage_context_from_string(sh, "<<none>>")
> >>>>> rc,fcontext = semanage_fcontext_create(sh)
> >>>>> semanage_fcontext_set_con(sh, fcontext, con)
> >>>>>
> >>>>>
> >>>>> # python /tmp/test.py
> >>>>> Segmentation fault
> >>>>>           
> >>>> Granted the segfault needs to be fixed but what exactly are you trying 
> >>>> to accomplish? <<none>> is not a type, its just something matchpathcon 
> >>>> uses to short circuit its labeling behavior.
> >>>>
> >>>>         
> >>> I have a request from someone who wants to setup a directory that 
> >>> shortcuts the labeling behaviour.  IE wants restorecon and friends to do 
> >>> nothing in the directory.
> >>>       
> >> libsemanage maps a NULL context to <<none>>.
> >>     
> >
> > Also, you never did a semanage_context_create() in the above.
> >
> >   
> 
> rc, con = semanage_context_from_string(sh, "<<none>>")
> Should do the same, well at least
> 
> rc, con = semanage_context_from_string(sh, "system_u:object_r:etc_t")
> 
> Should
> 
> 
> Anyways I worked on this a little further,  I now have creation working and modification partially working.
> 
> I can create a <<none>> entry as described in a previous mail, and I can modify it to a normal context.  But I have 
> no way of modifying a normal context to a <<none>> without deleting and recreating the entry.
> 
>                        rc = semanage_fcontext_set_con(self.sh, fcontext, None)
> 
> Segfaults.

Try this patch for libsepol.

Make sepol_context_clone correctly handle a NULL context (for the
"<<none>>" case).

Index: libsepol/src/context_record.c
===================================================================
--- libsepol/src/context_record.c	(revision 2502)
+++ libsepol/src/context_record.c	(working copy)
@@ -154,6 +154,12 @@
 {
 
 	sepol_context_t *new_con = NULL;
+
+	if (!con) {
+		*con_ptr = NULL;
+		return 0;
+	}
+	  
 	if (sepol_context_create(handle, &new_con) < 0)
 		goto err;
 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
