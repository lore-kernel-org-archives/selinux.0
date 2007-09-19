Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkatesh Yekkirala" <vyekkirala@TrustedCS.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>, <paul.moore@hp.com>, <jmorris@namei.org>,
        "'Karl MacMillan'" <kmacmillan@mentalrootkit.com>,
        "'Joshua Brindle'" <method@manicmethod.com>
Subject: RE: [RFC] [PATCH 4/4] SELinux changes
Date: Wed, 19 Sep 2007 16:20:05 -0500
Message-ID: <009401c7fb02$dab3a0a0$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0095_01C7FAD8.F1E009A0"
In-Reply-To: <1190211506.25863.56.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0095_01C7FAD8.F1E009A0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Wednesday, September 19, 2007 9:18 AM
> To: Venkat Yekkirala
> Cc: selinux@tycho.nsa.gov; paul.moore@hp.com; 
> jmorris@namei.org; Karl MacMillan; Joshua Brindle
> Subject: Re: [RFC] [PATCH 4/4] SELinux changes
> 
> 
> On Tue, 2007-09-18 at 12:32 -0500, Venkat Yekkirala wrote: 
> > This implements the skb_flow_out LSM hook for SELinux. This 
> > also defines a new forward_first netfilter hook to perform 
> > flow-control of forwarded traffic on the way into the system. 
> > Locally destined traffic is flow-controlled inside the existing 
> > rcv_skb LSM hook. 
> > 
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c 
> > index 3694662..5434d7f 100644 
> > --- a/security/selinux/hooks.c 
> > +++ b/security/selinux/hooks.c 
> > @@ -3519,6 +3519,124 @@ static int 
> selinux_socket_unix_may_send(struct socket *sock, 
> >       return 0; 
> >  } 
> >  
> > +static int selinux_skb_flow_in(struct sk_buff *skb, struct 
> net_device *in, 
> > +                            unsigned short family) 
> > +{ 
> > +     u32 node_sid, if_sid, secid = SECSID_NULL; 
> > +     int err; 
> > +     struct avc_audit_data ad; 
> > +     char *addrp; 
> > +     int len; 
> > + 
> > +     if (!in) { 
> > +             if (skb->dev && skb->dev->ifindex == skb->iif) 
> > +                     in = skb->dev; 
> > +             else 
> > +                     in = __dev_get_by_index(skb->iif); 
> > + 
> > +             if (!in) { 
> > +                     err = -EACCES; 
> > +                     goto out; 
> > +             } 
> > +     } 
> > + 
> > +     AVC_AUDIT_DATA_INIT(&ad, NET); 
> > +     ad.u.net.netif = in->name; 
> > +     ad.u.net.family = family; 
> > +     err = selinux_parse_skb(skb, &ad, &addrp, &len, 1, NULL); 
> > +     if (err) 
> > +             goto out; 
> > + 
> > +     if (in != &loopback_dev) { /* Non-localhost packet */ 
> > +             err = selinux_xfrm_decode_session(skb, &secid, 0); 
> > +             BUG_ON(err); 
> > +             /* TODO: Retrieve and check any NetLabel for 
> agreement with 
> > +                any Xfrm; also retrieve fallback if necessary */ 
> > +     } 
> > +#ifdef TODO 
> > +     else /* localhost packet */ 
> > +             /* TODO: Retrieve special IP Option set for 
> localhost traffic */ 
> > +#endif 
> > + 
> > +     err = security_node_sid(family, addrp, len, &node_sid); 
> > +     if (err) 
> > +             goto out; 
> > + 
> > +     err = avc_has_perm(secid, node_sid, 
> > +                               SECCLASS_NODE, 
> > +                               NODE__FLOW_IN, &ad); 
> > +     if (err) 
> > +             goto out; 
> Side note:  If we are going to keep using node SIDs in new network 
> controls (vs. just the compat ones), then we will need to a) 
> introduce 
> some kind of node SID cache to avoid the overhead of policy lookup on 
> each packet, and b) extend semanage to manage node contexts.  
> There was 
> work on both in the past but nothing ever made it to completion (see 
> prior postings by Joy Latten and Rodrigo Vivi). 

Paul once wondered if it made sense to replace the individual netif
and node flow lookup/checks with a single interface/network based
label lookup and check. I initially felt it made sense but I was
discussing this with Chad and Darrel this afternoon
and the thinking on this end is that it would be best to leave the
boundary-defining labels in the policy itself. So unless we want to
invent a way to define and lookup the interface/network labels in policy,
we could continue with the individual checks. In which case, we will
certainly need to work on the 2 issues you mention above.

