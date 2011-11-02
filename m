Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pA2DHOkr008839
	for <selinux@tycho.nsa.gov>; Wed, 2 Nov 2011 09:17:24 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id pA2DHMMB018879
	for <selinux@tycho.nsa.gov>; Wed, 2 Nov 2011 13:17:23 GMT
Message-ID: <1320239823.11464.0.camel@localhost>
Subject: Re: [PATCH 50/63] checkpolicy: parse for default_file_trans rules
From: Eric Paris <eparis@redhat.com>
To: Steve Lawrence <slawrence@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
Date: Wed, 02 Nov 2011 09:17:03 -0400
In-Reply-To: <4EB13F82.2090204@tresys.com>
References: <4EB04C77.2070304@redhat.com> <4EB13F82.2090204@tresys.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2011-11-02 at 09:02 -0400, Steve Lawrence wrote:
> On 11/01/2011 03:45 PM, Daniel J Walsh wrote:
> > 
> > OpenPGP: *Attachments to this message have not been signed or encrypted*
> > 
> > ********* *BEGIN ENCRYPTED or SIGNED PART* *********
> > 
> > 
> >    This patch looks good to me. acked.
> > 
> > 
> > 
> > ********** *END ENCRYPTED or SIGNED PART* **********
> > 
> > 0050-checkpolicy-parse-for-default_file_trans-rules.patchFrom 8ead51a6d41f63b43726c617480593f6a8fd0899 Mon Sep 17 00:00:00 2001
> > From: Eric Paris <eparis@redhat.com>
> > Date: Fri, 14 Oct 2011 10:57:20 -0400
> > Subject: [PATCH 50/63] checkpolicy: parse for default_file_trans rules
> > 
> > Signed-off-by: Eric Paris <eparis@redhat.com>
> > ---
> >  checkpolicy/policy_define.c |   33 +++++++++++++++++++++++++++++++++
> >  checkpolicy/policy_define.h |    9 +++++++++
> >  checkpolicy/policy_parse.y  |   21 ++++++++++++++++++++-
> >  checkpolicy/policy_scan.l   |    8 +++++++-
> >  4 files changed, 69 insertions(+), 2 deletions(-)
> > 
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index 1bf669c..838b6aa 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -327,6 +327,39 @@ int define_initial_sid(void)
> >  	return -1;
> >  }
> >  
> > +int define_default_file_trans(int component, int from)
> > +{
> > +	char *id;
> > +	ebitmap_t e_tclasses;
> > +	class_datum_t *cladatum;
> > +
> > +	if (pass == 1) {
> > +		while ((id = queue_remove(id_queue)))
> > +			free(id);
> > +		return 0;
> > +	}
> > +
> > +	ebitmap_init(&e_tclasses);
> > +	while ((id = queue_remove(id_queue))) {
> > +		if (!is_id_in_scope(SYM_CLASSES, id)) {
> > +			yyerror2("class %s is not within scope", id);
> > +			return -1;
> > +		}
> > +		cladatum = hashtab_search(policydbp->p_classes.table, id);
> > +		if (!cladatum) {
> > +			yyerror2("unknown class %s", id);
> > +			return -1;
> > +		}
> > +		if (ebitmap_set_bit(&e_tclasses, cladatum->s.value - 1, TRUE)) {
> > +			yyerror("Out of memory");
> > +			return -1;
> > +		}
> > +		free(id);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  int define_common_perms(void)
> >  {
> >  	char *id = 0, *perm = 0;
> > diff --git a/checkpolicy/policy_define.h b/checkpolicy/policy_define.h
> > index 92a9be7..c77e87d 100644
> > --- a/checkpolicy/policy_define.h
> > +++ b/checkpolicy/policy_define.h
> > @@ -13,6 +13,14 @@
> >  #define TRUE 1
> >  #define FALSE 0
> >  
> > +enum dft_enum {
> > +	DFT_USER,
> > +	DFT_ROLE,
> > +	DFT_LEVEL,
> > +	DFT_PROCESS,
> > +	DFT_PARENT,
> > +};
> > +
> >  avrule_t *define_cond_compute_type(int which);
> >  avrule_t *define_cond_pol_list(avrule_t *avlist, avrule_t *stmt);
> >  avrule_t *define_cond_te_avtab(int which);
> > @@ -52,6 +60,7 @@ int define_role_types(void);
> >  int define_role_attr(void);
> >  int define_roleattribute(void);
> >  int define_filename_trans(void);
> > +int define_default_file_trans(int componnt, int from);
> >  int define_sens(void);
> >  int define_te_avtab(int which);
> >  int define_typealias(void);
> > diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
> > index 1e3ef6f..1107d79 100644
> > --- a/checkpolicy/policy_parse.y
> > +++ b/checkpolicy/policy_parse.y
> > @@ -143,6 +143,9 @@ typedef int (* require_func_t)();
> >  %token POLICYCAP
> >  %token PERMISSIVE
> >  %token FILESYSTEM
> > +%token DEFAULT_FILE_TRANS
> > +%token PROCESS
> > +%token PARENT
> >  
> >  %left OR
> >  %left XOR
> > @@ -160,7 +163,7 @@ base_policy             : { if (define_policy(pass, 0) == -1) return -1; }
> >  			  opt_mls te_rbac users opt_constraints 
> >                           { if (pass == 1) { if (policydb_index_bools(policydbp)) return -1;}
> >  			   else if (pass == 2) { if (policydb_index_others(NULL, policydbp, 0)) return -1;}}
> > -			  initial_sid_contexts opt_fs_contexts opt_fs_uses opt_genfs_contexts net_contexts opt_dev_contexts
> > +			  initial_sid_contexts opt_fs_contexts opt_fs_uses opt_genfs_contexts net_contexts opt_dev_contexts default_file_trans_rules
> >  			;
> >  classes			: class_def 
> >  			| classes class_def
> > @@ -176,6 +179,22 @@ initial_sid_def		: SID identifier
> >  			;
> >  access_vectors		: opt_common_perms av_perms
> >  			;
> > +default_file_trans_rules : default_file_trans_def
> > +                        | default_file_trans_rules default_file_trans_def
> > +                        ;
> > +default_file_trans_def	: DEFAULT_FILE_TRANS USER names PROCESS ';'
> > +			{if (define_default_file_trans(DFT_USER, DFT_PROCESS)) return -1;}
> > +			| DEFAULT_FILE_TRANS ROLE names PROCESS ';'
> > +			{if (define_default_file_trans(DFT_ROLE, DFT_PROCESS)) return -1;}
> > +			| DEFAULT_FILE_TRANS LEVEL names PROCESS ';'
> > +			{if (define_default_file_trans(DFT_LEVEL, DFT_PROCESS)) return -1;}
> > +			| DEFAULT_FILE_TRANS USER names PARENT ';'
> > +			{if (define_default_file_trans(DFT_USER, DFT_PARENT)) return -1;}
> > +			| DEFAULT_FILE_TRANS ROLE names PARENT ';'
> > +			{if (define_default_file_trans(DFT_ROLE, DFT_PARENT)) return -1;}
> > +			| DEFAULT_FILE_TRANS LEVEL names PARENT ';'
> > +			{if (define_default_file_trans(DFT_LEVEL, DFT_PARENT)) return -1;}
> > +			;
> >  opt_common_perms        : common_perms
> >                          |
> >                          ;
> > diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
> > index 2ba5971..c6fd24c 100644
> > --- a/checkpolicy/policy_scan.l
> > +++ b/checkpolicy/policy_scan.l
> > @@ -219,6 +219,12 @@ h2 |
> >  H2				{ return(H2); }
> >  policycap |
> >  POLICYCAP			{ return(POLICYCAP); }
> > +process |
> > +PROCESS				{ return(PROCESS); }
> > +parent |
> > +PARENT				{ return(PARENT); }
> > +default_file_trans |
> > +DEFAULT_FILE_TRANS		{ return(DEFAULT_FILE_TRANS); }
> >  permissive |
> >  PERMISSIVE			{ return(PERMISSIVE); }
> >  "/"({alnum}|[_\.\-/])*	        { return(PATH); }
> > @@ -228,7 +234,7 @@ PERMISSIVE			{ return(PERMISSIVE); }
> >  {hexval}{0,4}":"{hexval}{0,4}":"({hexval}|[:.])*  { return(IPV6_ADDR); }
> >  {digit}+(\.({alnum}|[_.])*)?    { return(VERSION_IDENTIFIER); }
> >  {alnum}*                        { return(FILENAME); }
> > -\.({alnum}|[_\.\-])*	        { return(FILENAME); }
> > +\.({alnum}|[_\.\-])+	        { return(FILENAME); }
> >  {letter}+([-_\.]|{alnum})+      { return(FILENAME); }
> >  ([_\.]){alnum}+                 { return(FILENAME); }
> >  #line[ ]1[ ]\"[^\n]*\"		{ set_source_file(yytext+9); }
> > -- 1.7.7
> 
> This looks like this is the same patch sent to the list a couple of
> weeks ago but with a couple of name changes (e.g. DT -> DFT,
> default_trans -> default_file_trans), and there was still some
> discussion on it. I believe it ended with "Eric is on vacation, we'll
> see what he has to say when he gets back." Is this right?

Yes.  It won't get applied, I just forgot to pull it from my tree before
Dan took a look.  It needs reworked.

-Eric



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
