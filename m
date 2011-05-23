Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p4NDFfAv006320
	for <selinux@tycho.nsa.gov>; Mon, 23 May 2011 09:15:41 -0400
Received: from snt0-omc1-s25.snt0.hotmail.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p4NDFeZY025175
	for <selinux@tycho.nsa.gov>; Mon, 23 May 2011 13:15:40 GMT
Message-ID: <SNT139-w89229AB55B95D9E7630B7AB720@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_8f8c5216-0394-4ae4-a00c-918048f3007f_"
From: HarryCiao <harrytaurus2002@hotmail.com>
To: <method@manicmethod.com>
CC: selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: RE: A few questions about module compile/link source code
Date: Mon, 23 May 2011 13:15:39 +0000
In-Reply-To: <4DD5C051.1000203@manicmethod.com>
References: 
 <SNT139-w488BAEE329DEC249677A49AB890@phx.gbl>,<4DD5C051.1000203@manicmethod.com>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_8f8c5216-0394-4ae4-a00c-918048f3007f_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi Joshua,
 
Many thanks for your response! Hope you had an enjoyable vacation :-)
 
Well, for the init_parser() problem, so far I am new to lex & yacc, I am most puzzled that some rules are handled when pass == 1 and the id queue is purged when pass == 2, whereas some other rules are handled when pass == 2 and the id queue got cleaned up when pass == 1.
 
Who decides when a particular rule should be processed and when the id queue should be cleaned ? and does it and how does it relate with the syntax of a certain rule ?
 
Thanks again!
 
Best regards,
Harry
 
