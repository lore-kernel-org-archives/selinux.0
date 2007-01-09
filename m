Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l090PEqj013486
	for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2007 19:25:14 -0500
Received: from e32.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l090Q2bm013315
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 00:26:02 GMT
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e32.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id l090Otrs032302
	for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2007 19:24:55 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id l090Q0pA455236
	for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2007 17:26:00 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l090PxOP009981
	for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2007 17:26:00 -0700
Date: Mon, 8 Jan 2007 18:11:30 -0600
From: Joy Latten <latten@austin.ibm.com>
Message-Id: <200701090011.l090BUx8017494@faith.austin.ibm.com>
To: redhat-lspp@redhat.com
Subject: [PATCH 0/3]: labeled ipsec policy
Cc: cpebenito@tresys.com, selinux@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The labeled IPSec policy patchset consists
of 3 patches. 

Patch1:
Adds the attribute, netapp_type and the interface
corenet_type() which adds types to this attribute.
Networking types then call this interface.

Also adds default ipsec policy type, ipsec_spd_t.
Adds the interface ipsec_labeled() that allows
a domain to polmatch to ipsec_spd_t as well as
sendto and recvfrom itself. So, ipsec_labeled(netapp_type) 
is called in corenework.if.in, to enable networking apps,
such as ping to work with no policy being required of sysadm.
(This is because the socket and the SA have same type,
thus need to only have permissions to receive from "self".)

Patch2:
Adds interface to some networking modules to allow recvfrom
permission. I only added this interface to networking types that
appeared to be daemons or client/server model, where I could not readily
determine who would need access permissions.
For example, 
interface(`evolution_recv_labeledipsec_server_role',`
       gen_require(`
               type $1_evolution_server_t;
       ')
       allow $2 $1_evolution_server_t:association recvfrom;
')

A sysadm would have to write policy using these interfaces
to determine what "localdomain" may recvfrom "$1_evolution_server_t".

To minimize or avoid this, I thought it might be good to have a default.
I would like to add to each module with an interface
like this, a rule like the following,

evolution_recv_labeledipsec_server_role(netapp_type)
OR
evolution_recv_labeledipsec_server_role(domain)

Thus allowing all domains or all networking domains to 
be able to recvfrom this particular server domain.

Let me know if this sounds ok, and I will make the changes.

Patch3:
Modifies ipsec.* files such that setkey and racoon run
in their own domains. 
Adds ability for sysadm role to run setkey and execute
via ipsec_tools_run() in userdomain.te

I have tested setkey and racoon using basic config.
Not sure if I have all the rules required as I have not
tested all code paths for racoon and setkey.

Regards,
Joy Latten

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
