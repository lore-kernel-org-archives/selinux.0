Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1CEcLq7021956
	for <selinux@tycho.nsa.gov>; Tue, 12 Feb 2008 09:38:21 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m1CEcK4S022704
	for <selinux@tycho.nsa.gov>; Tue, 12 Feb 2008 14:38:20 GMT
Subject: Re: [PATCH 2/4] REFPOL: Add forwarding permissions to the packet
	object class
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: paul.moore@hp.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20080208212823.557882665@hp.com>
References: <20080208212534.491651808@hp.com>
	 <20080208212823.557882665@hp.com>
Content-Type: text/plain
Date: Tue, 12 Feb 2008 09:36:07 -0500
Message-Id: <1202826967.30706.4.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-02-08 at 16:25 -0500, paul.moore@hp.com wrote:
> plain text document attachment (refpol-flask_perms)
> Add the 'forward_in' and 'forward_out' permissions to the packet object class
> to support the new forwarding controls added to the 2.6.25 kernel.

Merged.


> Signed-off-by: Paul Moore <paul.moore@hp.com>
> ---
>  policy/flask/access_vectors |    2 ++
>  1 file changed, 2 insertions(+)
> 
> Index: refpolicy_svn_repo/policy/flask/access_vectors
> ===================================================================
> --- refpolicy_svn_repo.orig/policy/flask/access_vectors
> +++ refpolicy_svn_repo/policy/flask/access_vectors
> @@ -652,6 +652,8 @@ class packet
>  	relabelto
>  	flow_in		# not currently in use
>  	flow_out	# not currently in use
> +	forward_in
> +	forward_out
>  }
>  
>  class key
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
