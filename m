Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id rB3GYO4W017776
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2013 11:34:24 -0500
Subject: [PATCH 0/2] Fix TCP SYN-ACK labeling and access controls
To: selinux@tycho.nsa.gov
From: Paul Moore <pmoore@redhat.com>
Cc: Janak.Desai@gtri.gatech.edu
Date: Tue, 03 Dec 2013 11:34:14 -0500
Message-ID: <20131203163012.4743.26970.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Unfortunately we don't correctly handle the labeling or control of TCP
SYN-ACK packets correctly due largely to the nature of how the TCP
handshake is handled with respect to the "mini" request_sock versus
the "full" sock.  These two patches correct these problems by adding
some special handling for sockets that send packets while in the TCP
listening state (the only time they do this is when accepting the
initial SYN/handshake packets).

---

Paul Moore (2):
      selinux: handle TCP SYN-ACK packets correctly in selinux_ip_output()
      selinux: handle TCP SYN-ACK packets correctly in selinux_ip_postroute()


 security/selinux/hooks.c |   93 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 76 insertions(+), 17 deletions(-)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
