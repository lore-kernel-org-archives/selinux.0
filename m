Message-ID: <45217457.6070303@hp.com>
Date: Mon, 02 Oct 2006 16:19:35 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, jmorris@namei.org,
        eparis@redhat.com
Subject: Re: [PATCH v2 1/1] NetLabel: secid reconciliation support
References: <20061002180633.639599000@hp.com>	 <20061002181633.788771000@hp.com> <1159817041.6855.150.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1159817041.6855.150.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Mon, 2006-10-02 at 14:06 -0400, paul.moore@hp.com wrote:
> 
>>plain text document attachment (netlabel-secid_support)
>>This patch provides the missing NetLabel support to the secid reconciliation
>>patchset.
>>
>>Signed-off-by: Paul Moore <paul.moore@hp.com>
>>---
>> security/selinux/hooks.c                    |   67 +++++++++++------
>> security/selinux/include/objsec.h           |    1 
>> security/selinux/include/selinux_netlabel.h |   28 +++----
>> security/selinux/ss/services.c              |  106 ++++++++++------------------
>> 4 files changed, 98 insertions(+), 104 deletions(-)
> 
> 
>>@@ -3725,7 +3723,16 @@ static int selinux_skb_flow_in(struct sk
>>+
>>+	err = avc_has_perm(nlbl_sid, skb->secmark, SECCLASS_PACKET,
>>+					PACKET__FLOW_IN, NULL);
> 
> 
> This means we end up with two flow_in checks each time, even if only one
> or none of the two labeling mechanisms was used, right?  Given the
> conclusion on the discussion of what it means to use them together (just
> redundant), this seems to be pointless overhead.

Okay, how about something like this?

static int selinux_skb_flow_in(struct sk_buff *skb, unsigned short family)
{
	u32 xfrm_sid;
	u32 nlbl_sid;
	u32 ext_sid;
	int err;

	if (selinux_compat_net)
		return 1;

	/*
	 * loopback traffic already labeled and
	 * flow-controlled on outbound. We may
	 * need to flow-control on the inbound
	 * as well if there's ever a use-case for it.
	 */
	if (skb->dev == &loopback_dev)
		return 1;

	err = selinux_xfrm_decode_session(skb, &xfrm_sid, 0);
	BUG_ON(err);

	err = selinux_netlbl_skb_sid(skb,
				     xfrm_sid ? xfrm_sid : skb->secmark,
				     &nlbl_sid);
	if (err)
		goto out;

	if (nlbl_sid)
		ext_sid = nlbl_sid;
	else
		ext_sid = xfrm_sid;

	err = avc_has_perm(ext_sid,
			   skb->secmark,
			   SECCLASS_PACKET,
			   PACKET__FLOW_IN,
			   NULL);
	if (err)
		goto out;

	if (ext_sid)
		skb->secmark = ext_sid;

out:
	return err ? 0 : 1;
};

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
