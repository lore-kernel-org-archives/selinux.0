Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1CEbtUw021897
	for <selinux@tycho.nsa.gov>; Tue, 12 Feb 2008 09:37:55 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m1CEbs4S022598
	for <selinux@tycho.nsa.gov>; Tue, 12 Feb 2008 14:37:54 GMT
Subject: Re: [PATCH 1/4] REFPOL: Add "rogue" Fedora packet class permissions
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: paul.moore@hp.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20080208212822.224178508@hp.com>
References: <20080208212534.491651808@hp.com>
	 <20080208212822.224178508@hp.com>
Content-Type: text/plain
Date: Tue, 12 Feb 2008 09:35:44 -0500
Message-Id: <1202826944.30706.2.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-02-08 at 16:25 -0500, paul.moore@hp.com wrote:
> plain text document attachment (refpol-flask_fedora_fix)
> At some point in the Fedora 6 timeframe the "flow_in" and "flow_out"
> permissions were added to the "packet" class, most likely as part of the
> ill-fated secid-reconciliation effort.  Despite the fact that these permissions
> are not currently used they should be included in the Reference Policy as they
> are now a permanent fixture in Fedora and it is crucial that the FLASK
> defines be kept in sync.
> 
> This patch needs to be applied before any other patches that affect the
> "packet" class, otherwise the resulting policy may not load.

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
> @@ -650,6 +650,8 @@ class packet
>  	send
>  	recv
>  	relabelto
> +	flow_in		# not currently in use
> +	flow_out	# not currently in use
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
