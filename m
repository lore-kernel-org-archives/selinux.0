Message-ID: <36282A1733C57546BE392885C0618592015CF85B@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Paul Moore <paul.moore@hp.com>
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>, netdev@vger.kernel.org,
        selinux@tycho.nsa.gov, jmorris@namei.org, sds@tycho.nsa.gov,
        eparis@redhat.com
Subject: RE: [PATCH 1/1] secid reconcialiation: Replace unlabeled_t with t
	he network_t
Date: Wed, 4 Oct 2006 10:50:00 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > Considering the above change, I wonder if it would also 
> make sense to
> > update the secmark to SECINITSID_UNLABELED in the abscence of any
> > external labeling (labeled IPsec or NetLabel)?
> > 
> 
> Ungh, my apologies ... I meant to say "SECINITSID_NETMSG" *not*
> "SECINITSID_UNLABELED".

In the xfrm/NetLabel/semark case, you have configured (domain) labels that
are meant to be carried by the skb. Whereas that's not the case with
network_t.
So, just a flow_in check was in order here.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
