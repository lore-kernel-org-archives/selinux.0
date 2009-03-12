Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2CGMsJg006075
	for <selinux@tycho.nsa.gov>; Thu, 12 Mar 2009 12:22:54 -0400
Received: from g1t0026.austin.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2CGMrS2011614
	for <selinux@tycho.nsa.gov>; Thu, 12 Mar 2009 16:22:53 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v1 0/3] Fix a problem with incoming TCP connections and
	NetLabel
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        netdev@vger.kernel.org
Date: Thu, 12 Mar 2009 12:22:50 -0400
Message-ID: <20090312160934.29454.31004.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The patches below have more information on the problem but the issue is that
we are not correctly labeling incoming TCP connection sockets at present.  Due
to a variety of things all coming together we've gotten a bit lucky in that
the majority of labeled TCP connections are labeled correctly now but this
won't hold for long as some of the new features added recently will break this
"happy coincidence" for some configurations.

For the folks on netdev, you probably only care about the relocation of the
security_inet_conn_request() hooks but this is such a minor move I doubt there
will be much objection.  Still, I would appreciate any feedback/comments.

For the folks on the SELinux and LSM lists please take a look and let me know
if the basic approach seems reasonable.  Keep in mind I still need to make a
few more passes through the code to clean it up and make sure I haven't done
anything stupid.  I've done basic testing under both SELinux and Smack using
2.6.29-rc7 and everything looks okay so far so feel free to play with it but
more testing is still needed.

---

Paul Moore (3):
      netlabel: Label incoming TCP connections correctly in Smack
      netlabel: Label incoming TCP connections correctly in SELinux
      lsm: Relocate the IPv4 security_inet_conn_request() hooks


 include/net/cipso_ipv4.h            |   17 +++
 include/net/netlabel.h              |   17 +++
 net/ipv4/cipso_ipv4.c               |  130 ++++++++++++++++++++++--
 net/ipv4/syncookies.c               |    9 +-
 net/ipv4/tcp_ipv4.c                 |    7 +
 net/netlabel/netlabel_kapi.c        |  124 +++++++++++++++++++++--
 security/selinux/hooks.c            |   54 +++-------
 security/selinux/include/netlabel.h |   26 ++---
 security/selinux/netlabel.c         |  187 ++++++++++-------------------------
 security/smack/smack_lsm.c          |   53 +++++++---
 10 files changed, 393 insertions(+), 231 deletions(-)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
