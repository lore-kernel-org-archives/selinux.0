Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p4K1EAvo023008
	for <selinux@tycho.nsa.gov>; Thu, 19 May 2011 21:14:10 -0400
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p4K1E94p012785
	for <selinux@tycho.nsa.gov>; Fri, 20 May 2011 01:14:09 GMT
Message-ID: <4DD5C051.1000203@manicmethod.com>
Date: Thu, 19 May 2011 21:13:53 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: HarryCiao <harrytaurus2002@hotmail.com>
CC: selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: Re: A few questions about module compile/link source code
References: <SNT139-w488BAEE329DEC249677A49AB890@phx.gbl>
In-Reply-To: <SNT139-w488BAEE329DEC249677A49AB890@phx.gbl>
Content-Type: text/plain; charset=GB2312
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

HarryCiao wrote:
> Hi Joshua,
> 
> When I am studying the source code about SELinux module 
> compile/link/expansion, so far I run into below 6 questions and would 
> like to ask you about. I believe most of them are silly and I really 
> appreciate you taking time to have a look at them. Or you could point me 
> at some relevant email threads or articles or anything and I could start 
> from there myself. Thanks !!

Sorry for the late response, you caught me on vacation. I'll try to
answer the questions but it has been 6 years since I looked at some of
this code (particularly checkpolicy). I'm glad someone new is finally
looking at this stuff.

> 
> 
> 1, In is_id_in_scope(), if no scope_datum_t is found in the current 
> module, then return 1 as success:
> 
> int is_id_in_scope(uint32_t symbol_type, hashtab_key_t id)
> {
> scope_datum_t *scope =
> (scope_datum_t *) hashtab_search(policydbp->scope[symbol_type].
> table, id);
> if (scope == NULL) {
> return 1; /* id is not known, so return success */
> }
> return is_scope_in_stack(scope, stack_top);
> }
> 
> Any module, either to define an identifier, or declare it as an outside 
> dependency. Both declare_symbol() and require_symbol() would invoke 
> symtab_insert() to register the identifier's (key, scope_datum_t) pair 
> into the relevant scope[] hashtab, so no scope_datum_t is found would 
> mean that the identifier is neither defined nor declared ever before, 
> then why to return 1 as success ?
> 

I've been staring at this for a while and really can't recall. It is
possible that some symbols use to never make it into the scope tables
(eg., object_t) but I can't seem to trigger it now.

