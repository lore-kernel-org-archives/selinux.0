Subject: Re: [RFC PATCH] allow range_transitions and MLS users in modules
From: Joshua Brindle <jbrindle@tresys.com>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: SELinux List <selinux@tycho.nsa.gov>, Serge Hallyn <serue@us.ibm.com>,
        Christopher PeBenito <cpebenito@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <450EDC2E.50009@trustedcs.com>
References: <450EDC2E.50009@trustedcs.com>
Content-Type: text/plain
Date: Tue, 19 Sep 2006 08:07:43 -0400
Message-Id: <1158667663.3056.27.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-09-18 at 12:49 -0500, Darrel Goeddel wrote:
> - Add the ability to require MLS sensitivities and categories in policy
>   modules.
> - Remove the restrictions on defining users in MLS-enabled modules.
> - Handle range_trans_rules in modules.
> 
> This all allows range_transition statements to be used in policy modules
> and allows definition of users in MLS policy modules.
> 
> I haven't tested this as much as I would like, but it is working nicely
> for me.  I have built several policies (MLS, non-MLS, strict, targeted,
> etc.) and have built several modules exercising the new functionality.
> I'd appreciate any feedback you may have at this point.


Thank you, this is badly needed functionality

> <snip>

> +	level->level = malloc(sizeof(mls_level_t));
> +
> +int require_cat(int pass)
> +{
> +	char *id = queue_remove(id_queue);
> +	cat_datum_t *cat = NULL;
> +	int retval;
> +	if (pass == 2) {
> +		free(id);
> +		return 0;
> +	}
> +	if (!id) {
> +		yyerror("no category name");
> +		return -1;
> +	}
> +	cat = calloc(1, sizeof(cat_datum_t));
> +	if (!cat) {
> +		free(id);
> +		yyerror("Out of memory!");
> +		return -1;
> +	}

cat_datum_init?

<snip>
> +static int mls_level_convert(mls_semantic_level_t * src,
> +			     mls_semantic_level_t * dst, policy_module_t * mod)
> +{
> +	mls_semantic_cat_t *src_cat, *new_cat;
> +
> +	assert(mod->map[SYM_LEVELS][src->sens - 1]);
> +	dst->sens = mod->map[SYM_LEVELS][src->sens - 1];
> +
> +	for (src_cat = src->cat; src_cat; src_cat = src_cat->next) {
> +		new_cat =
> +		    (mls_semantic_cat_t *) calloc(1,
> +						  sizeof(mls_semantic_cat_t));

mls_semantic_cat_init?


Otherwise I don't see anything obvious, I'll hopefully do some testing
this afternoon.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
