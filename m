Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1FN8FL9012335
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 18:08:15 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1FN4kw0003706
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 23:04:46 GMT
Date: Tue, 15 Feb 2005 23:17:07 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: sshd transition points
Message-ID: <20050215231707.GC29523@lkcl.net>
References: <20050215155323.GC23765@lkcl.net> <1108491293.17854.153.camel@moss-spartans.epoch.ncsc.mil> <20050215191640.GA26294@lkcl.net> <1108495342.17854.200.camel@moss-spartans.epoch.ncsc.mil> <20050215200355.GB26294@lkcl.net> <20050215225329.GH26294@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050215225329.GH26294@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

okay.

i should explain what this patch actually does, shouldn't i? :)

on a setcon, if you are in context A, and you are endeavouring to
setcon to context B, then you "automatically" get thrown instead
into context C.

i cut/paste bits of selinux_bprm_set_security(), to set a requirement
to have two permissions "transition:process" and "entrypoint:file" and
of course, looking at that now, that's COMPLETELY wrong :)

it maybe should be transition:process and also dyntransition:process,
if anything.

don't know.

anyway.

it needs to be matched by a macro dynamic_auto_trans(), which
should be used like this:

	dynamic_auto_trans(A, B, C)

according to the description above about setcon().

	define(`dynamic_auto_trans',`
	dynamic_trans($1,$2,$3)
	type_transition $1 $2:process $3;
	')

and this is the complicated one that i don't quite follow but
i notice from domain_trans there's "allow $3 $2:file entrypoint"
which is what i got wrong in my patch so something like this perhaps?

	define (`dynamic_trans',`

	allow $1 $3:process dyntransition;
	allow $3 $2:process transition;
	')

and then where i have put this:

	> +
	> +	/* Check permissions for the transition. */
	> +	rc = avc_has_perm(fromsid, newsid, SECCLASS_PROCESS,
	> +			  PROCESS__TRANSITION, NULL);
	> +	if (rc)
	> +		return rc;
	> +
	> +	rc = avc_has_perm(newsid, sid, SECCLASS_FILE,
	> +			  FILE__ENTRYPOINT, NULL);
	> +

have this instead:

	> +
	> +	/* Check permissions for the transition. */
	> +	rc = avc_has_perm(fromsid, newsid, SECCLASS_PROCESS,
	> +			  PROCESS__DYNTRANSITION, NULL);
	> +	if (rc)
	> +		return rc;
	> +
	> +	rc = avc_has_perm(newsid, sid, SECCLASS_FILE,
	> +			  PROCESS_TRANSITION, NULL);
	> +

i dunno.  i grok the principle, but the details escape me - esp.
the rest of the weird bits in domain_trans() whose purpose i don't
know about.

but the benefits are very very obvious: no pissing about
with hard-coding contexts, type-casting security_contexts to
strings, constructing them and re-typecasting strings back
to security_contexts.

the security contexts can be specified where they belong -
in the policy.

and i can modify the policy to include my lovely paranoid sshd
messings about.

which i certainly could NOT do WITHOUT this dynamic_auto_trans():
i would have to hack sshd about, which is unacceptable [for
the production environment in which it is to be deployed.  the
fact that FC3 is to be used has only been accepted by the skin
of its teeth].


the only caveat is that the security_transition_sid() function
ONLY takes two arguments to produce a third.

ideally, i'd like to see a specific executable be thrown into
the mix as well: three arguments to the security_transition_sid
function to produce a fourth:

dynamic_auto_trans(sshd_privset_t, user_t, sshd_exec_t, sshd_privset_user_t)
                                           ^^^^^^^^^^^

... would that be doable?

l.

On Tue, Feb 15, 2005 at 10:53:29PM +0000, Luke Kenneth Casson Leighton wrote:
> okay: am i being particularly thick today, or am i missing something?
> 
> we expect domain automatic transitions to occur on an execve().
> it's how everything hangs together in selinux.
> 
> _should_ i expect automatic transitions to be possible on
> a "dynamic" transition?
> 
> because, without them, things get a bit inconvenient.
> 
> i wrote a code-fragment earlier where i do a get_default_context(),
> and then i do a setcon().
> 
> on the setcon(), because i happened to be in sshd_privsep_t, and because
> i happened to be setting the context to user_t, and because it was
> sshd_exec_t doing the setting, i expect an "automatic" transition
> to occur to sshd_privsep_user_t.
> 
> 
> otherwise, what i am going to have to do makes me feel slightly
> queasy, and if i recall correctly, it's what made me think "how the 
> heck am i gonna do that???" when i was considering this for samba tng.
> 
> if you recall, i mentioned something about munging security contexts
> by digging into the text of a struct security_context - by MANUALLY
> creating a string:
> 
> 	char new_context[500];
> 	context = get_default_context(..., &scontext);
> 	sprintf(new_context, "samba_%s", (char*)scontext));
> 	setcon((struct security_context*)new_context);
> 
> EEEEEUUUUWWW, yukkk, i hear you say.
> 
> yeh, yuk.  a really awful hack, that leads to croo-joze nasties
> and hard-coded context names and stuff .... in an application.
> 
> well, if there existed that dynamic_auto_trans() macro - and
> support for it in hooks.c - then the problem of hard-coded
> security contexts ... melts away and disappears.
> 
> why?  because it would be possible to do this:
> 
> 	dynamic_auto_trans(sshd_privsep_t, user_t, sshd_exec_t,
> 			   sshd_privsep_user_t)
> 
> 
> and in sshd, just do this:
> 
> 	get_default_context(&scontext), /* gets user_t or other user context */
> 	setcon(&scontext).
> 
> ta-daa.
> 
> good idea?
> 
> like it?
> 
> good.  patch attached.
> 
> l.
> 
> -- 
> --
> <a href="http://lkcl.net">http://lkcl.net</a>
> --

> ? .hooks.c.swp
> ? f
> ? ss/.services.c.swp
> Index: hooks.c
> ===================================================================
> RCS file: /cvsroot/selinux/nsa/linux-2.6/security/selinux/hooks.c,v
> retrieving revision 1.32
> diff -u -r1.32 hooks.c
> --- hooks.c	4 Feb 2005 18:09:20 -0000	1.32
> +++ hooks.c	15 Feb 2005 22:41:27 -0000
> @@ -4080,6 +4080,52 @@
>  	return len;
>  }
>  
> +/*
> + * purpose of this function is to determine if a dynamic auto-transition
> + * should occur.  if you were in context "fromsid", and are attempting
> + * to set the context as "sid", then instead, it gets set to "newsid".
> + *
> + * just like in selinux_bprm_set_security(), from which this function
> + * is derived (and is near-identical).
> + *
> + */
> +static int selinux_check_dyn_autotrans( u32 fromsid, u32 sid, u32 *newsid)
> +{
> +	int rc;
> +
> +	/* Check for a default transition on this
> +	 * dynamic context transition.  */
> +	rc = security_transition_sid(fromsid, sid,
> +			     SECCLASS_PROCESS, newsid);
> +
> +	if (rc)
> +	{
> +		/* we do _not_ have permission to do an auto-dyn-trans.
> +		 * therefore, the sid to change to is the one that
> +		 * the setcon() actually asked for.
> +		 */
> +		*newsid = sid;
> +		return 0;
> +	}
> +
> +        if (fromsid == *newsid) {
> +		rc = avc_has_perm(fromsid, sid,
> +				  SECCLASS_FILE, FILE__EXECUTE_NO_TRANS, NULL);
> +		return rc;
> +	}
> +
> +	/* Check permissions for the transition. */
> +	rc = avc_has_perm(fromsid, newsid, SECCLASS_PROCESS,
> +			  PROCESS__TRANSITION, NULL);
> +	if (rc)
> +		return rc;
> +
> +	rc = avc_has_perm(newsid, sid, SECCLASS_FILE,
> +			  FILE__ENTRYPOINT, NULL);
> +
> +	return rc;
> +}
> +
>  static int selinux_setprocattr(struct task_struct *p,
>  			       char *name, void *value, size_t size)
>  {
> @@ -4169,7 +4215,16 @@
>  			if (error)
>  				return error;
>  		} else {
> -			tsec->sid = sid;
> +			u32 newsid;
> +			int rc;
> +
> +			rc = selinux_check_dyn_autotrans( tsec->sid, sid,
> +					                  &newsid);
> +			if (rc)
> +				tsec->sid = sid; /* nope - no auto-trans */
> +			else
> +				tsec->sid = newsid;
> +
>  			task_unlock(p);
>  		}
>  	}


-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