> Date: Thu, 19 May 2011 21:13:53 -0400
> From: method@manicmethod.com
> To: harrytaurus2002@hotmail.com
> CC: selinux@tycho.nsa.gov
> Subject: Re: A few questions about module compile/link source code
> 
> HarryCiao wrote:
> > Hi Joshua,
> > 
> > When I am studying the source code about SELinux module 
> > compile/link/expansion, so far I run into below 6 questions and would 
> > like to ask you about. I believe most of them are silly and I really 
> > appreciate you taking time to have a look at them. Or you could point me 
> > at some relevant email threads or articles or anything and I could start 
> > from there myself. Thanks !!
> 
> Sorry for the late response, you caught me on vacation. I'll try to
> answer the questions but it has been 6 years since I looked at some of
> this code (particularly checkpolicy). I'm glad someone new is finally
> looking at this stuff.
> 
> > 
> > 
> > 1, In is_id_in_scope(), if no scope_datum_t is found in the current 
> > module, then return 1 as success:
> > 
> > int is_id_in_scope(uint32_t symbol_type, hashtab_key_t id)
> > {
> > scope_datum_t *scope =
> > (scope_datum_t *) hashtab_search(policydbp->scope[symbol_type].
> > table, id);
> > if (scope == NULL) {
> > return 1; /* id is not known, so return success */
> > }
> > return is_scope_in_stack(scope, stack_top);
> > }
> > 
> > Any module, either to define an identifier, or declare it as an outside 
> > dependency. Both declare_symbol() and require_symbol() would invoke 
> > symtab_insert() to register the identifier's (key, scope_datum_t) pair 
> > into the relevant scope[] hashtab, so no scope_datum_t is found would 
> > mean that the identifier is neither defined nor declared ever before, 
> > then why to return 1 as success ?
> > 
> 
> I've been staring at this for a while and really can't recall. It is
> possible that some symbols use to never make it into the scope tables
> (eg., object_t) but I can't seem to trigger it now.
> 
> > 
> > 2, In define_type(), we get the attribute from the p_types hashtab for 
> > the current module:
> > 
> > attr = hashtab_search(policydbp->p_types.table, id);
> > if (!attr) {
> > /* treat it as a fatal error */
> > yyerror2("attribute %s is not declared", id);
> > return -1;
> > }
> > 
> > if (attr->flavor != TYPE_ATTRIB) {
> > yyerror2("%s is a type, not an attribute", id);
> > 
> > if ((attr = get_local_type(id, attr->s.value, 1)) == NULL) {
> > yyerror("Out of memory!");
> > return -1;
> > }
> > 
> > But in get_local_type(), if the current block/decl is not 
> > global/unconditional block, then the attribute's type_datum_t would be 
> > duplicated to the current block/decl's symtab[SYM_TYPES], resulting that 
> > the current type identifier would be recorded into type_datum_t.types in 
> > the current block/decl's symtab[SYM_TYPES], rather than the one in the 
> > p_types hashtab.
> > 
> > Why would we need to get the local attribute from current block/decl's 
> > symtab then set its ebitmap, rather than setting the ebitmap for the one 
> > in p_types ?
> > 
> 
> The types are set in the local decl block so that when the optional
> decl's have been disabled those types won't end up in the final
> attribute bitmap.
> 
> > 
> > 3, Who decides the value for the "pass" argument to all those parser 
> > functions? how and when the value for pass is determined?
> > 
> > Say in define_attrib(), when pass == 1, the token in id_queue is parsed 
> > but when pass == 2, the id_queue is purged:
> > 
> <snip>
> > 
> > By whom/when/how is "pass" set to be 1 or 2 ?
> > 
> 
> Look at init_parser() and the calls to it.
> 
> > 
> > 4, In define_te_avtab_helper(), if the current permission is not defined 
> > for a class, then "continue" to the next loop to handle the next class 
> > (to get the current permission's policy value defined in the class, 
> > record it in the class_perm_node_t.data for that class) :
> > 
> > while ((id = queue_remove(id_queue))) {
> > cur_perms = perms;
> > ebitmap_for_each_bit(&tclasses, node, i) {
> > if (!ebitmap_node_get_bit(node, i))
> > continue;
> > cladatum = policydbp->class_val_to_struct[i];
> > 
> > ......
> > 
> > if (!perdatum) {
> > if (!suppress)
> > yyerror2("permission %s is not defined for class %s", id,
> > policydbp->p_class_val_to_name[i]);
> > continue;
> > } else if (!is_perm_in_scope(id, policydbp->p_class_val_to_name[i])) {
> > if (!suppress) {
> > yyerror2("permission %s of class %s is not within scope", id,
> > policydbp->p_class_val_to_name[i]);
> > }
> > continue;
> > } else {
> > cur_perms->data |= 1U << (perdatum->s.value - 1);
> > }
> > 
> > next:
> > cur_perms = cur_perms->next;
> > }
> > 
> > free(id);
> > 
> > }
> > 
> > If the current permission is not defined for the class, then we should 
> > not simply continue the next loop, but do "goto next", since we need to 
> > move up to the next element in the cur_perms accordingly (the Nth 
> > non-zero bit and the Nth element of class_perm_node_t are all about the 
> > same class), perhaps this is a bug, am I right ?
> > 
> 
> This is very historical and could possibly be removed, suppress doesn't
> seem to ever be set anymore. This code use to exist circa 2004:
> 
> if (policyvers < POLICYDB_VERSION_NLCLASS &&
> (cladatum->value >= SECCLASS_NETLINK_ROUTE_SOCKET &&
> cladatum->value <= SECCLASS_NETLINK_DNRT_SOCKET)) {
> sprintf(errormsg, "remapping class %s to netlink_socket "
> "for policy version %d", id, policyvers);
> yywarn(errormsg);
> classvalue = SECCLASS_NETLINK_SOCKET;
> suppress = 1;
> 
> 
> 
> 
> > 
> > 5, I have two questions in following snippet of link_modules():
> > 
> > /* copy all types, declared and required */
> > for (i = 0; i < len; i++) {
> > state.cur = modules[i];
> > state.cur_mod_name = modules[i]->policy->name;
> > ret =
> > hashtab_map(modules[i]->policy->p_types.table,
> > type_copy_callback, &state);
> > if (ret) {
> > retval = ret;
> > goto cleanup;
> > }
> > }
> > 
> > /* then copy everything else, including aliases, and fixup attributes */
> > for (i = 0; i < len; i++) {
> > state.cur = modules[i];
> > state.cur_mod_name = modules[i]->policy->name;
> > ret =
> > copy_identifiers(&state, modules[i]->policy->symtab, NULL);
> > if (ret) {
> > retval = ret;
> > goto cleanup;
> > }
> > }
> > 
> > 
> > if (policydb_index_others(state.handle, state.base, 0)) {
> > ERR(state.handle, "Error while indexing others");
> > goto cleanup;
> > }
> > 
> > /* copy and remap the module's data over to base */
> > for (i = 0; i < len; i++) {
> > state.cur = modules[i];
> > ret = copy_module(&state, modules[i]);
> > if (ret) {
> > retval = ret;
> > goto cleanup;
> > }
> > }
> > 
> > 1) since copy_identifers() could cover the invoke of type_copy_callback, 
> > then why we need to call it explicitly before calling copy_identifiers()?
> > 
> 
> There are some serious ordering issues in this code. Symbols must be
> copied in a precise order. copy_identifiers is also used elsewhere in
> the code when it is not appropriate to copy types.
> 
> > 2) copy_identifers() has been invoked before calling copy_module(), but 
> > copy_module() could invoke copy_identifers() again. Since 
> > copy_identifers() only gets called by link_modules(), could we stop 
> > copy_module() from invoking copy_identifers() once again ?
> > 
> 
> Interesting. It is possible that we are calling it excessively, though I
> have not tried removing it to see what happens. I'm not completely
> certain what happened here, though it wasn't like that in the historical
> linker, it may have happened during a refactor.
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
 		 	   		  
