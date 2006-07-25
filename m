MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 1/2] Conditionally expand neverallows
Date: Tue, 25 Jul 2006 12:47:34 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588298D4D@exchange.columbia.tresys.com>
In-Reply-To: <1153843767.12141.27.camel@localhost.localdomain>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Karl MacMillan" <kmacmillan@mentalrootkit.com>
Cc: <selinux@tycho.nsa.gov>, <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 
> 
<snip>
> 
> How much memory does it take to expand the neverallow rules 
> for a typical reference policy? Can you post some hashtable 
> stats - this might make the chains very long and hurt 
> performance for looking up non-neverallow rules. These 
> tradeoffs may be fine for analysis, but it would be nice to 
> have some comments explaining the effects for other users of 
> the library.
> 

Other users won't expand neverallows, it is disabled by default and can
only be enabled by static users.

> <snip>
> 
> > +static void expand_state_init(expand_state_t *state) {
> > +	memset(state, 0, sizeof(expand_state_t)); }
> > +
> 
> I assume you've audited everywhere expand is currently called 
> to use this function?
> 

The single place, yes.

> <snip>
> 
> > @@ -1200,7 +1210,7 @@ static int expand_rule_helper(sepol_hand
> >  		if (!ebitmap_node_get_bit(snode, i))
> >  			continue;
> >  		if (source_rule->flags & RULE_SELF) {
> > -			if (source_rule->specified & AVRULE_AV) {
> > +			if (source_rule->specified & 
> (AVRULE_AV|AVRULE_NEVERALLOW)) {
> >  				if ((retval =
> >  				     expand_avrule_helper(handle,
> >  							  source_rule->
> > @@ -1227,7 +1237,7 @@ static int expand_rule_helper(sepol_hand
> >  		ebitmap_for_each_bit(ttypes, tnode, j) {
> >  			if (!ebitmap_node_get_bit(tnode, j))
> >  				continue;
> > -			if (source_rule->specified & AVRULE_AV) {
> > +			if (source_rule->specified & 
> (AVRULE_AV|AVRULE_NEVERALLOW)) {
> >  				if ((retval =
> >  				     expand_avrule_helper(handle,
> >  							  source_rule->
> 
> It might be cleaner to have a new define with AVRULE_AV and 
> AVRULE_NEVERALLOW already or'd. I don't feel strongly about it though.
> 

This makes it obvious what is happening, another define would be
unneeded indirection


> > @@ -1264,13 +1274,14 @@ static int convert_and_expand_rule(sepol
> >  				   policydb_t * dest_pol, 
> uint32_t * typemap,
> >  				   avrule_t * source_rule, 
> avtab_t * dest_avtab,
> >  				   cond_av_list_t ** cond,
> > -				   cond_av_list_t ** other, int enabled)
> > +				   cond_av_list_t ** other, int enabled,
> > +				   int do_neverallow)
> >  {
> >  	int retval;
> >  	ebitmap_t stypes, ttypes;
> >  	unsigned char alwaysexpand;
> >  
> > -	if (source_rule->specified & AVRULE_NEVERALLOW)
> > +	if (!do_neverallow && source_rule->specified & 
> AVRULE_NEVERALLOW)
> >  		return 1;
> >  
> 
> Magic return code.
> 

Indeed, that is an unchanged line.

> >  	ebitmap_init(&stypes);
> > @@ -1306,7 +1317,7 @@ static int cond_avrule_list_copy(policyd
> >  	while (cur) {
> >  		if (convert_and_expand_rule(state->handle, dest_pol,
> >  					    typemap, cur, dest_avtab,
> > -					    list, other, 
> enabled) != 1) {
> > +					    list, other, 
> enabled, 0) != 1) {
> >  			return -1;
> >  		}
> >  
> > @@ -1897,6 +1908,8 @@ int expand_module(sepol_handle_t * handl
> >  	expand_state_t state;
> >  	avrule_block_t *curblock;
> >  
> > +	expand_state_init(&state);
> > +
> >  	state.verbose = verbose;
> >  	state.typemap = NULL;
> >  	state.base = base;
> > @@ -2033,7 +2046,7 @@ int expand_module(sepol_handle_t * handl
> >  		/* copy rules */
> >  		cur_avrule = decl->avrules;
> >  		while (cur_avrule != NULL) {
> > -			if (cur_avrule->specified & AVRULE_NEVERALLOW) {
> > +			if (!(state->expand_neverallow) && 
> cur_avrule->specified & 
> > +AVRULE_NEVERALLOW) {
> 
> I think that the copying of the neverallows needs to be 
> factored out completely - it is a strange side effect of 
> expansion. The expansion functions should just, well, expand rules.
> 

For static users maybe but the shared API will still be expand for all
this stuff, making the internal and external interfaces for expand would
be more confusing than having an expand function that does too much
(particularly when the common case is that it does all this)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
