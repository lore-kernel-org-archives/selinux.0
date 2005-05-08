From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: rdisc policy
Date: Mon, 9 May 2005 01:31:16 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_HDjfChqZ76c/r8z"
Message-Id: <200505090131.19423.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_HDjfChqZ76c/r8z
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Attached is the policy for rdisc, the router discovery daemon.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_HDjfChqZ76c/r8z
Content-Type: text/plain;
  charset="us-ascii";
  name="rdisc.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="rdisc.fc"

/sbin/rdisc		system_u:object_r:rdisc_exec_t

--Boundary-00=_HDjfChqZ76c/r8z
Content-Type: text/plain;
  charset="us-ascii";
  name="rdisc.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="rdisc.te"

#DESC rdisc - network router discovery daemon
#
# Author:  Russell Coker <russell@coker.com.au>

daemon_base_domain(rdisc)
allow rdisc_t self:unix_stream_socket create_stream_socket_perms;
allow rdisc_t self:rawip_socket create_socket_perms;
allow rdisc_t self:udp_socket create_socket_perms;
allow rdisc_t self:capability net_raw;

can_network_udp(rdisc_t)

allow rdisc_t etc_t:file { getattr read };

--Boundary-00=_HDjfChqZ76c/r8z--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
