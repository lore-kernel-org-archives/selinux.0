Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBF1lSsu016574
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 20:47:28 -0500
Received: from e2.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kBF1m19c002981
	for <selinux@tycho.nsa.gov>; Fri, 15 Dec 2006 01:48:01 GMT
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kBF1m0Vt006690
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 20:48:00 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id kBF1m1tg228472
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 20:48:01 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id kBF1m0LT021953
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 20:48:01 -0500
Date: Thu, 14 Dec 2006 19:34:09 -0600
From: Joy Latten <latten@austin.ibm.com>
Message-Id: <200612150134.kBF1Y9qk002698@faith.austin.ibm.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 0/7] labeled ipsec policy changes
Cc: cpebenito@tresys.com
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The following patchset contains policy for labeled ipsec.
I built this patch against selinux-policy-2.4.6-3.
I plan to run a labeled ipsec stress test soon and will 
include this patch in my stress test.

Regards,
Joy


Patch 1
--------
Adds an interface to kernel/domain.if that allows 
a specified subject to set the security context on 
ipsec policy and associations with types in the
domain attribute. 

Adds an interface to system/ipsec.te that allows
a specified subject to "polmatch" to ipsec_spd_t type

A Sysadm will have to specify who can polmatch
to the policy type. Is this ok? Or should I do
something such that any type in the domain attribute
is allowed to polmatch?

ipsec_spd_t is a new type that is used as a general
catchall or default type for ipsec policy. 
Sysadms can use this type in the security context they
add to ipsec policy.


Patches 2-6
------------
This patchset allows networking programs to 
sendto and recvfrom using ipsec associations. 

I have divided this patch into 4 parts:
admin, apps, services, system. 
Services had many modules, so I divided it into 2.
Thus 5 patches.

Networking programs such as ping, have a socket
and SA with same type, ping_t, so only
require the sendto and recvfrom for itself.
So, I have added sendto and recvfrom for self
to the networking programs. 

I have also added an interface to each networking
module such that a sysadm can specify which subjects
may recvfrom with SAs of the network module's type.

I had some problems trying to figure out how to 
do this with some modules. In particular, those
that have role or client or server templates. For
example, evolution. I cannot readily determine
what $1_evolution_t object will be. So those of these nature, 
I included the string "role" or "client", etc...
in the interface name to indicate that these require
Sysadm  to specify two parameters, one, the
role or client and the other is the subject who will be given the 
permission. I had a hard time pulling this
off with ssh, so any improvements are definitely welcomed.

Hopefully documentation will make this 
less painful for Sysadms and I do plan on including this 
in the docs. As soon as time permits and I know whether 
this is acceptable, I will update my docs and send to the list.

Please let me know if this was correct way to do this
or there is a better way.

Patch 7
-------
This patch defines domains for racoon and setkey
as well as raw rules they require.
It also includes an interface in system/ipsec.if
to execute racoon and setkey in their own domains. 
I call this interface in userdomain.te, such that
sysadm_t runs setkey and racoon in their own domains.

I have not performed an fvt on setkey and racoon
so I do not believe I have determined most of the
permissions they will require. Thus in all honesty
I am cautious of this patch. I have tested it using
a simple config for setkey and racoon. 


Conclusions:
-------------
Based on the policy I have defined above, a Sysadm
when using labeled ipsec, will have to:

1. use the ipsec_label_sa_pol() interface to determine which
subjects can "polmatch" to the general policy type, ipsec_spd_t.
A sysadm wishing to define additional ipsec policy 
types can do so, but will have to write additional
policy to do so. 

2. use xxx_rcv_labeled_ipsec[_xxx] interface for networking
programs that have a client/server model.
For example, ssh and http.

The following is an example policy for a sysadm:

	policy_module(ipsec_test,1.0)

	# ping
	ipsec_label_sa_pol(ping_t)
	# ssh
	ipsec_label_sa_pol(sshd_t)
	ipsec_label_sa_pol(sysadm_ssh_t)

	ssh_recv_labeledipsec_server(sysadm_ssh_t)
	ssh_recv_labeledipsec_role(sysadm,sshd_t)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
