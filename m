Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5NK0FgA000628
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 16:00:15 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5NJnoRQ014208
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 19:49:52 GMT
Date: Thu, 23 Jun 2005 15:50:22 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Eric Paris <eparis@parisplace.org>
cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: [PATCH] selinux_sb_copy_data requires a whole page?
In-Reply-To: <1119546920.10817.19.camel@localhost.localdomain>
Message-ID: <Xine.LNX.4.44.0506231548050.14587-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 23 Jun 2005, Eric Paris wrote:

> Is there a good reason I'm missing why we should require a whole page?
> Maybe somebody else (or an old version of lustre) is going to hit on
> this.  Comments?

Actually, a strcpy() should work ok here, as the last byte of the options 
page will always be null terminated (e.g. in do_mount()).


> --- linux-2.6.9/security/selinux/hooks.c.cor	2005-06-23 16:53:05.000000000 -0400
> +++ linux-2.6.9/security/selinux/hooks.c	2005-06-23 16:54:01.000000000 -0400
> @@ -1980,7 +1980,7 @@ static int selinux_sb_copy_data(struct f
>  		}
>  	} while (*in_end++);
>  
> -	copy_page(in_save, nosec_save);
> +	memcpy(in_save, nosec_save, strlen(nosec_save));
>  	free_page((unsigned long)nosec_save);
>  out:
>  	return rc;
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 

-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
