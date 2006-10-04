Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k942tUiE001526
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 22:55:30 -0400
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k942splM023106
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 02:54:55 GMT
Message-ID: <45232276.2080105@trustedcs.com>
Date: Tue, 03 Oct 2006 21:54:46 -0500
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov, redhat-lspp@redhat.com
Subject: Networking policy patch
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

FYI- I have posted the following patches separate from this one.

1. A patch to address the "leask" issue. Once verified, it needs
to be rolled in with James' patch and sent on after verification.

2. A fix for flow_in and flow_out where we were using the unlabeled
   init sid. We would now use a new network_t with a range of (s0-s15...)
   to allow for mls traffic to flow out/in, in the absence of explicit secmark
   rules.


The following is a sample patch for networking using the new controls
in conjunction with secmark.

NOTE FOR JOSHUA: This patch also defines the constraints to force context
equality for association:sendto.

I couldn't readily figure out where to stick these in, but these would
help the system come up without any denials.

+allow domain network_t:packet { flow_in flow_out };
+auditallow domain network_t:packet { flow_in flow_out };
+allow unlabeled_t network_t:packet { flow_in flow_out };
+auditallow unlabeled_t network_t:packet { flow_in flow_out };
+allow domain domain:packet { recv };
+auditallow domain domain:packet { recv };
+allow initrc_t unlabeled_t:packet { recv };
+auditallow initrc_t unlabeled_t:packet { recv };
+allow portmap_t unlabeled_t:packet { recv };
+auditallow portmap_t unlabeled_t:packet { recv };
+allow portmap_t rpcd_t:packet { recv };
+auditallow portmap_t rpcd_t:packet { recv };
+allow hplip_t hplip_t:packet { recv };
+auditallow hplip_t hplip_t:packet { recv };
+allow hplip_t cupsd_t:packet { recv };
+auditallow hplip_t cupsd_t:packet { recv };
+allow domain unlabeled_t:packet { recv };
+auditallow domain unlabeled_t:packet { recv };
+allow avahi_t unlabeled_t:packet { recv };
+auditallow avahi_t unlabeled_t:packet { recv };


--- serefpolicy-2.3.2.vanilla/policy/mls	2006-07-09 04:51:24.000000000 -0500
+++ serefpolicy-2.3.2/policy/mls	2006-10-03 18:45:33.000000000 -0500
@@ -668,7 +668,30 @@ mlsconstrain xinput { setattr relabelinp
 # MLS policy for the association class
 #
 
-# these access vectors have no MLS restrictions
-# association *
+mlsconstrain association { recvfrom }
+	((( l1 dom l2 ) and ( l1 domby h2 )) or
+	 (( t1 == mlsnetreadtoclr ) and ( h1 dom l2 )) or
+	 ( t1 == mlsnetread ) or
+	 ( t2 == unlabeled_t ));
+
+mlsconstrain association { sendto }
+	(( l1 eq l2 ) and ( h1 eq h2 ));
+
+mlsconstrain association { polmatch }
+	((( l1 dom l2 ) and ( l1 domby h2 )) or
+	 ( t2 == unlabeled_t ));
+
+#
+# MLS policy for the packet class
+#
+
+mlsconstrain packet { recv }
+	(( l1 eq l2 ) or
+	 (( t1 == mlsnetreadtoclr ) and ( h1 dom l2 )) or
+	 ( t1 == mlsnetread ));
+
+mlsconstrain packet { flow_in flow_out }
+	((( l1 dom l2 ) and ( l1 domby h2 )) or
+	 ( t1 == mlsnetflow ));
 
 ') dnl end enable_mls
--- serefpolicy-2.3.2.vanilla/policy/flask/access_vectors	2006-07-09 04:51:24.000000000 -0500
+++ serefpolicy-2.3.2/policy/flask/access_vectors	2006-10-03 18:45:33.000000000 -0500
@@ -617,6 +618,8 @@ class packet
 	send
 	recv
 	relabelto
+	flow_in
+	flow_out
 }
 
 class key
