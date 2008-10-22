Subject: Re: Use of optional_policy in templates (compiler bug or feature?)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: Joshua Brindle <method@manicmethod.com>,
        Daniel J Walsh <dwalsh@redhat.com>, Joe Nall <joe@nall.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <48FD19BB.1090503@tycho.nsa.gov>
References: <CDFE55B0-379E-4CC5-AA3F-03FC6B622DF1@nall.com>
	 <1224096411.21012.46.camel@gorn.columbia.tresys.com>
	 <842B0735-FCD6-4BAF-B8D3-A462B1D5C9E4@nall.com>
	 <1224161367.21012.57.camel@gorn.columbia.tresys.com>
	 <B644A871-625C-477E-A9EA-6FF003227C8B@nall.com>
	 <48F754B5.8020302@manicmethod.com> <48FCCBB1.1010004@redhat.com>
	 <9E8A5545-7705-4CD3-9015-30AD17FA0AFE@nall.com>
	 <48FD19BB.1090503@tycho.nsa.gov>
Content-Type: text/plain
Date: Wed, 22 Oct 2008 10:01:10 -0400
Message-Id: <1224684070.29917.13.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-10-20 at 19:52 -0400, Eamon Walsh wrote:
> Joe Nall wrote:
> > I'm really struggling to get our mls X policy to work around this  
> > issue. I have to rebuild the base policy for every change because the  
> > change has to be in the optional. blagh.
> >
> > joe
> >   
> 
> We took a look at this and applied the following patch to checkmodule:
> 
> diff --git a/checkpolicy/module_compiler.c
> b/checkpolicy/module_compiler.c
> index 36d20be..c8a6d05 100644
> --- a/checkpolicy/module_compiler.c
> +++ b/checkpolicy/module_compiler.c
> @@ -904,8 +904,7 @@ static int require_type_or_attribute(int pass,
> unsigned char isattr)
>  			return -1;
>  		}
>  	case -2:{
> -			yyerror("duplicate declaration of type/attribute");
> -			return -1;
> +			return 0;
>  		}
>  	case -1:{
>  			yyerror("could not require type/attribute here");
> 
> 
> 
> The magic -2 value is documented at the top of require_symbol() as
> meaning "duplicate declaration", however, in the bowels of the
> function
> (module_compiler.c line 628) this is contradicted by the statement
> "previous declaration was not in scope or had a mismatched
> type/attribute."  So I think the error message touched in the above
> patch is wrong, or at least not always correct.
> 
> Anyway, the return -2 on line 628 is the case encountered by Joe's
> test
> code.  And in fact applying the above patch changes the error to:
> 
> /home/ewalsh/git/selinux/checkpolicy/checkmodule:  loading policy
> configuration from tmp/swo.tmp
> swo.te":4:ERROR 'type swo_dbusd_t is not within scope' at token ';' on
> line 77949:
>         allow swo_t swo_dbusd_t:dbus send_msg;
> #line 4
> /home/ewalsh/git/selinux/checkpolicy/checkmodule:  error(s)
> encountered while parsing configuration
> 
> 
> So perhaps we could do something like go back and promote type
> declarations in optional blocks into the containing scope when a
> require
> is encountered further along?  Josh?

What's wrong with just falling through in the require-follows-decl case
and adding the avrule decl id to the scope datum such that later
is_id_in_scope() checks succeed?  With this patch applied, the trivial
sample module posted by Joe builds for me, and can be inserted w/o
error.  I did notice however that I could also get it to build w/o
changing checkmodule by reversing the order of the interface calls there
- not sure if that workaround is usable in the original case that
triggered this bug report.

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index d623343..be9c334 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -1273,9 +1273,6 @@ int symtab_insert(policydb_t * pol, uint32_t sym,
 		}
 	} else if (scope_datum->scope == SCOPE_REQ && scope == SCOPE_DECL) {
 		scope_datum->scope = SCOPE_DECL;
-	} else if (scope_datum->scope != scope) {
-		/* This only happens in DECL then REQUIRE case, which is handled by caller */
-		return -2;
 	}
 
 	/* search through the pre-existing list to avoid adding duplicates */

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
