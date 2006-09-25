Subject: Re: [PATCH take 2] allow range_transitions and MLS users in modules
From: Joshua Brindle <jbrindle@tresys.com>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: SELinux List <selinux@tycho.nsa.gov>,
        Christopher PeBenito <cpebenito@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <45182FCB.4070104@trustedcs.com>
References: <450EDC2E.50009@trustedcs.com>  <45182FCB.4070104@trustedcs.com>
Content-Type: text/plain
Date: Mon, 25 Sep 2006 15:58:07 -0400
Message-Id: <1159214287.3169.58.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-09-25 at 14:36 -0500, Darrel Goeddel wrote:
> - Add the ability to require MLS sensitivities and categories in policy
>   modules.
> - Remove the restrictions on defining users in MLS-enabled modules.
> - Handle range_trans_rules in modules.
> 
> This all allows range_transition statements to be used in policy modules
> and allows definition of users in MLS policy modules.
> 
> Signed-off-by: Darrel Goeddel <dgoeddel@trustedcs.com>
> 
> ---
> 
> This version incorporates the requested struct initializers.
> 
> checkpolicy/module_compiler.c              |  113 +++++++++++++++++
> checkpolicy/module_compiler.h              |    2
> checkpolicy/policy_parse.y                 |   19 +-
> libsepol/include/sepol/policydb/policydb.h |    2
> libsepol/src/expand.c                      |   10 +
> libsepol/src/link.c                        |  189 +++++++++++++++++++++++++----
> libsepol/src/policydb.c                    |   21 ++-
> 7 files changed, 317 insertions(+), 39 deletions(-)
> 
> diff -ruNp --exclude=.svn selinux/checkpolicy/module_compiler.c selinux-modular-mls/checkpolicy/module_compiler.c
> --- selinux/checkpolicy/module_compiler.c	2006-09-05 06:44:56.000000000 -0500
> +++ selinux-modular-mls/checkpolicy/module_compiler.c	2006-09-25 04:14:15.000000000 -0500
> @@ -937,6 +937,119 @@ int require_bool(int pass)
>  	}
>  }
>  
> +int require_sens(int pass)
> +{
> +	char *id = queue_remove(id_queue);
> +	level_datum_t *level = NULL;
> +	int retval;
> +	if (pass == 2) {
> +		free(id);
> +		return 0;
> +	}
> +	if (!id) {
> +		yyerror("no sensitivity name");
> +		return -1;
> +	}
> +	level = calloc(1, sizeof(level_datum_t));
> +	if (!level) {
> +		free(id);
> +		yyerror("Out of memory!");
> +		return -1;
> +	}

did level_datum_init get missed?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
