Subject: Re: [PATCH-v3] libsepol: allow genfscon statements in modules
From: Eric Paris <eparis@redhat.com>
To: Joshua Brindle <method@manicmethod.com>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, dwalsh@redhat.com
In-Reply-To: <4829F4C4.4020306@manicmethod.com>
References: <1210173297.3084.13.camel@localhost.localdomain>
	 <4829F4C4.4020306@manicmethod.com>
Content-Type: text/plain
Date: Tue, 13 May 2008 16:26:10 -0400
Message-Id: <1210710370.3118.15.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-05-13 at 16:06 -0400, Joshua Brindle wrote:
> > +static void free_genfs(genfs_t *genfs)
> >   
> 
> I don't think this should go in link.c

meaning what?  you want me to static inline it from a header file?
Doesn't matter to me...
> 
> > +{
> > +	ocontext_t *con;
> > +	while (genfs) {
> > +		con = genfs->head;
> > +		while (con) {
> > +			free(con->u.name);
> > +			con->u.name = NULL;
> > +			free(con);
> > +			con = con->next;
> > +		}
> > +		genfs->head = NULL;
> > +		free(genfs->fstype);
> > +		genfs->fstype = NULL;
> > +		genfs = genfs->next;
> > +	}
> > +}

[snip]

> > +		while (base_con->next) {
> > +			base_len = strlen(base_con->next->u.name);
> > +			if (len > base_len)
> > +				break;
> > +			base_con = base_con->next;
> > +			if (len < base_len)
> > +				continue;
> > +			/* (len == base_len) */
> > +			if (!strcmp(con->u.name, base_con->u.name) &&
> > +			    ((!con->v.sclass || !base_con->v.sclass || con->v.sclass == base_con->v.sclass))) {
> >   
> 
> I don't get this. Shouldn't it be ((!con->v.sclass && 
> !base_con->v.sclass)) ... or am I missing something?

I could make this more complex, but what I have is correct.

If con->v.sclass is 0 that means this rule is supposed to cover all file
types thus any rule already in base must overlap.  The converse is also
true.  If the value in the base is 0 that means that this rule from the
incoming module must already be covered by the rule in base.

The last part says, if both the rule in the module and the rule in the
base are non-zero we have an overlap if they are for the same file type.

> > +		newgenfs = calloc(1, sizeof(genfs_t));
> >   
> 
> initializer preferred over calloc()

grummbles about getting memset backwards and calloc always being right.


> > +		if (!newgenfs) {
> > +			ERR(state->handle, "Out of memory!");
> > +			return -ENOMEM;
> > +		}
> > +		newgenfs->fstype = strdup(genfs->fstype);
> > +		if (!newgenfs->fstype) {
> > +			free_genfs(newgenfs);
> > +			ERR(state->handle, "Out of memory!");
> > +			return -ENOMEM;
> > +		}
> > +
> > +		l = NULL;
> > +		for (c = genfs->head; c; c = c->next) {
> > +			newc = calloc(1, sizeof(ocontext_t));
> >   
> 
> ditto

grummble grubble, fine.

> > @@ -2202,8 +2435,19 @@ int link_modules(sepol_handle_t * handle
> >  	for (i = 0; i < len; i++) {
> >  		state.cur = modules[i];
> >  		state.cur_mod_name = modules[i]->policy->name;
> > -		ret =
> > -		    copy_identifiers(&state, modules[i]->policy->symtab, NULL);
> > +		ret = copy_identifiers(&state, modules[i]->policy->symtab, NULL);
> > +		if (ret) {
> > +			retval = ret;
> > +			goto cleanup;
> > +		}
> > +	}
> > +
> > +	/* copy genfs_context stuff into base */
> > +	for (i = 0; i < len; i++) {
> > +		state.cur = modules[i];
> > +		state.cur_mod_name = modules[i]->policy->name;
> > +
> > +		ret = genfs_context_copy_helper(&state);
> >   
> 
> Why isn't this part of copy_module?

No good reason.  I can put it there (and should have)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
