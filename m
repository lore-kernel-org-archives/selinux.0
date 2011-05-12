Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p4C9wpsB020908
	for <selinux@tycho.nsa.gov>; Thu, 12 May 2011 05:58:52 -0400
Received: from snt0-omc1-s51.snt0.hotmail.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p4C9worg013547
	for <selinux@tycho.nsa.gov>; Thu, 12 May 2011 09:58:51 GMT
Message-ID: <SNT139-w488BAEE329DEC249677A49AB890@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_50b67d63-8baa-4967-b6bb-913f9c11e02d_"
From: HarryCiao <harrytaurus2002@hotmail.com>
To: <method@manicmethod.com>, selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: A few questions about module compile/link source code
Date: Thu, 12 May 2011 09:58:46 +0000
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_50b67d63-8baa-4967-b6bb-913f9c11e02d_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi Joshua,

When I am studying the source code about SELinux module compile/link/expansion, so far I run into below 6 questions and would like to ask you about. I believe most of them are silly and I really appreciate you taking time to have a look at them. Or you could point me at some relevant email threads or articles or anything and I could start from there myself. Thanks !!


1, In is_id_in_scope(), if no scope_datum_t is found in the current module, then return 1 as success:

int is_id_in_scope(uint32_t symbol_type, hashtab_key_t id)
{
    scope_datum_t *scope =
        (scope_datum_t *) hashtab_search(policydbp->scope[symbol_type].
                         table, id);
    if (scope == NULL) {
        return 1;    /* id is not known, so return success */
    }
    return is_scope_in_stack(scope, stack_top);
}

Any module, either to define an identifier, or declare it as an outside dependency. Both declare_symbol() and require_symbol() would invoke symtab_insert() to register the identifier's (key, scope_datum_t) pair into the relevant scope[] hashtab, so no scope_datum_t is found would mean that the identifier is neither defined nor declared ever before, then why to return 1 as success ?


