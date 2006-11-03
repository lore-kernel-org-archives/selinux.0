Subject: RE: How should I run genfscon in my module?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, Dawid Gajownik <gajownik@gmail.com>,
        fedora-selinux-list@redhat.com, SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <1162480950.6503.4.camel@localhost.localdomain>
References: 
	 <6FE441CD9F0C0C479F2D88F959B0158851492D@exchange.columbia.tresys.com>
	 <1162397375.29617.20.camel@localhost.localdomain>
	 <1162405138.32614.248.camel@moss-spartans.epoch.ncsc.mil>
	 <1162480950.6503.4.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 03 Nov 2006 12:53:06 -0500
Message-Id: <1162576386.5519.127.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-11-02 at 10:22 -0500, Karl MacMillan wrote:
> On Wed, 2006-11-01 at 13:18 -0500, Stephen Smalley wrote:
> > On Wed, 2006-11-01 at 11:09 -0500, Karl MacMillan wrote:
> > > On Wed, 2006-11-01 at 10:27 -0500, Joshua Brindle wrote:
> > > > > From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 
> > > > > 
> > > > > > > I looked at fixing this by changing genfscon to use 
> > > > > user_identifier 
> > > > > > > instead of identifier (they are the same except user_identifier 
> > > > > > > includes "-"). This made checkpolicy generate a syntax 
> > > > > error for all 
> > > > > > > genfscon statements - haven't tracked down what the 
> > > > > problem is. The 
> > > > > > > grammer still seems to be unambiguous.
> > > > > > 
> > > > > > Use "user_id" instead.  Otherwise, you'll get a syntax 
> > > > > error when the 
> > > > > > token is classified as an IDENTIFIER (first match) and the grammar 
> > > > > > says that it must be a USER_IDENTIFIER.
> > > > > 
> > > > > Right as usual.
> > > > > 
> > > > 
> > > > Maybe make user_id more generic as it is no longer only used for users..
> > > 
> > > Just making generic would make the user related parts of the grammar
> > > harder to read. What about this:
> 
> > Why not just fold USER_IDENTIFIER back into IDENTIFIER? As in:
> 
> That's fine with me - there is really no reason to disallow "-" in any
> of the identifiers. Makes a lot of documentation wrong, but the docs
> being more restrictive isn't a big deal.

Only possible reason would be to avoid ambiguity in MLS ranges (e.g.
s0-s0:c0.c255), but we already have that problem in checkpolicy from
USER_IDENTIFIER, which is why one has to use spaces around the - in the
range.  So it would only matter is someone put a - in a sensitivity or
category name.

> 
> > 
> > Index: checkpolicy/policy_scan.l
> > ===================================================================
> > --- checkpolicy/policy_scan.l	(revision 2076)
> > +++ checkpolicy/policy_scan.l	(working copy)
> > @@ -200,12 +200,11 @@
> >  h2 |
> >  H2				{ return(H2); }
> >  "/"({letter}|{digit}|_|"."|"-"|"/")*	{ return(PATH); }
> > -{letter}({letter}|{digit}|_|".")*	{ if (is_valid_identifier(yytext)) 
> > +{letter}({letter}|{digit}|_|"."|"-")*	{ if (is_valid_identifier(yytext)) 
> >  						return(IDENTIFIER); 
> >  					  else 
> >  					  	REJECT;
> >  					}
> > -{letter}({letter}|{digit}|_|"."|"-")*	{ return(USER_IDENTIFIER); }
> >  {digit}{digit}*                 { return(NUMBER); }
> >  {hexval}{0,4}":"{hexval}{0,4}":"({hexval}|":"|".")*	{ return(IPV6_ADDR); }
> >  {version}/([ \t\f]*;)           { return(VERSION_IDENTIFIER); }
> > Index: checkpolicy/policy_parse.y
> > ===================================================================
> > --- checkpolicy/policy_parse.y	(revision 2076)
> > +++ checkpolicy/policy_parse.y	(working copy)
> > @@ -190,7 +190,6 @@
> >  %token NOT AND OR XOR
> >  %token CTRUE CFALSE
> >  %token IDENTIFIER
> > -%token USER_IDENTIFIER
> >  %token NUMBER
> >  %token EQUALS
> >  %token NOTEQUAL
> > @@ -522,13 +521,13 @@
> >  			| T1 op T2
> >  			{ $$ = define_cexpr(CEXPR_ATTR, CEXPR_TYPE, $2);
> >  			  if ($$ == 0) return -1; }
> > -			| U1 op { if (insert_separator(1)) return -1; } user_names_push
> > +			| U1 op { if (insert_separator(1)) return -1; } names_push
> >  			{ $$ = define_cexpr(CEXPR_NAMES, CEXPR_USER, $2);
> >  			  if ($$ == 0) return -1; }
> > -			| U2 op { if (insert_separator(1)) return -1; } user_names_push
> > +			| U2 op { if (insert_separator(1)) return -1; } names_push
> >  			{ $$ = define_cexpr(CEXPR_NAMES, (CEXPR_USER | CEXPR_TARGET), $2);
> >  			  if ($$ == 0) return -1; }
> > -			| U3 op { if (insert_separator(1)) return -1; } user_names_push
> > +			| U3 op { if (insert_separator(1)) return -1; } names_push
> >  			{ $$ = define_cexpr(CEXPR_NAMES, (CEXPR_USER | CEXPR_XTARGET), $2);
> >  			  if ($$ == 0) return -1; }
> >  			| R1 op { if (insert_separator(1)) return -1; } names_push
> > @@ -603,10 +602,7 @@
> >  users			: user_def
> >  			| users user_def
> >  			;
> > -user_id			: identifier
> > -			| user_identifier
> > -			;
> > -user_def		: USER user_id ROLES names opt_mls_user ';'
> > +user_def		: USER identifier ROLES names opt_mls_user ';'
> >  	                {if (define_user()) return -1;}
> >  			;
> >  opt_mls_user		: LEVEL mls_level_def RANGE mls_range_def
> > @@ -698,7 +694,7 @@
> >  			  $$ = addr;
> >  			}
> >      			;
> > -security_context_def	: user_id ':' identifier ':' identifier opt_mls_range_def
> > +security_context_def	: identifier ':' identifier ':' identifier opt_mls_range_def
> >  	                ;
> >  opt_mls_range_def	: ':' mls_range_def
> >  			|	
> > @@ -766,23 +762,6 @@
> >  identifier		: IDENTIFIER
> >  			{ if (insert_id(yytext,0)) return -1; }
> >  			;
> > -user_identifier		: USER_IDENTIFIER
> > -			{ if (insert_id(yytext,0)) return -1; }
> > -			;
> > -user_identifier_push	: USER_IDENTIFIER
> > -			{ if (insert_id(yytext, 1)) return -1; }
> > -			;
> > -user_identifier_list_push : user_identifier_push
> > -			| identifier_list_push user_identifier_push
> > -			| user_identifier_list_push identifier_push
> > -			| user_identifier_list_push user_identifier_push
> > -			;
> > -user_names_push		: names_push
> > -			| user_identifier_push
> > -			| '{' user_identifier_list_push '}'
> > -			| tilde_push user_identifier_push
> > -			| tilde_push '{' user_identifier_list_push '}'
> > -			;
> >  path     		: PATH
> >  			{ if (insert_id(yytext,0)) return -1; }
> >  			;
> > 
> > Builds svn refpolicy trunk with strict-mls, no change in policy.21.
> > 
> 
> Acked-by: Karl MacMillan <kmacmillan@mentalrootkit.com>
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
