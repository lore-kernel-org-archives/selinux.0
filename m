Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kALMR9Me020146
	for <selinux@tycho.nsa.gov>; Tue, 21 Nov 2006 17:27:09 -0500
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kALMPTKb026903
	for <selinux@tycho.nsa.gov>; Tue, 21 Nov 2006 22:25:29 GMT
Message-ID: <45637D38.3020601@trustedcs.com>
Date: Tue, 21 Nov 2006 16:27:04 -0600
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Klaus Weidner <klaus@atsec.com>
CC: selinux@tycho.nsa.gov, Christopher PeBenito <cpebenito@tresys.com>,
        Chad Hanson <chanson@TrustedCS.com>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>
Subject: Re: MLS policy constraints verification
References: <20061111183721.GA629@w-m-p.com>
In-Reply-To: <20061111183721.GA629@w-m-p.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Klaus Weidner wrote:
> Hello,
> 
> in the ongoing LSPP evaluation project, a review of the constraints
> defined in "policy/mls" in the refpolicy turned up some suspicious
> entries.
> 
> Could people who wrote the policy or have opinions on what it's supposed
> to be please comment?
> 
> In the following, I'm generally assuming that l1/h1 correspond to the
> process (subject) and l2/h2 correspond to the object. Apparently the only
> way to be sure is to look in security/selinux/hooks.c and see how it's
> used - probably it would be a good idea to add appropriate comments to
> the policy constraints if that isn't the case.
> 
> % mlsconstrain dir { add_name remove_name reparent rmdir }
> %	((( l1 dom l2 ) and ( l1 domby h2 )) or [OVERRIDE]
> 
> This appears to be a "write" operation on the directory, but the
> constraint looks like a "ranged read" operation. Shouldn't this be "l1
> eq l2" to enforce "write equal" for subjects without overrides?

The constraint is for a "ranged write" operation.  IT states that a process
must be operating at a level that falls within the range of the container in
order to put information into the container.  IF a dir is ranged from s2 - s4,
this would allow processes at s2, s3, or s4 to do these things to the directory.

> % # the socket "write" ops
> % mlsconstrain { socket tcp_socket udp_socket [...] }
> % { write setattr relabelfrom connect setopt shutdown }
> %         ((( l1 dom l2 ) and ( l1 domby h2 )) or [OVERRIDE]
> 
> The socket "write" check looks like a "ranged read". (Note that "socket
> read" checks for "( l1 dom l2 )").

Same "ranged write" as above.

> % # the netif/node "read" ops (implicit single level socket doing the read)
> % #                           (note the check is dominance of the low level)
> % mlsconstrain { node netif } { tcp_recv udp_recv rawip_recv }
> %         (( l1 dom l2 ) or ( t1 == mlsnetrecvall ));
> % 
> % # the netif/node "write" ops (implicit single level socket doing the write)
> % mlsconstrain { netif node } { tcp_send udp_send rawip_send }
> %         (( l1 dom l2 ) and ( l1 domby h2 ));
> 
> The "read" and "write" constraints both use "l1 dom l2" which looks
> wrong.

This seems to be treating netif/nodes as single level objects by only looking
at the low level of the target.  Using the low level of the socket is (or at
least used to be) equivalent to using the low level of the process.  The read
op is a simple read down check as is used everywhere else and the write
operation is a range write operation as described above.

> % mlsconstrain association { recvfrom }
> %         ((( l1 dom l2 ) and ( l1 domby h2 )) or [OVERRIDE]
> % 
> % mlsconstrain association { sendto }
> %         ((( l1 dom l2 ) and ( l1 domby h2 )) or [OVERRIDE]
> 
> (see previous, the send/recv constraints shouldn't be the same?)

Also checking to see if the process, er... socket, falls within the
range of the association.  s4 socket can use an s2-s4 association or
an s3-s6 association, but not an s5-s8 association or an s0-s3 association.

> In general, we had previously talked about how it would be more
> appropriate to check for MLS level equality for "connect" and "accept"
> operations. The sockets are generally bidirectional for reading and
> writing, and the levels would need to dominate each other. It greatly
> simplifies analysis if the security enforcing check happens at the time
> you receive the socket descriptor, and you don't need to depend on
> read/write doing MLS checks.
> 
> Does anyone have an explanation or justification why the constraints are
> the way they currently are? If not, I'll try preparing a patch to make
> them stricter. (Note that it's fine to have overrides that break the
> strict constraints such as level equality for accept/connect, but the
> default for unprivileged users needs to be secure.)

I hope the above at least clears up the intention of a few of the constraints.

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
