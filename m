Subject: Re: [PATCH v2] selinux: support distinctions among all network
 address families
To: Paul Moore <paul@paul-moore.com>
References: <1481036419-30057-1-git-send-email-sds@tycho.nsa.gov>
 <CAHC9VhQgD_oYn2zCzJCvUzzD_zJYKiQVbG_YMfoPpjphJzTOHA@mail.gmail.com>
 <4d02c906-b208-ffe8-8a56-46734d764c34@tycho.nsa.gov>
 <CAHC9VhT6E9vLebvBcTX7XtPkP6eGNM-7rxkKAydsDrUwO2Sj5Q@mail.gmail.com>
 <f0075276-99eb-5aba-c009-7c760581be14@tycho.nsa.gov>
 <CAHC9VhSEe_aXLob3oWtWDnijM5Ag8wNNA3_WLoU=7surmSXU7A@mail.gmail.com>
Cc: selinux@tycho.nsa.gov, guido@trentalancia.net,
 richard_c_haines@btinternet.com, "Christopher J. PeBenito"
 <pebenito@ieee.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <b3bad269-c1b7-4b47-3709-039f060c9221@tycho.nsa.gov>
Date: Thu, 8 Dec 2016 11:24:28 -0500
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSEe_aXLob3oWtWDnijM5Ag8wNNA3_WLoU=7surmSXU7A@mail.gmail.com>
Content-Type: multipart/mixed; boundary="------------558A31E8B95B58D4A5C2D717"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------558A31E8B95B58D4A5C2D717
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 12/07/2016 06:32 PM, Paul Moore wrote:
> On Wed, Dec 7, 2016 at 10:24 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 12/07/2016 10:14 AM, Paul Moore wrote:
>>> On Wed, Dec 7, 2016 at 8:25 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>> On 12/06/2016 07:13 PM, Paul Moore wrote:
>>>>> On Tue, Dec 6, 2016 at 10:00 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>>>> Extend SELinux to support distinctions among all network address families
>>>>>> implemented by the kernel by defining new socket security classes
>>>>>> and mapping to them. Otherwise, many sockets are mapped to the generic
>>>>>> socket class and are indistinguishable in policy.  This has come up
>>>>>> previously with regard to selectively allowing access to bluetooth sockets,
>>>>>> and more recently with regard to selectively allowing access to AF_ALG
>>>>>> sockets.  Guido Trentalancia submitted a patch that took a similar approach
>>>>>> to add only support for distinguishing AF_ALG sockets, but this generalizes
>>>>>> his approach to handle all address families implemented by the kernel.
>>>>>> Socket security classes are also added for ICMP and SCTP sockets.
>>>>>> Socket security classes were not defined for AF_* values that are reserved
>>>>>> but unimplemented in the kernel, e.g. AF_NETBEUI, AF_SECURITY, AF_ASH,
>>>>>> AF_ECONET, AF_SNA, AF_WANPIPE.
>>>>>>
>>>>>> Backward compatibility is provided by only enabling the finer-grained
>>>>>> socket classes if a new policy capability is set in the policy; older
>>>>>> policies will behave as before.  The legacy redhat1 policy capability
>>>>>> that was only ever used in testing within Fedora for ptrace_child
>>>>>> is reclaimed for this purpose; as far as I can tell, this policy
>>>>>> capability is not enabled in any supported distro policy.
>>>>>>
>>>>>> Add a pair of conditional compilation guards to detect when new AF_* values
>>>>>> are added so that we can update SELinux accordingly rather than having to
>>>>>> belatedly update it long after new address families are introduced.
>>>>>>
>>>>>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>>>>>> ---
>>>>>> v2 reworks the style based on comments from Guido Trentalancia and adds
>>>>>> security classes for SCTP and ICMP sockets.  The security class support
>>>>>> for SCTP sockets was based on Richard Haines' SCTP patch set.  For now,
>>>>>> we only duplicate the class definition for rawip_socket for SCTP and ICMP
>>>>>> sockets since that is how they were previously mapped.  The SCTP definition
>>>>>> can be further fleshed out by the SCTP patch set itself.
>>>>>>
>>>>>>  security/selinux/hooks.c            | 73 +++++++++++++++++++++++++++++++++++++
>>>>>>  security/selinux/include/classmap.h | 68 ++++++++++++++++++++++++++++++++++
>>>>>>  security/selinux/include/security.h |  3 +-
>>>>>>  security/selinux/selinuxfs.c        |  2 +-
>>>>>>  security/selinux/ss/services.c      |  3 ++
>>>>>>  5 files changed, 147 insertions(+), 2 deletions(-)
>>>>>
>>>>> You mentioned IGMP previously, if we have a class for ICMP, it seems
>>>>> reasonable to have one for IGMP, don't you think?  Although this does
>>>>> spiral a bit if we consider all the IPPROTO* protocols.
>>>>
>>>> I thought about it, but the kernel does not provide IGMP sockets per se,
>>>> unlike ICMP or SCTP sockets (i.e. ipv4/af_inet.c:inetsw_array[] defines
>>>> an entry for SOCK_DGRAM, IPPROTO_ICMP and sctp/protocol.c defines and
>>>> registers inet_protosw entries for SOCK_STREAM, IPPROTO_SCTP and
>>>> SOCK_SEQPACKET, IPPROTO_SCTP; there is no equivalent for IGMP unless I
>>>> missed it).  So IGMP sockets are just raw IP sockets with a particular
>>>> protocol value; they have no stream, seqpacket, or dgram semantics, and
>>>> it is unclear it is worthwhile to distinguish them in policy.
>>>
>>> Yes, sorry about that, it looks like you're right.  I thought there
>>> might be some sort of IGMP routing daemon or something that would need
>>> to create an IGMP socket, but it looks like you just configure the
>>> kernel's multicast routing table and the kernel takes care of the IGMP
>>> packets.
>>
>> Well, I think you can create an IGMP socket ala socket(PF_INET,
>> SOCK_RAW, IPPROTO_IGMP).  And we could map that to a IGMP socket class
>> if we really wanted to do so.  But that would be the first time we ever
>> mapped a (PF_INET, SOCK_RAW, proto) to something other than
>> SECCLASS_RAWIP_SOCKET.  And at that point we'd probably want to map
>> every individual protocol value.  Not sure we need/want to go there.
> 
> Yes, creating classes for each IPPROTO value is not something I think
> we want to do, although I have no problem doing it for key protocols
> as necessary.
> 
> I just merged this into selinux#next, the pull request for v4.10 was
> already sent up to James so this will go in during the v4.11 merge
> window (I think this can wait, it might give us time to get some of
> the policy ready).

