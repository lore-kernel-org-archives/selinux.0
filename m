Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m03GBsXS005600
	for <selinux@tycho.nsa.gov>; Thu, 3 Jan 2008 11:11:54 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m03GBrjV027150
	for <selinux@tycho.nsa.gov>; Thu, 3 Jan 2008 16:11:53 GMT
Subject: Re: [PATCH] REFPOL: Add new object classes and permissions for
	labeled networking
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20071221192242.533048995@flek.lan>
References: <20071221192242.533048995@flek.lan>
Content-Type: text/plain
Date: Thu, 03 Jan 2008 11:10:52 -0500
Message-Id: <1199376652.12626.314.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-12-21 at 14:22 -0500, Paul Moore wrote:
> plain text document attachment (selinux-flask_peer_perms)
> This patch reserves a new object class and permissions needed by the labeled
> networking changes scheduled for 2.6.25.

Merged.

> Signed-off-by: Paul Moore <paul.moore@hp.com>
> ---
>  policy/flask/access_vectors   |   10 ++++++++++
>  policy/flask/security_classes |    3 +++
>  2 files changed, 13 insertions(+)
> 
> Index: refpolicy_svn_repo/policy/flask/access_vectors
> ===================================================================
> --- refpolicy_svn_repo.orig/policy/flask/access_vectors
> +++ refpolicy_svn_repo/policy/flask/access_vectors
> @@ -201,6 +201,8 @@ class node 
>  	enforce_dest
>  	dccp_recv
>  	dccp_send
> +	recvfrom
> +	sendto
>  }
>  
>  class netif
> @@ -213,6 +215,8 @@ class netif
>  	rawip_send
>  	dccp_recv
>  	dccp_send
> +	ingress
> +	egress
>  }
>  
>  class netlink_socket
> @@ -726,3 +730,9 @@ inherits database
>  	import
>  	export
>  }
> +
> +# network peer labels
> +class peer
> +{
> +	recv
> +}
> Index: refpolicy_svn_repo/policy/flask/security_classes
> ===================================================================
> --- refpolicy_svn_repo.orig/policy/flask/security_classes
> +++ refpolicy_svn_repo/policy/flask/security_classes
> @@ -106,4 +106,7 @@ class db_column			# userspace
>  class db_tuple			# userspace
>  class db_blob			# userspace
>  
> +# network peer labels
> +class peer
> +
>  # FLASK
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
