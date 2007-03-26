Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2QK5O9E024504
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2007 16:05:24 -0400
Received: from mail1.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2QK5MYx001154
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2007 20:05:23 GMT
Date: Mon, 26 Mar 2007 16:05:17 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Joy Latten <latten@austin.ibm.com>
cc: netdev@vger.kernel.org, davem@davemloft.net, eparis@redhat.com,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH]: Add security check before flushing SAD/SPD
In-Reply-To: <200703261939.l2QJd7X7012809@faith.austin.ibm.com>
Message-ID: <Line.LNX.4.64.0703261600210.14555@d.namei>
References: <200703261939.l2QJd7X7012809@faith.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 26 Mar 2007, Joy Latten wrote:

> Signed-off-by: Joy Latten<latten@austin.ibm.com>

This looks ok to me, although I have a couple of minor issues (which 
should probably not stop it being merged):

> +			if ((err = security_xfrm_policy_delete(pol)) != 0) {

The value of 'err' is implicitly inverted several times in this function 
(and similarly in the state flush one).  Something like

	ret = (fn() != 0);

might be better.


> +                }
> +		for (i = xfrm_policy_bydst[dir].hmask; i >= 0; i--) {

Tab damage?


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