Yes, sounds good.  I just pushed the patch for libsepol that allows one
to specify the new policy capability in policy, and attached is a patch
for Fedora's policy that you can add to its .spec file and rebuild if
you want to try it out (but you first have to build and install the
updated selinux userspace that defines it).  May submit a modified form
for upstream refpolicy that just comments out the policy capability so
that we don't break building refpolicy on the currently released libsepol.

--------------558A31E8B95B58D4A5C2D717
Content-Type: text/x-patch;
 name="refpolicy-extended-socket-class.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="refpolicy-extended-socket-class.patch"

diff -ru serefpolicy-3.13.1.orig/policy/flask/access_vectors serefpolicy-3.13.1/policy/flask/access_vectors
--- serefpolicy-3.13.1.orig/policy/flask/access_vectors	2016-12-08 09:25:14.979787006 -0500
+++ serefpolicy-3.13.1/policy/flask/access_vectors	2016-12-08 10:46:30.621989680 -0500
@@ -950,3 +950,118 @@
 
 class cap2_userns
 inherits cap2
+
+#
+# Define the access vector interpretation for the new socket classes
+# enabled by the extended_socket_class policy capability.
+#
+
+#
+# The next two classes were previously mapped to rawip_socket and therefore
+# have the same definition as rawip_socket (until further permissions
+# are defined).
+#
+class sctp_socket
+inherits socket
+{
+	node_bind
+}
+
+class icmp_socket
+inherits socket
+{
+	node_bind
+}
+
+#
+# The remaining network socket classes were previously
+# mapped to the socket class and therefore have the
+# same definition as socket.
+#
+
+class ax25_socket
+inherits socket
+
+class ipx_socket
+inherits socket
+
+class netrom_socket
+inherits socket
+
+class bridge_socket
+inherits socket
+
+class atmpvc_socket
+inherits socket
+
+class x25_socket
+inherits socket
+
+class rose_socket
+inherits socket
+
+class decnet_socket
+inherits socket
+
+class atmsvc_socket
+inherits socket
+
+class rds_socket
+inherits socket
+
+class irda_socket
+inherits socket
+
+class pppox_socket
+inherits socket
+
+class llc_socket
+inherits socket
+
+class ib_socket
+inherits socket
+
+class mpls_socket
+inherits socket
+
+class can_socket
+inherits socket
+
+class tipc_socket
+inherits socket
+
+class bluetooth_socket
+inherits socket
+
+class iucv_socket
+inherits socket
+
+class rxrpc_socket
+inherits socket
+
+class isdn_socket
+inherits socket
+
+class phonet_socket
+inherits socket
+
+class ieee802154_socket
+inherits socket
+
+class caif_socket
+inherits socket
+
+class alg_socket
+inherits socket
+
+class nfc_socket
+inherits socket
+
+class vsock_socket
+inherits socket
+
+class kcm_socket
+inherits socket
+
+class qipcrtr_socket
+inherits socket
diff -ru serefpolicy-3.13.1.orig/policy/flask/security_classes serefpolicy-3.13.1/policy/flask/security_classes
--- serefpolicy-3.13.1.orig/policy/flask/security_classes	2016-12-08 09:25:14.979787006 -0500
+++ serefpolicy-3.13.1/policy/flask/security_classes	2016-12-08 10:40:29.799582596 -0500
@@ -154,4 +154,39 @@
 class cap_userns
 class cap2_userns
 
