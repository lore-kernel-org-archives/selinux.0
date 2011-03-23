Subject: Re: [v0 PATCH 2/5] Make role_transition parser to handle class
 field
From: Eric Paris <eparis@redhat.com>
To: Harry Ciao <qingtao.cao@windriver.com>
Cc: sds@tycho.nsa.gov, jmorris@namei.org, eparis@parisplace.org,
        selinux@tycho.nsa.gov
In-Reply-To: <1300847325-20308-6-git-send-email-qingtao.cao@windriver.com>
References: <1300847325-20308-1-git-send-email-qingtao.cao@windriver.com>
	 <1300847325-20308-6-git-send-email-qingtao.cao@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 23 Mar 2011 15:30:34 -0400
Message-ID: <1300908634.28871.16.camel@unknown001a4b0c2895>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2011-03-23 at 10:28 +0800, Harry Ciao wrote:
> From: Harry Ciao <harrytaurus2002@hotmail.com>
> 
> If no class is specified in the role_transition rule, then it would
> be set to the "process" class by default.
> 
> Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
> ---
>  checkpolicy/policy_define.c |   89 ++++++++++++++++++++++++++++++++-----------
>  checkpolicy/policy_define.h |    2 +-
>  checkpolicy/policy_parse.y  |    4 +-
>  3 files changed, 71 insertions(+), 24 deletions(-)
> 
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 82ab44c..6c28d8a 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -2050,17 +2050,18 @@ static int set_roles(role_set_t * set, char *id)
>  	return 0;
>  }
>  
> -int define_role_trans(void)
> +int define_role_trans(int class_specified)
>  {
>  	char *id;
>  	role_datum_t *role;
>  	role_set_t roles;
>  	type_set_t types;
> -	ebitmap_t e_types, e_roles;
> -	ebitmap_node_t *tnode, *rnode;
> +	class_datum_t *cladatum;
> +	ebitmap_t e_types, e_roles, classes;

minor nit, most of this code uses e_* for ebitmaps.  You don't need to
change that.....

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
