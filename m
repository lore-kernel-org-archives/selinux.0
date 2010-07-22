Subject: Re: [patch 7/7 v2] selinux: fix error codes in symtab_init()
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dan Carpenter <error27@gmail.com>
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        selinux@tycho.nsa.gov
In-Reply-To: <20100612185739.GV5483@bicker>
References: <20100612185739.GV5483@bicker>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 22 Jul 2010 10:53:48 -0400
Message-ID: <1279810428.11197.38.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2010-06-12 at 20:57 +0200, Dan Carpenter wrote:
> hashtab_create() only returns NULL on allocation failures to -ENOMEM is
> appropriate here.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> Acked-by: Eric Paris <eparis@redhat.com>

Acked-by:  Stephen D. Smalley <sds@tycho.nsa.gov>
for the entire series.

> ---
> V2: unchanged.
> 
> diff --git a/security/selinux/ss/symtab.c b/security/selinux/ss/symtab.c
> index bcf9f62..160326e 100644
> --- a/security/selinux/ss/symtab.c
> +++ b/security/selinux/ss/symtab.c
> @@ -36,7 +36,7 @@ int symtab_init(struct symtab *s, unsigned int size)
>  {
>  	s->table = hashtab_create(symhash, symcmp, size);
>  	if (!s->table)
> -		return -1;
> +		return -ENOMEM;
>  	s->nprim = 0;
>  	return 0;
>  }
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
