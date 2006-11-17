Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAI1MTar017788
	for <selinux@tycho.nsa.gov>; Fri, 17 Nov 2006 20:22:29 -0500
Received: from e6.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAI1KpUg024103
	for <selinux@tycho.nsa.gov>; Sat, 18 Nov 2006 01:20:51 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAI1N4Gs014693
	for <selinux@tycho.nsa.gov>; Fri, 17 Nov 2006 20:23:04 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id kAI1MhaF276400
	for <selinux@tycho.nsa.gov>; Fri, 17 Nov 2006 20:22:43 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id kAI1Mhhw032153
	for <selinux@tycho.nsa.gov>; Fri, 17 Nov 2006 20:22:43 -0500
Subject: labeled ipsec policy
From: Joy Latten <latten@austin.ibm.com>
To: redhat-lspp@redhat.com, selinux@tycho.nsa.gov
Cc: jbrindle@tresys.com, cpebenito@tresys.com
Content-Type: text/plain
Date: Fri, 17 Nov 2006 16:30:22 -0600
Message-Id: <1163802623.17737.398.camel@faith.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The following policy enables labeled ipsec to run
in enforcing mode. I configure labeled ipsec in sysadm_r role. 
Thus the rules I needed were specific to this role.

This is just what I needed to get it to work and use labels,
please feel free to modify this and make corrections.
I was not sure if anyone had started this work.
I am not sure where this should even reside in refpolicy modules.
I apologize if this email gets long, but I wanted to make sure
I  tried to explain everything.

Included are some interfaces, which I used in an xxxx.if
file. Then, there are a bunch of rules which I used in a xxxx.te file
These rules were just an example of what I needed
to get ping, nc, and ssh to work with labeled ipsec. For my
policy, I used the types unlabeled_t, passwd_t, and ipsec_spd_t.
When using passwd_t, ipsec_spd_t or any other domain, please be 
mindful of mls constraints. 

I am still "playing" with labeled ipsec, so I don't think this policy
is absolute and totally correct. :-)

The interfaces:
ipsec_set_label() 
	-setkey needs to be able to add an ipsec policy containing a
	security context to the SPD.
	-racoon/setkey need to be able to add SAs containing security
	context to the SAD.
	-A sysadm would use this interface to enter the domain of the
	security context used in an ipsec policy entry.
	-A sysadm would also use this interface to enter the domain of
	the security context the SA will have.
	**NOTE: SAs pose a problem because there is the assumption you
              know the domain of the socket that will be created by an
	      application. i.e, a ping proccess opens a socket with 
	      ping_t, thus SA's security context is also ping_t.
	      sysadm would need to enter "ping_t" into this interface
	      so the SA could be added to the SAD. 

ipsec_label_sa_pol()
	-Enter the domain of the SA and the domain of the ipsec policy.
	The SA will be considered "within the range" of the ipsec policy.
	i.e. the domain of your ipsec policy is ipsec_spd_t, 
        you want ping_t SAs to be within range of ipsec_spd_t policy.
	racoon requires this in order to determine if
	a proposed SA "polmatches" to the SPD entry for the 
	traffic stream.
 	
ipsec_labels_send_recv()
	-Allow a socket to send and receive with an IPSec SA. 
	 It is assumed that the type of the IPSec SA is the
	 same as the domain of the socket which created and used
	 it.
	** NOTE: perhaps another interface is needed to allow 
	a socket to use an SA of a different type than the socket.
	i.e. allow sshd_t sysadm_ssh_t:association recvfrom;


ipsec_tools_utilites()
	-Enter the type of the process that can use setkey and racoon.
	-Actually, I kinda just grouped together all the rules that
	I needed to run racoon and setkey while in sysadm_r role.
	- I could not help but wonder if setkey and racoon should 
	  be run in sysadm_r role and transition into ipsec_t domain 
	  (see system/ipsec.te and system/ipsec.if) or left alone to 
	  run in sysadm domain. All the rules in this interface
	  are when racoon and ipsec run in sysadm_t domain.
	NOTE: ideally it seems to me these rules should 
	      be in a *.te file.
	

-----------------------------------------------------------------------------
xxxx.if 

