Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kABIbRlp026102
	for <selinux@tycho.nsa.gov>; Sat, 11 Nov 2006 13:37:27 -0500
Received: from mail.atsec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kABIahII006505
	for <selinux@tycho.nsa.gov>; Sat, 11 Nov 2006 18:36:44 GMT
Date: Sat, 11 Nov 2006 12:37:21 -0600
From: Klaus Weidner <klaus@atsec.com>
To: selinux@tycho.nsa.gov
Subject: MLS policy constraints verification
Message-ID: <20061111183721.GA629@w-m-p.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

in the ongoing LSPP evaluation project, a review of the constraints
defined in "policy/mls" in the refpolicy turned up some suspicious
entries.

Could people who wrote the policy or have opinions on what it's supposed
to be please comment?

In the following, I'm generally assuming that l1/h1 correspond to the
process (subject) and l2/h2 correspond to the object. Apparently the only
way to be sure is to look in security/selinux/hooks.c and see how it's
used - probably it would be a good idea to add appropriate comments to
the policy constraints if that isn't the case.

% mlsconstrain dir { add_name remove_name reparent rmdir }
%	((( l1 dom l2 ) and ( l1 domby h2 )) or [OVERRIDE]

This appears to be a "write" operation on the directory, but the
constraint looks like a "ranged read" operation. Shouldn't this be "l1
eq l2" to enforce "write equal" for subjects without overrides?

% # the socket "write" ops
% mlsconstrain { socket tcp_socket udp_socket [...] }
% { write setattr relabelfrom connect setopt shutdown }
%         ((( l1 dom l2 ) and ( l1 domby h2 )) or [OVERRIDE]

The socket "write" check looks like a "ranged read". (Note that "socket
read" checks for "( l1 dom l2 )").

% # the netif/node "read" ops (implicit single level socket doing the read)
% #                           (note the check is dominance of the low level)
% mlsconstrain { node netif } { tcp_recv udp_recv rawip_recv }
%         (( l1 dom l2 ) or ( t1 == mlsnetrecvall ));
% 
% # the netif/node "write" ops (implicit single level socket doing the write)
% mlsconstrain { netif node } { tcp_send udp_send rawip_send }
%         (( l1 dom l2 ) and ( l1 domby h2 ));

The "read" and "write" constraints both use "l1 dom l2" which looks
wrong.

% mlsconstrain association { recvfrom }
%         ((( l1 dom l2 ) and ( l1 domby h2 )) or [OVERRIDE]
% 
% mlsconstrain association { sendto }
%         ((( l1 dom l2 ) and ( l1 domby h2 )) or [OVERRIDE]

(see previous, the send/recv constraints shouldn't be the same?)

In general, we had previously talked about how it would be more
appropriate to check for MLS level equality for "connect" and "accept"
operations. The sockets are generally bidirectional for reading and
writing, and the levels would need to dominate each other. It greatly
simplifies analysis if the security enforcing check happens at the time
you receive the socket descriptor, and you don't need to depend on
read/write doing MLS checks.

Does anyone have an explanation or justification why the constraints are
the way they currently are? If not, I'll try preparing a patch to make
them stricter. (Note that it's fine to have overrides that break the
strict constraints such as level equality for accept/connect, but the
default for unprivileged users needs to be secure.)

-Klaus

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