2, In define_type(), we get the attribute from the p_types hashtab for the current module:

        attr = hashtab_search(policydbp->p_types.table, id);
        if (!attr) {
            /* treat it as a fatal error */
            yyerror2("attribute %s is not declared", id);
            return -1;
        }

        if (attr->flavor != TYPE_ATTRIB) {
            yyerror2("%s is a type, not an attribute", id);
        
                if ((attr = get_local_type(id, attr->s.value, 1)) == NULL) { 
                        yyerror("Out of memory!"); 
                        return -1; 
                } 

But in get_local_type(), if the current block/decl is not global/unconditional block, then the attribute's type_datum_t would be duplicated to the current block/decl's symtab[SYM_TYPES], resulting that the current type identifier would be recorded into type_datum_t.types in the current block/decl's symtab[SYM_TYPES], rather than the one in the p_types hashtab.

Why would we need to get the local attribute from current block/decl's symtab then set its ebitmap, rather than setting the ebitmap for the one in p_types ?


3, Who decides the value for the "pass" argument to all those parser functions? how and when the value for pass is determined?

Say in define_attrib(), when pass == 1, the token in id_queue is parsed but when pass == 2, the id_queue is purged:

int define_attrib(void)
{
    if (pass == 2) {
        free(queue_remove(id_queue));
        return 0;
    }

    if (declare_type(TRUE, TRUE) == NULL) {
        return -1;
    }
    return 0;
}

But in define_te_avtab(), the id_queue is purged when pass == 1:

int define_te_avtab(int which) 
{ 
        char *id; 
        avrule_t *avrule; 
        int i; 

        if (pass == 1) { 
                for (i = 0; i < 4; i++) { 
                        while ((id = queue_remove(id_queue))) 
                                free(id); 
                } 
                return 0; 
        } 


By whom/when/how is "pass" set to be 1 or 2 ?


4, In define_te_avtab_helper(), if the current permission is not defined for a class, then "continue" to the next loop to handle the next class (to get the current permission's policy value defined in the class, record it in the  class_perm_node_t.data for that class) :

        while ((id = queue_remove(id_queue))) { 
                cur_perms = perms; 
                ebitmap_for_each_bit(&tclasses, node, i) { 
                        if (!ebitmap_node_get_bit(node, i)) 
                                continue; 
                        cladatum = policydbp->class_val_to_struct[i]; 

            ......

                        if (!perdatum) { 
                                if (!suppress) 
                                        yyerror2("permission %s is not defined for class %s", id, 
                                             policydbp->p_class_val_to_name[i]); 
                                continue;             
                        } else if (!is_perm_in_scope(id, policydbp->p_class_val_to_name[i])) { 
                                if (!suppress) { 
                                        yyerror2("permission %s of class %s is not within scope", id, 
                                             policydbp->p_class_val_to_name[i]); 
                                } 
                                continue;             
                        } else { 
                                cur_perms->data |= 1U << (perdatum->s.value - 1); 
                        } 

                      next: 
                        cur_perms = cur_perms->next; 
                } 

                free(id); 

        } 

If the current permission is not defined for the class, then we should not simply continue the next loop, but do "goto next", since we need to move up to the next element in the cur_perms accordingly (the Nth non-zero bit and the Nth element of class_perm_node_t are all about the same class), perhaps this is a bug, am I right ?


5, I have two questions in following snippet of link_modules():

    /* copy all types, declared and required */
    for (i = 0; i < len; i++) {
        state.cur = modules[i];
        state.cur_mod_name = modules[i]->policy->name;
        ret =
            hashtab_map(modules[i]->policy->p_types.table,
                type_copy_callback, &state);
        if (ret) {
            retval = ret;
            goto cleanup;
        }
    }

    /* then copy everything else, including aliases, and fixup attributes */
    for (i = 0; i < len; i++) {
        state.cur = modules[i];
        state.cur_mod_name = modules[i]->policy->name;
        ret =
            copy_identifiers(&state, modules[i]->policy->symtab, NULL);
        if (ret) {
            retval = ret;
            goto cleanup;
        }
    }


    if (policydb_index_others(state.handle, state.base, 0)) {
        ERR(state.handle, "Error while indexing others");
        goto cleanup;
    }

    /* copy and remap the module's data over to base */
    for (i = 0; i < len; i++) {
        state.cur = modules[i];
        ret = copy_module(&state, modules[i]);
        if (ret) {
            retval = ret;
            goto cleanup;
        }
    }

1) since copy_identifers() could cover the invoke of type_copy_callback, then why we need to call it explicitly before calling copy_identifiers()?

2) copy_identifers() has been invoked before calling copy_module(), but copy_module() could invoke copy_identifers() again. Since copy_identifers() only gets called by link_modules(), could we stop copy_module() from invoking copy_identifers() once again ?

Many thanks for all your help!

Best regards,
Harry 		 	   		  
--_50b67d63-8baa-4967-b6bb-913f9c11e02d_
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
Hi Joshua,<br><br>When I am studying the source code about SELinux module compile/link/expansion, so far I run into below 6 questions and would like to ask you about. I believe most of them are silly and I really appreciate you taking time to have a look at them. Or you could point me at some relevant email threads or articles or anything and I could start from there myself. Thanks !!<br><br><br>1, In is_id_in_scope(), if no scope_datum_t is found in the current module, then return 1 as success:<br><br>int is_id_in_scope(uint32_t symbol_type, hashtab_key_t id)<br>{<br>&nbsp;&nbsp; &nbsp;scope_datum_t *scope =<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; (scope_datum_t *) hashtab_search(policydbp-&gt;scope[symbol_type].<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table, id);<br>&nbsp;&nbsp; &nbsp;if (scope == NULL) {<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;return 1;&nbsp;&nbsp; &nbsp;/* id is not know!
 n, so return success */<br>&nbsp;&nbsp; &nbsp;}<br>&nbsp;&nbsp; &nbsp;return is_scope_in_stack(scope, stack_top);<br>}<br><br>Any module, either to define an identifier, or declare it as an outside dependency. Both declare_symbol() and require_symbol() would invoke symtab_insert() to register the identifier's (key, scope_datum_t) pair into the relevant scope[] hashtab, so no scope_datum_t is found would mean that the identifier is neither defined nor declared ever before, then why to return 1 as success ?<br><br><br>2, In define_type(), we get the attribute from the p_types hashtab for the current module:<br><br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;attr = hashtab_search(policydbp-&gt;p_types.table, id);<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;if (!attr) {<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;/* treat it as a fatal error */<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;yyerror2("attribute %s is not declared", id);<br>&nbsp;&nbsp; &nbsp;!
 &nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;return -1;<br>&nbsp;&nbsp; &nbsp
;&nbsp;&nbsp; &nbsp;}<br><br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;if (attr-&gt;flavor != TYPE_ATTRIB) {<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;yyerror2("%s is a type, not an attribute", id);<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((attr = get_local_type(id, attr-&gt;s.value, 1)) == NULL) { <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; yyerror("Out of memory!"); <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -1; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br><br>But in get_local_type(), if the current block/decl is not global/unconditional block, then the attribute's type_datum_t would be duplicated to the !
 current block/decl's symtab[SYM_TYPES], resulting that the current type identifier would be recorded into type_datum_t.types in the current block/decl's symtab[SYM_TYPES], rather than the one in the p_types hashtab.<br><br>Why would we need to get the local attribute from current block/decl's symtab then set its ebitmap, rather than setting the ebitmap for the one in p_types ?<br><br><br>3, Who decides the value for the "pass" argument to all those parser functions? how and when the value for pass is determined?<br><br>Say in define_attrib(), when pass == 1, the token in id_queue is parsed but when pass == 2, the id_queue is purged:<br><br>int define_attrib(void)<br>{<br>&nbsp;&nbsp; &nbsp;if (pass == 2) {<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;free(queue_remove(id_queue));<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;return 0;<br>&nbsp;&nbsp; &nbsp;}<br><br>&nbsp;&nbsp; &nbsp;if (declare_type(TRUE, TRUE) == NULL) {<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;return -1;<br>&nbsp!
 ;&nbsp; &nbsp;}<br>&nbsp;&nbsp; &nbsp;return 0;<br>}<br><br>But in def