--_8f8c5216-0394-4ae4-a00c-918048f3007f_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
font-size: 10pt;
font-family:Î¢ÈíÑÅºÚ
}
--></style>
</head>
<body class='hmmessage'>
Hi Joshua,<BR>
&nbsp;<BR>
Many thanks for your response! Hope you had an enjoyable vacation :-)<BR>
&nbsp;<BR>
Well, for the init_parser() problem, so far I am new to lex &amp; yacc, I am most puzzled that&nbsp;some rules are handled when pass == 1 and the id queue is purged when pass == 2, whereas some other&nbsp;rules are handled&nbsp;when pass ==&nbsp;2&nbsp;and the id queue got cleaned up when pass == 1.<BR>
&nbsp;<BR>
Who decides when a particular rule should be&nbsp;processed and when the id queue should be cleaned ?&nbsp;and does it and how does it relate with the syntax of a certain rule ?<BR>
&nbsp;<BR>
Thanks again!<BR>
&nbsp;<BR>
Best regards,<BR>
Harry<BR>&nbsp;<BR>
&gt; Date: Thu, 19 May 2011 21:13:53 -0400<BR>&gt; From: method@manicmethod.com<BR>&gt; To: harrytaurus2002@hotmail.com<BR>&gt; CC: selinux@tycho.nsa.gov<BR>&gt; Subject: Re: A few questions about module compile/link source code<BR>&gt; <BR>&gt; HarryCiao wrote:<BR>&gt; &gt; Hi Joshua,<BR>&gt; &gt; <BR>&gt; &gt; When I am studying the source code about SELinux module <BR>&gt; &gt; compile/link/expansion, so far I run into below 6 questions and would <BR>&gt; &gt; like to ask you about. I believe most of them are silly and I really <BR>&gt; &gt; appreciate you taking time to have a look at them. Or you could point me <BR>&gt; &gt; at some relevant email threads or articles or anything and I could start <BR>&gt; &gt; from there myself. Thanks !!<BR>&gt; <BR>&gt; Sorry for the late response, you caught me on vacation. I'll try to<BR>&gt; answer the questions but it has been 6 years since I looked at some of<BR>&gt; this code (particularly checkpolicy). I'm glad someone new is f!
 inally<BR>&gt; looking at this stuff.<BR>&gt; <BR>&gt; &gt; <BR>&gt; &gt; <BR>&gt; &gt; 1, In is_id_in_scope(), if no scope_datum_t is found in the current <BR>&gt; &gt; module, then return 1 as success:<BR>&gt; &gt; <BR>&gt; &gt; int is_id_in_scope(uint32_t symbol_type, hashtab_key_t id)<BR>&gt; &gt; {<BR>&gt; &gt; scope_datum_t *scope =<BR>&gt; &gt; (scope_datum_t *) hashtab_search(policydbp-&gt;scope[symbol_type].<BR>&gt; &gt; table, id);<BR>&gt; &gt; if (scope == NULL) {<BR>&gt; &gt; return 1; /* id is not known, so return success */<BR>&gt; &gt; }<BR>&gt; &gt; return is_scope_in_stack(scope, stack_top);<BR>&gt; &gt; }<BR>&gt; &gt; <BR>&gt; &gt; Any module, either to define an identifier, or declare it as an outside <BR>&gt; &gt; dependency. Both declare_symbol() and require_symbol() would invoke <BR>&gt; &gt; symtab_insert() to register the identifier's (key, scope_datum_t) pair <BR>&gt; &gt; into the relevant scope[] hashtab, so no scope_datum_t is found would <BR>&gt!
 ; &gt; mean that the identifier is neither defined nor declared ever b