--- serefpolicy-2.3.2.vanilla/policy/constraints	2006-07-09 04:51:24.000000000 -0500
+++ serefpolicy-2.3.2/policy/constraints	2006-10-03 18:45:33.000000000 -0500
@@ -90,3 +90,9 @@ constrain dir_file_class_set { create re
 
 constrain socket_class_set { create relabelto relabelfrom } 
 	( u1 == u2 or t1 == can_change_object_identity );
+
+#
+# SElinux association sendto constraint:
+#
+constrain association sendto
+	( u1 == u2 and r1 == r2 and t1 == t2 );
--- serefpolicy-2.3.2.vanilla/policy/modules/kernel/mls.te	2006-07-09 04:51:24.000000000 -0500
+++ serefpolicy-2.3.2/policy/modules/kernel/mls.te	2006-10-03 18:45:33.000000000 -0500
@@ -20,6 +20,7 @@ attribute mlsnetwritetoclr;
 attribute mlsnetupgrade;
 attribute mlsnetdowngrade;
 attribute mlsnetrecvall;
+attribute mlsnetflow;
 
 attribute mlsipcread;
 attribute mlsipcreadtoclr;
--- serefpolicy-2.3.2.vanilla/policy/modules/kernel/kernel.te	2006-07-09 04:51:24.000000000 -0500
+++ serefpolicy-2.3.2/policy/modules/kernel/kernel.te	2006-10-03 18:58:37.000000000 -0500
@@ -35,7 +35,7 @@ ifdef(`enable_mls',`
 # kernel_t is the domain of kernel threads.
 # It is also the target type when checking permissions in the system class.
 # 
-type kernel_t, can_load_kernmodule;
+type kernel_t, can_load_kernmodule, mlsnetflow;
 domain_base_type(kernel_t)
 mls_rangetrans_source(kernel_t)
 role system_r types kernel_t;
@@ -138,6 +138,18 @@ genfscon proc /sys/dev gen_context(syste
 type unlabeled_t;
 sid unlabeled gen_context(system_u:object_r:unlabeled_t,s15:c0.c255)
 
+# netmsg is now used for the unconditional (and redundant when a packet has
+# already been flow-controlled via [CONN]SECMARK) check that happens in the
+# SELinux post_route_last netfilter hook for ALL network traffic.
+# The following would need packet.flow_out access to network_t:
+# a. Any domains needing to access the network bypassing (CONN)SECMARK.
+# b. Outbound domains specified in the (CONN)SECMARK rule contexts specified
+#    via iptables. This shouldn't actually be needed (just like a packet.flow_in access
+#    of these domains to network_t isn't needed), but is currently required due to the
+#    underlying kernel implementation constraints.
+type network_t;
+sid netmsg		gen_context(system_u:object_r:network_t,s0 - s15:c0.c255)
+
 # These initial sids are no longer used, and can be removed:
 sid any_socket		gen_context(system_u:object_r:unlabeled_t,s15:c0.c255)
 sid file_labels		gen_context(system_u:object_r:unlabeled_t,s0)
@@ -145,7 +157,6 @@ sid icmp_socket		gen_context(system_u:ob
 sid igmp_packet		gen_context(system_u:object_r:unlabeled_t,s15:c0.c255)
 sid init		gen_context(system_u:object_r:unlabeled_t,s0)
 sid kmod		gen_context(system_u:object_r:unlabeled_t,s15:c0.c255)
-sid netmsg		gen_context(system_u:object_r:unlabeled_t,s15:c0.c255)
 sid policy		gen_context(system_u:object_r:unlabeled_t,s15:c0.c255)
 sid scmp_packet		gen_context(system_u:object_r:unlabeled_t,s15:c0.c255)
 sid sysctl_modprobe 	gen_context(system_u:object_r:unlabeled_t,s0)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