## <summary>Labeled IPSec</summary>

########################################
## <summary>
##     	Allow setkey/racoon to add policy to the SPD or
##	Security Associations to the SAD with the specified
##	specified domain.
## </summary>
## <param name="domain">
##      <summary>
##	Domain specified in security context of IPSec policy entry
##	or IPSec SA.
##      </summary>
## </param>
#
interface(`ipsec_set_label',`
	gen_require(`
		type sysadm_t;
	')
	
	allow sysadm_t $1:association setcontext; 
')

########################################
## <summary>
##      Allow an IPSec SA to be within the range of an IPSec Policy.
## </summary>
## <param name="domain">
##      <summary>
##      1. The type of the IPSec SA 
##	2. The type of the IPSec Policy
##      </summary>
## </param>
#
interface(`ipsec_label_sa_pol',`
	
	allow $1 $2:association polmatch;
')

########################################
## <summary>
##      Allow a socket to send and receive with an IPSec SA.
##	Note: It is assumed that the type of the IPSec SA is same
##	      as the type of the socket that created it.
## </summary>
## <param name="domain">
##      <summary>
##      1. The type of the socket and the IPSec SA 
##      </summary>
## </param>
#

interface(`ipsec_labels_send_recv',`
		
	allow $1 self:association { recvfrom sendto };

')


########################################
## <summary>
##      Run ipsec utilities, setkey and racoon.
## </summary>
## <param name="domain">
##      <summary>
##      The type of the proces performing this action. 
##      </summary>
## </param>
#
interface(`ipsec_tools_utilities',`
	gen_require(`
		type isakmp_port_t;
		type inaddr_any_node_t;
	')

	# allow setkey and racoon to create and use a key socket.
	allow $1 self:key_socket { create read write setopt };

	# allow racoon to use ISAKMP port
	allow $1 isakmp_port_t:udp_socket name_bind;

	# allow racoon to use avc_has_perm in within_range() 
	# to determine if proposed SA "polmatches" to policy
	allow $1 self:netlink_selinux_socket { bind create read };

	# I think this is so racoon can listen on an admin port.
	allow $1 inaddr_any_node_t:tcp_socket node_bind;

	# to create, remove read lock in /var/racoon/
	ipsec_manage_pid($1)

	# in grabmyaddrs() socket(PF_ROUTE...)
	allow $1 self:netlink_route_socket { create_netlink_socket_perms };
')

-------------------------------------------------------------------------
xxxx.te

policy_module(ipsec_joy,1.0)

gen_require(`
	type sysadm_t;
	type passwd_t;
	type ping_t;
	type unlabeled_t;
	type sysadm_ssh_t;
	type sshd_t;
')

type ipsec_spd_t;

ipsec_tools_utilities(sysadm_t)

# use following domains in spd
ipsec_set_label(unlabeled_t)
ipsec_set_label(passwd_t)
ipsec_set_label(ipsec_spd_t)

# use following domains in SAs
ipsec_set_label(ping_t)
ipsec_set_label(sysadm_t) #for NC

# allow specified SA to be considered within range of specified policy
ipsec_label_sa_pol(ping_t, passwd_t) 
ipsec_label_sa_pol(sysadm_t, passwd_t)

ipsec_label_sa_pol(ping_t, unlabeled_t)
ipsec_label_sa_pol(sysadm_t, unlabeled_t)


ipsec_label_sa_pol(ping_t, ipsec_spd_t)
ipsec_label_sa_pol(sysadm_t, ipsec_spd_t)

# allow SAs to be used for sending and receiving
ipsec_labels_send_recv(ping_t)
ipsec_labels_send_recv(sysadm_t)

# for ssh
ipsec_set_label(sysadm_ssh_t) 
ipsec_set_label(sshd_t) 
ipsec_label_sa_pol(sysadm_ssh_t, unlabeled_t)
ipsec_label_sa_pol(sshd_t, unlabeled_t)
ipsec_labels_send_recv(sshd_t)
ipsec_labels_send_recv(sysadm_ssh_t)
allow sysadm_ssh_t sshd_t:association recvfrom; 
allow sshd_t sysadm_ssh_t:association recvfrom;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
