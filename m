Message-ID: <44EDE6EA.1090601@trustedcs.com>
Date: Thu, 24 Aug 2006 12:50:34 -0500
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
MIME-Version: 1.0
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
CC: jmorris@namei.org, sds@tycho.nsa.gov, chanson@TrustedCS.com
Subject: [PATCH 0/3] secid reconciliation-v01: Repost patchset with updates
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The following are the changes included in this patchset since the previous post:

- Use SELinux transition rules instead of precedence when reconciling the secid's
  making it flexible/policy-driven; xfrm secid would prevail by default.
- Change the naming of access vector perms to flow_in and flow_out.
- Make selinux_xfrm_sock_rcv_skb checks conditional on compat_net.
- Switch selinux_inet_conn_request to use secmark; cipso is still allowed to
  override secmark currently in this regard (will rely on Paul Moore at HP
  to bring cipso into the reconciliation path).

This patchset is relative to David Miller's net-2.6.19.git.

Please consider for inclusion in 2.6.19.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
