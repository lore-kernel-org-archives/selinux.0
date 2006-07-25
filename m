MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 2/2] Refactor expansion of avtab
Date: Tue, 25 Jul 2006 12:55:30 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588298D4F@exchange.columbia.tresys.com>
In-Reply-To: <1153844186.12141.34.camel@localhost.localdomain>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Karl MacMillan" <kmacmillan@mentalrootkit.com>
Cc: <selinux@tycho.nsa.gov>, <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 
> 
> On Tue, 2006-07-25 at 10:56 -0400, Joshua Brindle wrote:
> 
> > diff -urpN -x 'Change*' -x entries -x '*.orig' -x '*.rej' 
> -x '*.svn*' -x '*.swp' -x '*.o' -x '*.lo' 
> ../../../trunk/libsepol/include/sepol/policydb/expand.h 
> ./include/sepol/policydb/expand.h
> > --- trunk/libsepol/include/sepol/policydb/expand.h	
> 2006-07-13 10:19:14.000000000 -0400
> > +++ trunk/libsepol/include/sepol/policydb/expand.h	
> 2006-07-19 13:04:03.000000000 -0400
> > @@ -29,6 +29,9 @@
> >  #include <sepol/handle.h>
> >  #include <sepol/policydb/conditional.h>
> >  
> > +extern int expand_module_avrules(sepol_handle_t *handle, 
> policydb_t *base,
> > +				policydb_t *out, uint32_t *typemap, 
> > +				int verbose, int expand_neverallow);
> 
> Poorly named function - are neverallows av rules or not? If 
> they are not the function needs a more generic name. This is 
> continuing the confusing practice of sometimes calling just 
> allow and audit rules av rules and sometimes using it to mean 
> more rule types.
> 

Have any suggestions? We couldn't think of a really good name either.

> This can be in place or out of place (i.e., out can be the 
> same as base)? A comment describing how this function can be 
> used is needed, including the fact that the typemap must be 
> "special" for an in-place expand, correct?
> 

Either, it is out of place for the current usage and in place for
setools. Talking about a special typemap is out of context here. Maybe
more comments are needed. No need to ditch this patch though, we can
apply some comments on top of it.

> Object classes and permissions will never need to be mapped 
> for an out of place expansion?
> 
> > -		/* copy conditional rules */
> > -		if (cond_node_copy(&state, decl->cond_list))
> > -			goto cleanup;
> > +	if (expand_avrule_decls(&state) < 0) {
> > +		ERR(handle, "Error during expand");
> > +		goto cleanup;
> >  	}
> >  
> >  	/* copy constraints */
> > 
> 
> The refactoring is nice even without the exported function.
> 

?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
