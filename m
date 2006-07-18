Message-ID: <44BD1932.90605@trustedcs.com>
Date: Tue, 18 Jul 2006 12:24:02 -0500
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
MIME-Version: 1.0
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
CC: jmorris@namei.org, sds@tycho.nsa.gov, tjaeger@cse.psu.edu
Subject: [PATCH 00/10] MLSXFRM-v02: Repost patchset with updates
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The following are the changes included in this patch set (relative to 2.6.18-rc1-mm2)
as compared to the previous posting:

- Correct use of BUG_ON (per James' and Stephen's comments)
- security_sid_mls_copy: check context with policydb_context_isvalid (Stephen)
- sk_getsecid: do away with extracting isec (Stephen)
- Do away with extracting isec in rcv_skb and postroute_last hooks (Stephen)
- Drop useless printk invocations (Stephen)
- Better description of the xfrm_decode_session hook in security.h
- Nicer function naming; security_sk_classify_flow, security_skb_classify_flow (David)
  NOTE: Also added a new LSM hook req_classify_flow (reluctantly since I wasn't able to
  just copy the secid from the request_sock to the flow in include/linux/security.h itself
  due to "incomplete datatype" compilation errors related to the inaccessibility of the
  request_sock definition in security.h in a clean way; would welcome suggestions in this regard).

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
