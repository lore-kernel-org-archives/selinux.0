Date: Tue, 22 Mar 2016 15:28:17 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Colin King <colin.king@canonical.com>
Cc: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E . Hallyn" <serge@hallyn.com>, Nick Kralevich <nnk@google.com>,
 Jeff Vander Stoep <jeffv@google.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selinux: fix memory leak on node_ptr on error return path
Message-ID: <20160322202817.GA9459@mail.hallyn.com>
References: <1458601213-5835-1-git-send-email-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1458601213-5835-1-git-send-email-colin.king@canonical.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Quoting Colin King (colin.king@canonical.com):
> From: Colin Ian King <colin.king@canonical.com>
> 
> node_ptr is not being free'd if the list allocation fails, fix
> this by kfree'ing it before exiting on the error path.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Hi,

I'm not very familiar with this code any more, but are you sure
this is needed and doesn't cause a new bug?  It *looks* like
the avtab_insert_nonunique() actually inserts the node_ptr
into the policydb, and the policydb is the one that should
eventually free it.

> ---
>  security/selinux/ss/conditional.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
> index 456e1a9..5d010ef 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -332,6 +332,7 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
>  	list = kzalloc(sizeof(struct cond_av_list), GFP_KERNEL);
>  	if (!list) {
>  		rc = -ENOMEM;
> +		kfree(node_ptr);
>  		goto err;
>  	}
>  
> -- 
> 2.7.3
