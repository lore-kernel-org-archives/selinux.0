Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2QKYUjc025834
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2007 16:34:30 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2QKYTRM002981
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2007 20:34:29 GMT
Subject: Re: [PATCH]: Add security check before flushing SAD/SPD
From: Eric Paris <eparis@parisplace.org>
To: Joy Latten <latten@austin.ibm.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, jmorris@namei.org,
        selinux@tycho.nsa.gov
In-Reply-To: <200703261939.l2QJd7X7012809@faith.austin.ibm.com>
References: <200703261939.l2QJd7X7012809@faith.austin.ibm.com>
Content-Type: text/plain
Date: Mon, 26 Mar 2007 16:34:11 -0400
Message-Id: <1174941251.17953.4.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-03-26 at 13:39 -0600, Joy Latten wrote:
> +			if ((err = security_xfrm_policy_delete(pol)) != 0) {
> +				xfrm_audit_log(audit_info->loginuid,
> +					       audit_info->secid,
> +					       AUDIT_MAC_IPSEC_DELSPD,
> +					       err ? 0 : 1, pol, NULL);
> +				return err;

In all of the denial log statements you keep the "err ? 0 : 1" which are
common among audit, but in this patch we always know that err is 1. Is
it worth simplifying this down to just a 0 in the all of the
xfrm_audit_log calls?

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