> 
> 2, In define_type(), we get the attribute from the p_types hashtab for 
> the current module:
> 
> attr = hashtab_search(policydbp->p_types.table, id);
> if (!attr) {
> /* treat it as a fatal error */
> yyerror2("attribute %s is not declared", id);
> return -1;
> }
> 
> if (attr->flavor != TYPE_ATTRIB) {
> yyerror2("%s is a type, not an attribute", id);
> 
> if ((attr = get_local_type(id, attr->s.value, 1)) == NULL) {
> yyerror("Out of memory!");
> return -1;
> }
> 
> But in get_local_type(), if the current block/decl is not 
> global/unconditional block, then the attribute's type_datum_t would be 
> duplicated to the current block/decl's symtab[SYM_TYPES], resulting that 
> the current type identifier would be recorded into type_datum_t.types in 
> the current block/decl's symtab[SYM_TYPES], rather than the one in the 
> p_types hashtab.
> 
> Why would we need to get the local attribute from current block/decl's 
> symtab then set its ebitmap, rather than setting the ebitmap for the one 
> in p_types ?
> 

The types are set in the local decl block so that when the optional
decl's have been disabled those types won't end up in the final
attribute bitmap.

> 
> 3, Who decides the value for the "pass" argument to all those parser 
> functions? how and when the value for pass is determined?
> 
> Say in define_attrib(), when pass == 1, the token in id_queue is parsed 
> but when pass == 2, the id_queue is purged:
> 
<snip>
> 
> By whom/when/how is "pass" set to be 1 or 2 ?
> 

Look at init_parser() and the calls to it.

> 
> 4, In define_te_avtab_helper(), if the current permission is not defined 
> for a class, then "continue" to the next loop to handle the next class 
> (to get the current permission's policy value defined in the class, 
> record it in the class_perm_node_t.data for that class) :
> 
> while ((id = queue_remove(id_queue))) {
> cur_perms = perms;
> ebitmap_for_each_bit(&tclasses, node, i) {
> if (!ebitmap_node_get_bit(node, i))
> continue;
> cladatum = policydbp->class_val_to_struct[i];
> 
> ......
> 
> if (!perdatum) {
> if (!suppress)
> yyerror2("permission %s is not defined for class %s", id,
> policydbp->p_class_val_to_name[i]);
> continue;
> } else if (!is_perm_in_scope(id, policydbp->p_class_val_to_name[i])) {
> if (!suppress) {
> yyerror2("permission %s of class %s is not within scope", id,
> policydbp->p_class_val_to_name[i]);
> }
> continue;
> } else {
> cur_perms->data |= 1U << (perdatum->s.value - 1);
> }
> 
> next:
> cur_perms = cur_perms->next;
> }
> 
> free(id);
> 
> }
> 
> If the current permission is not defined for the class, then we should 
> not simply continue the next loop, but do "goto next", since we need to 
> move up to the next element in the cur_perms accordingly (the Nth 
> non-zero bit and the Nth element of class_perm_node_t are all about the 
> same class), perhaps this is a bug, am I right ?
> 

This is very historical and could possibly be removed, suppress doesn't
seem to ever be set anymore. This code use to exist circa 2004:

         if (policyvers < POLICYDB_VERSION_NLCLASS &&
             (cladatum->value >= SECCLASS_NETLINK_ROUTE_SOCKET &&
              cladatum->value <= SECCLASS_NETLINK_DNRT_SOCKET)) {
                 sprintf(errormsg, "remapping class %s to netlink_socket "
                          "for policy version %d", id, policyvers);
                 yywarn(errormsg);
                 classvalue = SECCLASS_NETLINK_SOCKET;
                         suppress = 1;




> 
> 5, I have two questions in following snippet of link_modules():
> 
> /* copy all types, declared and required */
> for (i = 0; i < len; i++) {
> state.cur = modules[i];
> state.cur_mod_name = modules[i]->policy->name;
> ret =
> hashtab_map(modules[i]->policy->p_types.table,
> type_copy_callback, &state);
> if (ret) {
> retval = ret;
> goto cleanup;
> }
> }
> 
> /* then copy everything else, including aliases, and fixup attributes */
> for (i = 0; i < len; i++) {
> state.cur = modules[i];
> state.cur_mod_name = modules[i]->policy->name;
> ret =
> copy_identifiers(&state, modules[i]->policy->symtab, NULL);
> if (ret) {
> retval = ret;
> goto cleanup;
> }
> }
> 
> 
> if (policydb_index_others(state.handle, state.base, 0)) {
> ERR(state.handle, "Error while indexing others");
> goto cleanup;
> }
> 
> /* copy and remap the module's data over to base */
> for (i = 0; i < len; i++) {
> state.cur = modules[i];
> ret = copy_module(&state, modules[i]);
> if (ret) {
> retval = ret;
> goto cleanup;
> }
> }
> 
> 1) since copy_identifers() could cover the invoke of type_copy_callback, 
> then why we need to call it explicitly before calling copy_identifiers()?
> 

There are some serious ordering issues in this code. Symbols must be
copied in a precise order. copy_identifiers is also used elsewhere in
the code when it is not appropriate to copy types.

> 2) copy_identifers() has been invoked before calling copy_module(), but 
> copy_module() could invoke copy_identifers() again. Since 
> copy_identifers() only gets called by link_modules(), could we stop 
> copy_module() from invoking copy_identifers() once again ?
> 

Interesting. It is possible that we are calling it excessively, though I
have not tried removing it to see what happens. I'm not completely
certain what happened here, though it wasn't like that in the historical
linker, it may have happened during a refactor.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
