Message-ID: <36282A1733C57546BE392885C061859201466C09@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: James Morris <jmorris@namei.org>
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, sds@tycho.nsa.gov,
        Chad Hanson <chanson@TrustedCS.com>
Subject: RE: [RFC 2/3] secid reconciliation on inbound: add LSM hooks
Date: Wed, 2 Aug 2006 08:49:22 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > -	if (err)
> > -		goto out;
> > +	/* if (err) */
> > +	/*	goto out; */
> > 
> > -	err = selinux_xfrm_sock_rcv_skb(sksec->sid, skb, &ad);
> > -out:	+	/* err = 
> selinux_xfrm_sock_rcv_skb(sksec->sid, skb, &ad); */
> > +out:	 	return err;
> > }
> 
> 
> Did you mean to leave the call to selinux_xfrm_sock_rcv_skb() 
> commented 
> out?

I actually meant to take the call out entirely. Will fix this in
the next round.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
