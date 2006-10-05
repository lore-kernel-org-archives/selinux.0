Message-ID: <45256E25.6020201@trustedcs.com>
Date: Thu, 05 Oct 2006 15:42:13 -0500
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
MIME-Version: 1.0
To: netdev@vger.kernel.org
CC: selinux@tycho.nsa.gov, jmorris@namei.org, sds@tycho.nsa.gov,
        eparis@redhat.com, johnpol@2ka.mipt.ru, herbert@gondor.apana.org.au
Subject: [PATCH 0/3] Fix for IPsec leakage with SELinux enabled - V.03
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This version takes into account David Miller's comments
regarding treatment of security layer errors in the case
of socket policies. Specifically, these errors will be
treated like how these kind of errors are treated for
the main/sub policies, which is to return a full lookup
failure.

 include/linux/security.h        |   24 ++-----
 include/net/flow.h              |    2 
 include/net/xfrm.h              |    3 
 net/core/flow.c                 |   42 ++++++++----
 net/ipv4/xfrm4_policy.c         |    2 
 net/ipv6/xfrm6_policy.c         |    2 
 net/key/af_key.c                |    5 -
 net/xfrm/xfrm_policy.c          |  101 ++++++++++++++++++++++--------
 net/xfrm/xfrm_user.c            |    9 --
 security/dummy.c                |    3 
 security/selinux/include/xfrm.h |    3 
 security/selinux/xfrm.c         |   53 ++++++++++++---
 12 files changed, 162 insertions(+), 87 deletions(-)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
