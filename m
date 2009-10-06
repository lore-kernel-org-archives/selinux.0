Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n96F9i9G032468
	for <selinux@tycho.nsa.gov>; Tue, 6 Oct 2009 11:10:40 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id n96E2IBF015519
	for <selinux@tycho.nsa.gov>; Tue, 6 Oct 2009 14:02:18 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: [refpolicy] [RFC PATCH v1] refpol: Add netif, node and peer constraints for MCS based policies
Date: Tue, 6 Oct 2009 09:20:11 -0400
Message-ID: <1254835214.17694.46.camel@gorn>
In-Reply-To: <20091001213527.16869.87442.stgit@flek.lan>
References: <20091001213527.16869.87442.stgit@flek.lan>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Paul Moore" <paul.moore@hp.com>
Cc: <refpolicy@oss1.tresys.com>, <js44352@gmail.com>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-10-01 at 17:35 -0400, Paul Moore wrote:
> Adapt the MLS netif, node and peer networking constraints for MCS.  This patch
> preserves the basic structure of the MLS constraints and converts them to use
> the MCS model which means the "(( l1 dom l2 ) and ( l1 domby h2 ))" constraints
> are converted to "( h1 dom h2 )".

These need to be switched to MCS-specific attributes.

> Signed-of-by: Paul Moore <paul.moore@hp.com>
> ---
> 
>  policy/mcs |   36 ++++++++++++++++++++++++++++++++++++
>  1 files changed, 36 insertions(+), 0 deletions(-)
> 
> diff --git a/policy/mcs b/policy/mcs
> index b8dc0d6..0759021 100644
> --- a/policy/mcs
> +++ b/policy/mcs
> @@ -99,6 +99,42 @@ mlsconstrain process { sigkill sigstop }
>  	(( h1 dom h2 ) or ( t1 == mcskillall ));
>  
>  #
> +# MCS policy for the network ingress/egress controls
> +#
> +
> +# the netif ingress/egress ops, the ingress permission is a "write" operation
> +# because the subject in this particular case is the remote domain which is
> +# writing data out the network interface which is acting as the object
> +mlsconstrain { netif } { ingress }
> +	(( h1 dom h2 ) or ( t1 == mlsnetinbound ) or ( t1 == unlabeled_t ));
> +mlsconstrain { netif } { egress }
> +	(( h1 dom h2 ) or ( t1 == mlsnetoutbound ));
> +
> +# the node recvfrom/sendto ops, the recvfrom permission is a "write" operation
> +# because the subject in this particular case is the remote domain which is
> +# writing data out the network node which is acting as the object
> +mlsconstrain { node } { recvfrom }
> +	(( h1 dom h2 ) or ( t1 == mlsnetinbound ) or ( t1 == unlabeled_t ));
> +mlsconstrain { node } { sendto }
> +	(( h1 dom h2 ) or ( t1 == mlsnetoutbound ));
> +
> +# the forward ops, the forward_in permission is a "write" operation because the
> +# subject in this particular case is the remote domain which is writing data
> +# to the network with a secmark label, the object in this case
> +mlsconstrain { packet } { forward_in }
> +	(( h1 dom h2 ) or ( t1 == mlsnetinbound ) or ( t1 == unlabeled_t ));
> +mlsconstrain { packet } { forward_out }
> +	(( h1 dom h2 ) or ( t1 == mlsnetoutbound ) or ( t1 == unlabeled_t ));
> +
> +#
> +# MCS policy for the secmark and peer controls
> +#
> +
> +# the peer/packet recv op
> +mlsconstrain { peer packet } { recv }
> +	(( h1 dom h2 ) or ( t1 == mlsnetread ));
> +
> +#
>  # MCS policy for SELinux-enabled databases
>  #

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
