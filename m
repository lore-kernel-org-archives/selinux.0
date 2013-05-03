Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r43JC0aP025823
	for <selinux@tycho.nsa.gov>; Fri, 3 May 2013 15:12:03 -0400
Message-ID: <51840BF4.7000302@tresys.com>
Date: Fri, 3 May 2013 15:11:48 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Paul Moore <pmoore@redhat.com>
CC: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Clarification of labeled IPsec checks
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm doing some spring cleaning on refpolicy, cleaning out some old unused/unnecessary networking permissions.  I'm trying to make sure I have the permissions checks straight, since labeled networking isn't common use.  For labeled IPsec, we have the following permissions (assuming all policy capabilities are on--assume maximum checks):

netif: ingress/egress
node: sendto/recvfrom
peer: recv
association: sendto/recvfrom

I'm told that association perms are checked in the following cases:

sendto: when a packet leaves the box (legacy only) and when a SA/flow is checked
recvfrom: when an incoming packet is queued on a socket (legacy only)

Does "legacy only" mean the checks will eventually go away, or is it for a legacy IPsec configuration?

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
