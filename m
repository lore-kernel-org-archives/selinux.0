Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0HJDNIC006616
	for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2008 14:13:24 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m0HJDHsv027064
	for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2008 19:13:17 GMT
Message-ID: <478FA8C3.40600@manicmethod.com>
Date: Thu, 17 Jan 2008 14:13:07 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Paul Moore <paul.moore@hp.com>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH] REFPOL: Add "rogue" Fedora packet class permissions
References: <20080117172246.341834342@hp.com>
In-Reply-To: <20080117172246.341834342@hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:
> At some point in the Fedora 6 timeframe the "flow_in" and "flow_out"
> permissions were added to the "packet" class, most likely as part of the
> ill-fated secid-reconciliation effort.  Despite the fact that these permissions
> are not currently used they should be included in the Reference Policy as they
> are now a permanent fixture in Fedora and it is crucial that the FLASK
> defines be kept in sync.
>
> This patch needs to be applied before any other patches that affect the
> "packet" class, otherwise the resulting policy may not load.
>
>   

Hrm, they are last in the class definitions so until new perms are added 
to that class it is fairly irrelevant. The policy upgrade to remove them 
would only require a reboot to get rid of them so adding them to 
upstream refpolicy doesn't seem necessary at all.

This also points out how much of a bad idea it is to add object 
class/perm definitions into distro policies before they are in 
refpolicy, I hope that this will be avoided in the future.

I'm not sure what Chris feels about this but I'm opposed to adding 
definitions to the policy like this.

> Signed-off-by: Paul Moore <paul.moore@hp.com>
> ---
>  policy/flask/access_vectors |    2 ++
>  1 file changed, 2 insertions(+)
>
> Index: refpolicy_svn_repo/policy/flask/access_vectors
> ===================================================================
> --- refpolicy_svn_repo.orig/policy/flask/access_vectors
> +++ refpolicy_svn_repo/policy/flask/access_vectors
> @@ -644,6 +644,8 @@ class packet
>  	send
>  	recv
>  	relabelto
> +	flow_in		# not currently in use
> +	flow_out	# not currently in use
>  }
>  
>  class key
>
>   



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
