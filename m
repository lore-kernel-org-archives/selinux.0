Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n21MNXlS020430
	for <selinux@tycho.nsa.gov>; Sun, 1 Mar 2009 17:23:33 -0500
Received: from tundra.namei.org (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n21MNWQL025061
	for <selinux@tycho.nsa.gov>; Sun, 1 Mar 2009 22:23:32 GMT
Date: Mon, 2 Mar 2009 09:23:00 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: selinux@tycho.nsa.gov, rick.mcneal@lsi.com
Subject: Re: [PATCH] selinux: Fix a panic in
 selinux_netlbl_inode_permission()
In-Reply-To: <20090227200003.14235.99157.stgit@flek.lan>
Message-ID: <alpine.LRH.2.00.0903020921320.867@tundra.namei.org>
References: <20090227200003.14235.99157.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 27 Feb 2009, Paul Moore wrote:

> Rick McNeal from LSI identified a panic in selinux_netlbl_inode_permission()
> caused by a certain sequence of SUNRPC operations.  The problem appears to be
> due to the lack of NULL pointer checking in the function; this patch adds the
> pointer checks so the function will exit safely in the cases where the socket
> is not completely initialized.

>From which kernel does this happen?  Does it happen for the standard 
configuration when SELinux is enabled?

> 
> Signed-off-by: Paul Moore <paul.moore@hp.com>
> ---
> 
>  security/selinux/netlabel.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
> index 3f4b266..350794a 100644
> --- a/security/selinux/netlabel.c
> +++ b/security/selinux/netlabel.c
> @@ -386,11 +386,12 @@ int selinux_netlbl_inode_permission(struct inode *inode, int mask)
>  	if (!S_ISSOCK(inode->i_mode) ||
>  	    ((mask & (MAY_WRITE | MAY_APPEND)) == 0))
>  		return 0;
> -
>  	sock = SOCKET_I(inode);
>  	sk = sock->sk;
> +	if (sk == NULL)
> +		return 0;
>  	sksec = sk->sk_security;
> -	if (sksec->nlbl_state != NLBL_REQUIRE)
> +	if (sksec == NULL || sksec->nlbl_state != NLBL_REQUIRE)
>  		return 0;
>  
>  	local_bh_disable();
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
