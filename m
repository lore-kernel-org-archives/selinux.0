Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5G2mOrT029947
	for <selinux@tycho.nsa.gov>; Tue, 15 Jun 2004 22:48:24 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5G2mBs3007639
	for <selinux@tycho.nsa.gov>; Wed, 16 Jun 2004 02:48:21 GMT
Date: Tue, 15 Jun 2004 22:48:09 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Andrew Morton <akpm@osdl.org>
cc: "David S. Miller" <davem@redhat.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
   Chris Wright <chrisw@osdl.org>, <linux-kernel@vger.kernel.org>,
   <selinux@tycho.nsa.gov>
Subject: [SELINUX][PATCH 0/4] Fine-grained Netlink support
Message-ID: <Xine.LNX.4.44.0406152216030.30562-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The following patch set implements fine-grained Netlink support for
SELinux.  It adds a set of extended Netlink socket classes, inherhited
from the socket class.  This allows socket controls to be applied on a per
Netlink family basis.

Additionally, two new permissions have been added:

nlmsg_read
nlmsg_write

These permissions control whether a domain can send messages which cause
kernel data to be read or written respectively (e.g. route table updates
vs. listings). They are only applied to extended Netlink socket classes
which carry user-generated messages.

This is important for locking down applications which need to do things
like read network configuration data, but not write any (e.g. Apache).  
(Currently, this is not possible, as SELinux cannot distinguish bewteen
different types of Netlink messages, or even different types of Netlink 
sockets).

Here are some example AVC messages with the patches applied:

Routing table listing:

avc:  granted  { nlmsg_read } for  pid=2760 exe=/sbin/ip
scontext=root:staff_r:staff_t tcontext=root:staff_r:staff_t
tclass=netlink_route_socket

Routing table update:

avc:  granted  { nlmsg_write } for  pid=2763 exe=/sbin/ip 
scontext=root:staff_r:staff_t tcontext=root:staff_r:staff_t 
tclass=netlink_route_socket

Reading socket status via 'ss':

avc: denied  { nlmsg_read } for  pid=1798 exe=/usr/sbin/ss 
scontext=root:staff_r:staff_t tcontext=root:staff_r:staff_t 
tclass=netlink_tcpdiag_socket

Note the new Netlink message permissions and extended Netlink socket
classes.

Patches for userspace components are available at:
http://people.redhat.com/jmorris/selinux/netlink/


- James
-- 
James Morris
<jmorris@redhat.com>





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
