Date: Fri, 21 Jan 2011 11:07:13 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Davidlohr Bueso <dave@gnu.org>
cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
        LKML <linux-kernel@vger.kernel.org>, selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/3] selinux: return -ENOMEM when memory allocation
 fails
In-Reply-To: <1295548318.2089.11.camel@offworld>
Message-ID: <alpine.LRH.2.00.1101211101150.14355@tundra.namei.org>
References: <1295548318.2089.11.camel@offworld>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 20 Jan 2011, Davidlohr Bueso wrote:

> From: Davidlohr Bueso <dave@gnu.org>
> 
> Signed-off-by: Davidlohr Bueso <dave@gnu.org>
> ---
>  security/selinux/ss/conditional.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
> index c3f845c..a533732 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -178,7 +178,7 @@ int cond_init_bool_indexes(struct policydb *p)
>  	p->bool_val_to_struct = (struct cond_bool_datum **)
>  		kmalloc(p->p_bools.nprim * sizeof(struct cond_bool_datum *), GFP_KERNEL);
>  	if (!p->bool_val_to_struct)
> -		return -1;
> +		return -ENOMEM;
>  	return 0;

The caller has already set -ENOMEM, so the code should probably be updated 
there, too, e.g.

	rc = cond_init_bool_indexes();
	if (rc)
		goto out;



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
