Date: Mon, 19 Nov 2007 22:44:56 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
cc: labeled-nfs@linux-nfs.org, selinux@tycho.nsa.gov
Subject: Re: [Labeled-nfs] [PATCH 09/13] NFS: Client implementation of SELINUX
 Labeling
In-Reply-To: <1195243860.20981.21.camel@moss-terrapins.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.64.0711192234270.20955@us.intercode.com.au>
References: <1195243404.20981.3.camel@moss-terrapins.epoch.ncsc.mil>
 <1195243860.20981.21.camel@moss-terrapins.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 16 Nov 2007, David P. Quigley wrote:

> +#ifdef CONFIG_NFS_V4_SECURITY_LABEL
> +	if (attr.ia_label != NULL)
> +		kfree(attr.ia_label);
> +#endif

Will it be typical for ia_label to be non-NULL ?  If so, you can leave out 
the NULL check, as kfree() does that via unlikely().  i.e. only check for 
NULL if you think it is likely (>90%) that it will be NULL.

Generally, you'll likely need to remove all of the #ifdefs from the core 
code, and use static inlines or normal functions instead (to be compiled 
away when not required).

> +	sattr.ia_label = (char *)buf;

No need to cast void pointers.



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
