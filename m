From: Paul Moore <paul.moore@hp.com>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Tue, 28 Aug 2007 15:47:24 -0400
Cc: Darrel Goeddel <sedgoeddel@gmail.com>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, kaigai@ak.jp.nec.com,
        joe@nall.com, Eric Paris <eparis@parisplace.org>
References: <D709A20F2164C84E8B7014B0301F5EF852144C@HAVOC.tcs-sec.com>
In-Reply-To: <D709A20F2164C84E8B7014B0301F5EF852144C@HAVOC.tcs-sec.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708281547.24371.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday, August 28 2007 2:02:02 pm Venkat Yekkirala wrote:
> > I am assuming that the *_socket checks used by netlabel would be
> > checking against the new peer label that is in (at least
> > near) the skb,
> > is that right?  If so, the *_socket checks also take care of the peer
> > label coming from loopback.  This would be a bit of a policy change
>
> I doubt it since NetLabel currently already uses the xfrm label,
> if available, as the base sid.

I think that will change to the following (I'm currently working on patches 
for this), pseudo code below:

int get_peer_sid(skb, *sid)
{
	xfrm_sid = get_xfrm_sid(skb);
	nlbl_sid = get_nlbl_sid(skb);

	if (nlbl_sid != SECSID_NULL && xfrm_sid != SECSID_NULL) {
		if (type_nlbl_sid(skb) == FALLBACK) {
			*sid = xfrm_sid;
			return 0;
		} else if (compare_sid_mls(nlbl_sid, xfrm_sid) == 0) {
			*sid = xfrm_sid;
			return 0;
		} else
			return -1;
	} else if (nlbl_sid != SECSID_NULL) {
		*sid = nlbl_sid;
		return 0;
	} else if (xfrm_sid != SECSID_NULL) {
		*sid = xfrm_sid;
		return 0;
	}

	*sid = SECSID_NULL;
	return 0;
}

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