Also, another idea that has come up here is to make the default message
sid on netif's useable again and make them fallbacks to the NetLabel
fallbacks. So the resolution, in order of priority would be:

1. NetLabel(external/cipso)/Xfrm
2. NetLabel Fallback
3. netif default context
4. Unlabeled

> We thought we were eliminating the need for these per-packet 
> per-node/netif checks by way of secmark, but I guess not if we are 
> keeping secmark separate from labeled networking. 

At least that's my current understanding of what we were going to do
(keeping secmark separate).

------=_NextPart_000_0095_01C7FAD8.F1E009A0
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="winmail.dat"

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
YO1B8pMO8v/wclsgODM78Slh/aG5UjFA712UyYFCApczJzrg4WDsIP5iAzG0QCABsgMnBj8wuGb/
JrM4QrL2XZQrlxRzOEK0YP07wGw5IKvRbSHtgDnw/QGv7FP4glXhD5c6+3oxOpA/svbcIO9xDHA1
8AIAaXB5O8ApL7ciXZRQ4LLoRvu4dV2UMzqQlzQnlvFVXZR6NDqQVRTQszIEtl2WV/NHgs8gZ2i0
wUJh8qKcYf+aAJfwSCNDEubzs4JDEb2x/T7RLb619/c8sWyiA/KIwf8CFflhQoJAwVWR9kDjIF1w
/QikZyHx8wDfcYiy4BVdlv/hEkgyP9WcQZzRD0C4QUbA3ytwODXixkgx+1xBdjL08vsPIimhbbmg
VbG0YFnBEcH/DGBZQcYxDgLf8Q8yOjbgh3pkFcUoQo9DlftAXZR9AU0gAAAAHgBCEAEAAAA5AAAA
PDExOTAyMTE1MDYuMjU4NjMuNTYuY2FtZWxAbW9zcy1zcGFydGFucy5lcG9jaC5uY3NjLm1pbD4A
AAAAAwAJWQEAAAALAACACCAGAAAAAADAAAAAAAAARgAAAAADhQAAAAAAAAMAAoAIIAYAAAAAAMAA
AAAAAABGAAAAABCFAAAAAAAAAwAIgAggBgAAAAAAwAAAAAAAAEYAAAAAAYUAAAAAAAADABeACCAG
AAAAAADAAAAAAAAARgAAAABShQAAfW4BAB4AGIAIIAYAAAAAAMAAAAAAAABGAAAAAFSFAAABAAAA
BAAAADkuMAALABmACCAGAAAAAADAAAAAAAAARgAAAAAGhQAAAAAAAAsAGoAIIAYAAAAAAMAAAAAA
AABGAAAAAA6FAAAAAAAAAwAbgAggBgAAAAAAwAAAAAAAAEYAAAAAEYUAAAAAAAADAByACCAGAAAA
AADAAAAAAAAARgAAAAAYhQAAAAAAAB4APYAIIAYAAAAAAMAAAAAAAABGAAAAAIOFAAABAAAAEwAA
ADEwODIzMTkyMS0xOTA5MjAwNwAAAgH4DwEAAAAQAAAALpz+zE5GwE6G8lZKjqwwqAIB+g8BAAAA
EAAAAC6c/sxORsBOhvJWSo6sMKgCAfsPAQAAAJsAAAAAAAAAOKG7EAXlEBqhuwgAKypWwgAAbXNw
c3QuZGxsAAAAAABOSVRB+b+4AQCqADfZbgAAAEM6XERvY3VtZW50cyBhbmQgU2V0dGluZ3Ncdnll
a2tpcmFsYVxMb2NhbCBTZXR0aW5nc1xBcHBsaWNhdGlvbiBEYXRhXE1pY3Jvc29mdFxPdXRsb29r
XHZ5ZWtraXJhbGEucHN0AAADAP4PBQAAAAMADTT9NwAAAgF/AAEAAAAxAAAAMDAwMDAwMDAyRTlD
RkVDQzRFNDZDMDRFODZGMjU2NEE4RUFDMzBBOEM0M0QxRjAyAAAAAAMABhD0HFGsAwAHECgLAAAD
ABAQAQAAAAMAERABAAAAHgAIEAEAAABlAAAALS0tLS1PUklHSU5BTE1FU1NBR0UtLS0tLUZST006
U1RFUEhFTlNNQUxMRVlNQUlMVE86U0RTQFRZQ0hPTlNBR09WU0VOVDpXRURORVNEQVksU0VQVEVN
QkVSMTksMjAwNzk6MQAAAACcCg==

------=_NextPart_000_0095_01C7FAD8.F1E009A0--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
