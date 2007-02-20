Subject: Re: checkpolicy/policy_parse.y:define_class: allow class
	identifiers to contain dots
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Caleb Case <ccase@tresys.com>
Cc: kmacmillan@mentalrootkit.com, jbrindle@tresys.com, selinux@tycho.nsa.gov
In-Reply-To: <200702061631.l16GVKav018375@localhost.localdomain>
References: <200702061631.l16GVKav018375@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 20 Feb 2007 10:25:30 -0500
Message-Id: <1171985130.14363.54.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-02-06 at 11:31 -0500, Caleb Case wrote:
> Class identifiers are now allowed to contain dots.  This facilitates the new dot notation for class names used in metapolicy.
> ---
>  checkpolicy/policy_parse.y |    5 -----
>  1 file changed, 5 deletions(-)
> 
> Index: selinux-pms-support/checkpolicy/policy_parse.y
> ===================================================================
> --- selinux-pms-support.orig/checkpolicy/policy_parse.y
> +++ selinux-pms-support/checkpolicy/policy_parse.y
> @@ -929,11 +929,6 @@ static int define_class(void)
>  		yyerror("no class name for class definition?");
>  		return -1;
>  	}
> -	if (id_has_dot(id)) {
> -		free(id);
> -		yyerror("class identifiers may not contain periods");
> -		return -1;
> -	}
>  	datum = (class_datum_t *) malloc(sizeof(class_datum_t));
>  	if (!datum) {
>  		yyerror("out of memory");

I merged this patch to -stable and -trunk, but am now having second
thoughts.  Class identifiers with dots in them would pose a problem for
symbol definition generation, no?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
