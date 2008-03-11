Subject: Re: [PATCH] checkpolicy: support for permissive types
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux <selinux@tycho.nsa.gov>, tmiller@tresys.com, jbrindle@tresys.com
In-Reply-To: <1205245845.5297.90.camel@localhost.localdomain>
References: <1205245845.5297.90.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 11 Mar 2008 14:31:36 -0400
Message-Id: <1205260296.23866.172.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-03-11 at 10:30 -0400, Eric Paris wrote:
> This patch adds support for permissive types.
> 
> A very simple module to make httpd_t a permissive domain would be:
> 
> policy_module(permissiveapache, 1.0)
> gen_require(`
> 	type httpd_t;
> ')
> permissive httpd_t;
> 
> Obviously this syntax can be used in both the base policy and in a
> policy module.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>
> 
> ---
> 
>  policy_parse.y |   43 +++++++++++++++++++++++++++++++
>  policy_scan.l  |    4 ++
>  test/dismod.c  |    2 -
>  test/dispol.c  |   78 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 125 insertions(+), 2 deletions(-)
> 
> diff -up checkpolicy-2.0.10/policy_parse.y.pre.permissive checkpolicy-2.0.10/policy_parse.y
> --- checkpolicy-2.0.10/policy_parse.y.pre.permissive	2008-03-11 10:18:31.000000000 -0400
> +++ checkpolicy-2.0.10/policy_parse.y	2008-03-11 10:23:33.000000000 -0400
> @@ -126,6 +126,7 @@ static int define_netif_context(void);
>  static int define_ipv4_node_context(void);
>  static int define_ipv6_node_context(void);
>  static int define_polcap(void);
> +static int define_permissive(void);
>  
>  typedef int (* require_func_t)();
>  
> @@ -201,6 +202,7 @@ typedef int (* require_func_t)();
>  %token IPV6_ADDR
>  %token MODULE VERSION_IDENTIFIER REQUIRE OPTIONAL
>  %token POLICYCAP
> +%token PERMISSIVE
>  
>  %left OR
>  %left XOR
> @@ -327,6 +329,7 @@ te_decl			: attribute_def
>                          | transition_def
>                          | range_trans_def
>                          | te_avtab_def
> +			| permissive_def
>  			;
>  attribute_def           : ATTRIBUTE identifier ';'
>                          { if (define_attrib()) return -1;}
> @@ -772,6 +775,8 @@ ipv6_addr		: IPV6_ADDR
>  policycap_def		: POLICYCAP identifier ';'
>  			{if (define_polcap()) return -1;}
>  			;
> +permissive_def		: PERMISSIVE identifier ';'
> +			{if (define_permissive()) return -1;}
>  
>  /*********** module grammar below ***********/
>  
> @@ -1007,6 +1012,44 @@ static int define_polcap(void)
>  	return -1;
>  }
>  
> +static int define_permissive(void)
> +{

The action functions have been moved out to a separate .c file
(policy_define.[ch]) in the latest checkpolicy, so someone will have to
move this over for merge.  Trivial, of course.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