efore, <BR>&gt; &gt; then why to return 1 as success ?<BR>&gt; &gt; <BR>&gt; <BR>&gt; I've been staring at this for a while and really can't recall. It is<BR>&gt; possible that some symbols use to never make it into the scope tables<BR>&gt; (eg., object_t) but I can't seem to trigger it now.<BR>&gt; <BR>&gt; &gt; <BR>&gt; &gt; 2, In define_type(), we get the attribute from the p_types hashtab for <BR>&gt; &gt; the current module:<BR>&gt; &gt; <BR>&gt; &gt; attr = hashtab_search(policydbp-&gt;p_types.table, id);<BR>&gt; &gt; if (!attr) {<BR>&gt; &gt; /* treat it as a fatal error */<BR>&gt; &gt; yyerror2("attribute %s is not declared", id);<BR>&gt; &gt; return -1;<BR>&gt; &gt; }<BR>&gt; &gt; <BR>&gt; &gt; if (attr-&gt;flavor != TYPE_ATTRIB) {<BR>&gt; &gt; yyerror2("%s is a type, not an attribute", id);<BR>&gt; &gt; <BR>&gt; &gt; if ((attr = get_local_type(id, attr-&gt;s.value, 1)) == NULL) {<BR>&gt; &gt; yyerror("Out of memory!");<BR>&gt; &gt; return -1;<BR>&gt; &gt; }<BR>&gt;!
  &gt; <BR>&gt; &gt; But in get_local_type(), if the current block/decl is not <BR>&gt; &gt; global/unconditional block, then the attribute's type_datum_t would be <BR>&gt; &gt; duplicated to the current block/decl's symtab[SYM_TYPES], resulting that <BR>&gt; &gt; the current type identifier would be recorded into type_datum_t.types in <BR>&gt; &gt; the current block/decl's symtab[SYM_TYPES], rather than the one in the <BR>&gt; &gt; p_types hashtab.<BR>&gt; &gt; <BR>&gt; &gt; Why would we need to get the local attribute from current block/decl's <BR>&gt; &gt; symtab then set its ebitmap, rather than setting the ebitmap for the one <BR>&gt; &gt; in p_types ?<BR>&gt; &gt; <BR>&gt; <BR>&gt; The types are set in the local decl block so that when the optional<BR>&gt; decl's have been disabled those types won't end up in the final<BR>&gt; attribute bitmap.<BR>&gt; <BR>&gt; &gt; <BR>&gt; &gt; 3, Who decides the value for the "pass" argument to all those parser <BR>&gt; &gt; functio!
 ns? how and when the value for pass is determined?<BR>&gt; &gt; <BR>&g