ine_te_avtab(), the id_queue is purged when pass == 1:<br><br>int define_te_avtab(int which) <br>{ <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *id; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; avrule_t *avrule; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i; <br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pass == 1) { <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; 4; i++) { <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while ((id = queue_remove(id_queue))) <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; free(id); <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb!
 sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br><br><br>By whom/when/how is "pass" set to be 1 or 2 ?<br><br><br>4, In define_te_avtab_helper(), if the current permission is not defined for a class, then "continue" to the next loop to handle the next class (to get the current permission's policy value defined in the class, record it in the&nbsp; class_perm_node_t.data for that class) :<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while ((id = queue_remove(id_queue))) { <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cur_perms = perms; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ebitmap_for_each_bit(&amp;tclasses, node, i) { <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ebitmap_node_get_bit(node, i)) <br>&nb!
 sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cladatum = policydbp-&gt;class_val_to_struct[i]; <br><br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;......<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!perdatum) { <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!suppress) <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;!
 &nbsp; yyerror2("permission %s is not defined for class %s", id, <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; policydbp-&gt;p_class_val_to_name[i]); <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (!is_perm_in_scope(id, policydbp-&gt;p_class_val_to_name[i])) { <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs!
 p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!suppress) { <b
r>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; yyerror2("permission %s of class %s is not within scope", id, <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; policydbp-&gt;p_class_val_to_name[i]); <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp!
 ; continue; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else { <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cur_perms-&gt;data |= 1U &lt;&lt; (perdatum-&gt;s.value - 1); <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; next: <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cur_perms = cur_perms-&gt;next; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&!
 nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br><br>&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; free(id); <br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br><br>If the current permission is not defined for the class, then we should not simply continue the next loop, but do "goto next", since we need to move up to the next element in the cur_perms accordingly (the Nth non-zero bit and the Nth element of class_perm_node_t are all about the same class), perhaps this is a bug, am I right ?<br><br><br>5, I have two questions in following snippet of link_modules():<br><br>&nbsp;&nbsp; &nbsp;/* copy all types, declared and required */<br>&nbsp;&nbsp; &nbsp;for (i = 0; i &lt; len; i++) {<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;state.cur = modules[i];<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;state.cur_mod_name = modules[i]-&gt;policy-&gt;name;<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;ret =<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; hashtab_map(modules[i]-&gt;policy-&gt;p_types.table!
 ,<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;type_copy_callback, &amp;state);<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;if (ret) {<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;retval = ret;<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;goto cleanup;<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;}<br>&nbsp;&nbsp; &nbsp;}<br><br>&nbsp;&nbsp; &nbsp;/* then copy everything else, including aliases, and fixup attributes */<br>&nbsp;&nbsp; &nbsp;for (i = 0; i &lt; len; i++) {<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;state.cur = modules[i];<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;state.cur_mod_name = modules[i]-&gt;policy-&gt;name;<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;ret =<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; copy_identifiers(&amp;state, modules[i]-&gt;policy-&gt;symtab, NULL);<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;if (ret) {<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;retval !
 = ret;<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;got
o cleanup;<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;}<br>&nbsp;&nbsp; &nbsp;}<br><br><br>&nbsp;&nbsp; &nbsp;if (policydb_index_others(state.handle, state.base, 0)) {<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;ERR(state.handle, "Error while indexing others");<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;goto cleanup;<br>&nbsp;&nbsp; &nbsp;}<br><br>&nbsp;&nbsp; &nbsp;/* copy and remap the module's data over to base */<br>&nbsp;&nbsp; &nbsp;for (i = 0; i &lt; len; i++) {<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;state.cur = modules[i];<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;ret = copy_module(&amp;state, modules[i]);<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;if (ret) {<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;retval = ret;<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;goto cleanup;<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;}<br>&nbsp;&nbsp; &nbsp;}<br><br>1) since copy_identifers() could cover the invoke of type_copy_callback, then why we need to call i!
 t explicitly before calling copy_identifiers()?<br><br>2) copy_identifers() has been invoked before calling copy_module(), but copy_module() could invoke copy_identifers() again. Since copy_identifers() only gets called by link_modules(), could we stop copy_module() from invoking copy_identifers() once again ?<br><br>Many thanks for all your help!<br><br>Best regards,<br>Harry 		 	   		  </body>
</html>
--_50b67d63-8baa-4967-b6bb-913f9c11e02d_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
