Date: Wed, 20 May 2009 00:09:47 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Eamon Walsh <ewalsh@tycho.nsa.gov>, SELinux List <selinux@tycho.nsa.gov>
Subject: Re: Minor issue with reading selinuxfs booleans.
In-Reply-To: <1242738143.20082.169.camel@localhost.localdomain>
Message-ID: <alpine.LRH.2.00.0905200009360.13191@tundra.namei.org>
References: <4A122FF0.3010609@tycho.nsa.gov> <1242738143.20082.169.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 19 May 2009, Stephen Smalley wrote:

> Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

Applied to 
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#next

> 
> ---
> 
>  security/selinux/selinuxfs.c |    4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 2d5136e..35b447b 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -803,10 +803,6 @@ static ssize_t sel_read_bool(struct file *filep, char __user *buf,
>  		goto out;
>  	}
>  
> -	if (count > PAGE_SIZE) {
> -		ret = -EINVAL;
> -		goto out;
> -	}
>  	page = (char *)get_zeroed_page(GFP_KERNEL);
>  	if (!page) {
>  		ret = -ENOMEM;
> 
> -- 
> Stephen Smalley
> National Security Agency
> 

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