t; &gt; Say in define_attrib(), when pass == 1, the token in id_queue is parsed <BR>&gt; &gt; but when pass == 2, the id_queue is purged:<BR>&gt; &gt; <BR>&gt; &lt;snip&gt;<BR>&gt; &gt; <BR>&gt; &gt; By whom/when/how is "pass" set to be 1 or 2 ?<BR>&gt; &gt; <BR>&gt; <BR>&gt; Look at init_parser() and the calls to it.<BR>&gt; <BR>&gt; &gt; <BR>&gt; &gt; 4, In define_te_avtab_helper(), if the current permission is not defined <BR>&gt; &gt; for a class, then "continue" to the next loop to handle the next class <BR>&gt; &gt; (to get the current permission's policy value defined in the class, <BR>&gt; &gt; record it in the class_perm_node_t.data for that class) :<BR>&gt; &gt; <BR>&gt; &gt; while ((id = queue_remove(id_queue))) {<BR>&gt; &gt; cur_perms = perms;<BR>&gt; &gt; ebitmap_for_each_bit(&amp;tclasses, node, i) {<BR>&gt; &gt; if (!ebitmap_node_get_bit(node, i))<BR>&gt; &gt; continue;<BR>&gt; &gt; cladatum = policydbp-&gt;class_val_to_struct[i];<BR>&gt; &gt; <BR>&gt; &gt; .!
 .....<BR>&gt; &gt; <BR>&gt; &gt; if (!perdatum) {<BR>&gt; &gt; if (!suppress)<BR>&gt; &gt; yyerror2("permission %s is not defined for class %s", id,<BR>&gt; &gt; policydbp-&gt;p_class_val_to_name[i]);<BR>&gt; &gt; continue;<BR>&gt; &gt; } else if (!is_perm_in_scope(id, policydbp-&gt;p_class_val_to_name[i])) {<BR>&gt; &gt; if (!suppress) {<BR>&gt; &gt; yyerror2("permission %s of class %s is not within scope", id,<BR>&gt; &gt; policydbp-&gt;p_class_val_to_name[i]);<BR>&gt; &gt; }<BR>&gt; &gt; continue;<BR>&gt; &gt; } else {<BR>&gt; &gt; cur_perms-&gt;data |= 1U &lt;&lt; (perdatum-&gt;s.value - 1);<BR>&gt; &gt; }<BR>&gt; &gt; <BR>&gt; &gt; next:<BR>&gt; &gt; cur_perms = cur_perms-&gt;next;<BR>&gt; &gt; }<BR>&gt; &gt; <BR>&gt; &gt; free(id);<BR>&gt; &gt; <BR>&gt; &gt; }<BR>&gt; &gt; <BR>&gt; &gt; If the current permission is not defined for the class, then we should <BR>&gt; &gt; not simply continue the next loop, but do "goto next", since we need to <BR>&gt; &gt; move up to th!
 e next element in the cur_perms accordingly (the Nth <BR>&gt; &gt; non
-zero bit and the Nth element of class_perm_node_t are all about the <BR>&gt; &gt; same class), perhaps this is a bug, am I right ?<BR>&gt; &gt; <BR>&gt; <BR>&gt; This is very historical and could possibly be removed, suppress doesn't<BR>&gt; seem to ever be set anymore. This code use to exist circa 2004:<BR>&gt; <BR>&gt; if (policyvers &lt; POLICYDB_VERSION_NLCLASS &amp;&amp;<BR>&gt; (cladatum-&gt;value &gt;= SECCLASS_NETLINK_ROUTE_SOCKET &amp;&amp;<BR>&gt; cladatum-&gt;value &lt;= SECCLASS_NETLINK_DNRT_SOCKET)) {<BR>&gt; sprintf(errormsg, "remapping class %s to netlink_socket "<BR>&gt; "for policy version %d", id, policyvers);<BR>&gt; yywarn(errormsg);<BR>&gt; classvalue = SECCLASS_NETLINK_SOCKET;<BR>&gt; suppress = 1;<BR>&gt; <BR>&gt; <BR>&gt; <BR>&gt; <BR>&gt; &gt; <BR>&gt; &gt; 5, I have two questions in following snippet of link_modules():<BR>&gt; &gt; <BR>&gt; &gt; /* copy all types, declared and required */<BR>&gt; &gt; for (i = 0; i &lt; len; i++) {<BR>&gt; &gt; sta!
 te.cur = modules[i];<BR>&gt; &gt; state.cur_mod_name = modules[i]-&gt;policy-&gt;name;<BR>&gt; &gt; ret =<BR>&gt; &gt; hashtab_map(modules[i]-&gt;policy-&gt;p_types.table,<BR>&gt; &gt; type_copy_callback, &amp;state);<BR>&gt; &gt; if (ret) {<BR>&gt; &gt; retval = ret;<BR>&gt; &gt; goto cleanup;<BR>&gt; &gt; }<BR>&gt; &gt; }<BR>&gt; &gt; <BR>&gt; &gt; /* then copy everything else, including aliases, and fixup attributes */<BR>&gt; &gt; for (i = 0; i &lt; len; i++) {<BR>&gt; &gt; state.cur = modules[i];<BR>&gt; &gt; state.cur_mod_name = modules[i]-&gt;policy-&gt;name;<BR>&gt; &gt; ret =<BR>&gt; &gt; copy_identifiers(&amp;state, modules[i]-&gt;policy-&gt;symtab, NULL);<BR>&gt; &gt; if (ret) {<BR>&gt; &gt; retval = ret;<BR>&gt; &gt; goto cleanup;<BR>&gt; &gt; }<BR>&gt; &gt; }<BR>&gt; &gt; <BR>&gt; &gt; <BR>&gt; &gt; if (policydb_index_others(state.handle, state.base, 0)) {<BR>&gt; &gt; ERR(state.handle, "Error while indexing others");<BR>&gt; &gt; goto cleanup;<BR>&gt; &gt; }<B!
 R>&gt; &gt; <BR>&gt; &gt; /* copy and remap the module's data over to 
base */<BR>&gt; &gt; for (i = 0; i &lt; len; i++) {<BR>&gt; &gt; state.cur = modules[i];<BR>&gt; &gt; ret = copy_module(&amp;state, modules[i]);<BR>&gt; &gt; if (ret) {<BR>&gt; &gt; retval = ret;<BR>&gt; &gt; goto cleanup;<BR>&gt; &gt; }<BR>&gt; &gt; }<BR>&gt; &gt; <BR>&gt; &gt; 1) since copy_identifers() could cover the invoke of type_copy_callback, <BR>&gt; &gt; then why we need to call it explicitly before calling copy_identifiers()?<BR>&gt; &gt; <BR>&gt; <BR>&gt; There are some serious ordering issues in this code. Symbols must be<BR>&gt; copied in a precise order. copy_identifiers is also used elsewhere in<BR>&gt; the code when it is not appropriate to copy types.<BR>&gt; <BR>&gt; &gt; 2) copy_identifers() has been invoked before calling copy_module(), but <BR>&gt; &gt; copy_module() could invoke copy_identifers() again. Since <BR>&gt; &gt; copy_identifers() only gets called by link_modules(), could we stop <BR>&gt; &gt; copy_module() from invoking copy_identifers() onc!
 e again ?<BR>&gt; &gt; <BR>&gt; <BR>&gt; Interesting. It is possible that we are calling it excessively, though I<BR>&gt; have not tried removing it to see what happens. I'm not completely<BR>&gt; certain what happened here, though it wasn't like that in the historical<BR>&gt; linker, it may have happened during a refactor.<BR>&gt; <BR>&gt; <BR>&gt; --<BR>&gt; This message was distributed to subscribers of the selinux mailing list.<BR>&gt; If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<BR>&gt; the words "unsubscribe selinux" without quotes as the message.<BR> 		 	   		  </body>
</html>
--_8f8c5216-0394-4ae4-a00c-918048f3007f_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