+# New socket classes introduced by extended_socket_class policy capability.
+# These two were previously mapped to rawip_socket.
+class sctp_socket
+class icmp_socket
+# These were previously mapped to socket.
+class ax25_socket
+class ipx_socket
+class netrom_socket
+class bridge_socket
+class atmpvc_socket
+class x25_socket
+class rose_socket
+class decnet_socket
+class atmsvc_socket
+class rds_socket
+class irda_socket
+class pppox_socket
+class llc_socket
+class ib_socket
+class mpls_socket
+class can_socket
+class tipc_socket
+class bluetooth_socket
+class iucv_socket
+class rxrpc_socket
+class isdn_socket
+class phonet_socket
+class ieee802154_socket
+class caif_socket
+class alg_socket
+class nfc_socket
+class vsock_socket
+class kcm_socket
+class qipcrtr_socket
+
 # FLASK
diff -ru serefpolicy-3.13.1.orig/policy/policy_capabilities serefpolicy-3.13.1/policy/policy_capabilities
--- serefpolicy-3.13.1.orig/policy/policy_capabilities	2013-11-13 03:56:14.000000000 -0500
+++ serefpolicy-3.13.1/policy/policy_capabilities	2016-12-08 10:37:48.657007126 -0500
@@ -31,3 +31,44 @@
 # blk_file: open
 #
 policycap open_perms;
+
+# Enable separate security classes for
+# all network address families previously
+# mapped to the socket class and for
+# ICMP and SCTP sockets previously mapped
+# to the rawip_socket class.
+#
+# Classes enabled:
+# sctp_socket
+# icmp_socket
+# ax25_socket
+# ipx_socket
+# netrom_socket
+# bridge_socket
+# atmpvc_socket
+# x25_socket
+# rose_socket
+# decnet_socket
+# atmsvc_socket
+# rds_socket
+# irda_socket
+# pppox_socket
+# llc_socket
+# ib_socket
+# mpls_socket
+# can_socket
+# tipc_socket
+# bluetooth_socket
+# iucv_socket
+# rxrpc_socket
+# isdn_socket
+# phonet_socket
+# ieee802154_socket
+# caif_socket
+# alg_socket
+# nfc_socket
+# vsock_socket
+# kcm_socket
+# qipcrtr_socket
+#
+policycap extended_socket_class;
diff -ru serefpolicy-3.13.1.orig/policy/support/obj_perm_sets.spt serefpolicy-3.13.1/policy/support/obj_perm_sets.spt
--- serefpolicy-3.13.1.orig/policy/support/obj_perm_sets.spt	2016-12-08 09:25:15.032787970 -0500
+++ serefpolicy-3.13.1/policy/support/obj_perm_sets.spt	2016-12-08 10:50:08.497462292 -0500
@@ -28,7 +28,7 @@
 #
 # All socket classes.
 #
-define(`socket_class_set', `{ tcp_socket udp_socket rawip_socket netlink_socket packet_socket unix_stream_socket unix_dgram_socket appletalk_socket netlink_route_socket netlink_firewall_socket netlink_tcpdiag_socket netlink_nflog_socket netlink_xfrm_socket netlink_selinux_socket netlink_audit_socket netlink_ip6fw_socket netlink_dnrt_socket netlink_kobject_uevent_socket tun_socket netlink_iscsi_socket netlink_fib_lookup_socket netlink_connector_socket netlink_netfilter_socket netlink_generic_socket netlink_scsitransport_socket netlink_rdma_socket netlink_crypto_socket }')
+define(`socket_class_set', `{ tcp_socket udp_socket rawip_socket netlink_socket packet_socket unix_stream_socket unix_dgram_socket appletalk_socket netlink_route_socket netlink_firewall_socket netlink_tcpdiag_socket netlink_nflog_socket netlink_xfrm_socket netlink_selinux_socket netlink_audit_socket netlink_ip6fw_socket netlink_dnrt_socket netlink_kobject_uevent_socket tun_socket netlink_iscsi_socket netlink_fib_lookup_socket netlink_connector_socket netlink_netfilter_socket netlink_generic_socket netlink_scsitransport_socket netlink_rdma_socket netlink_crypto_socket sctp_socket icmp_socket ax25_socket ipx_socket netrom_socket bridge_socket atmpvc_socket x25_socket rose_socket decnet_socket atmsvc_socket rds_socket irda_socket pppox_socket llc_socket ib_socket mpls_socket can_socket tipc_socket bluetooth_socket iucv_socket rxrpc_socket isdn_socket phonet_socket ieee802154_socket caif_socket alg_socket nfc_socket vsock_socket kcm_socket qipcrtr_socket}')
 
 #
 # Datagram socket classes.

--------------558A31E8B95B58D4A5C2D717--
