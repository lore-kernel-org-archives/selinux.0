Subject: Re: Problem with semanage, looks like we don't handle the <<none>>
	context type?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <46B083DF.6010400@redhat.com>
References: <46AF3C5E.8080700@redhat.com> <46AFA0C8.90608@tresys.com>
	 <46AFA242.1010903@redhat.com>
	 <1185971344.15215.247.camel@moss-spartans.epoch.ncsc.mil>
	 <46B083DF.6010400@redhat.com>
Content-Type: text/plain
Date: Wed, 01 Aug 2007 09:42:56 -0400
Message-Id: <1185975776.15215.267.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-08-01 at 09:00 -0400, Daniel J Walsh wrote:
> Stephen Smalley wrote:
> > On Tue, 2007-07-31 at 16:57 -0400, Daniel J Walsh wrote:
> >   
> >> Joshua Brindle wrote:
> >>     
> >>> Daniel J Walsh wrote:
> >>>       
> >>>> cat /tmp/test.py
> >>>> #!/usr/bin/python
> >>>> from semanage import *
> >>>> sh = semanage_handle_create()
> >>>> rc, con = semanage_context_from_string(sh, "<<none>>")
> >>>> rc,fcontext = semanage_fcontext_create(sh)
> >>>> semanage_fcontext_set_con(sh, fcontext, con)
> >>>>
> >>>>
> >>>> # python /tmp/test.py
> >>>> Segmentation fault
> >>>>         
> >>> Granted the segfault needs to be fixed but what exactly are you trying 
> >>> to accomplish? <<none>> is not a type, its just something matchpathcon 
> >>> uses to short circuit its labeling behavior.
> >>>
> >>>       
> >> I have a request from someone who wants to setup a directory that 
> >> shortcuts the labeling behaviour.  IE wants restorecon and friends to do 
> >> nothing in the directory.
> >>     
> >
> > libsemanage maps a NULL context to <<none>>.
> >
> >   
> Ok if I change the python to not set the context at all, then semanage 
> does the right thing.
> 
> # semanage fcontext -a -t '<<none>>' /data
> 
>                 if type != "<<none>>":
>                        (rc, con) = semanage_context_create(self.sh)
>                        ...
>                        rc = semanage_fcontext_set_con(self.sh, fcontext, 
> con)
> 
> Of course the syntax is a bit misleading from a technical point of view 
> <<none>> is not a type.  But it works for me.

Looks like the seg fault is occuring from sepol_context_clone()
(semanage_fcontext_set_con -> semanage_context_clone ->
sepol_context_clone), because the con was set to NULL by
semanage_context_from_string -> sepol_context_from_string (tests for
"<<none>>").  So we can make sepol_context_clone() gracefully handle a
NULL con (just set *con_ptr = NULL and return 0) or have
semanage_fcontext_set_con() test for NULL on entry and handle it there.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
