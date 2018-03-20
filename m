Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w2KHsckP016608
 for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2018 13:54:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC04.oob.disa.mil (Postfix) with SMTP id 405LD22L5Hz63cV
 for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2018 17:54:26 +0000 (UTC)
Received: from UPBD19PA14.eemsg.mil (unknown [192.168.18.14])
 by UPDCF3IC04.oob.disa.mil (Postfix) with ESMTP id 405LD20MgZz63cW
 for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2018 17:54:26 +0000 (UTC)
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Date: Tue, 20 Mar 2018 17:48:54 +0000
Message-Id: <20180320174854.3154-1-richard_c_haines@btinternet.com>
Subject: [PATCH] selinux-testsuite: Add SCTP test support
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The sctp testsuite tests all new sctp SELinux functionality.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 policy/Makefile                        |   4 +
 policy/test_sctp.te                    | 159 +++++++
 tests/Makefile                         |   4 +
 tests/sctp/Makefile                    |  13 +
 tests/sctp/calipso-flush               |   5 +
 tests/sctp/calipso-load                |   7 +
 tests/sctp/cipso-fl-flush              |   5 +
 tests/sctp/cipso-fl-load               |   7 +
 tests/sctp/cipso-flush                 |   5 +
 tests/sctp/cipso-load-t1               |   7 +
 tests/sctp/cipso-load-t2               |   7 +
 tests/sctp/cipso-load-t5               |   7 +
 tests/sctp/fb-deny-label-flush         |   6 +
 tests/sctp/fb-deny-label-load          |   7 +
 tests/sctp/fb-label-flush              |   6 +
 tests/sctp/fb-label-load               |   8 +
 tests/sctp/iptables-flush              |   4 +
 tests/sctp/iptables-load               |  27 ++
 tests/sctp/sctp_asconf_params_client.c | 298 +++++++++++++
 tests/sctp/sctp_asconf_params_server.c | 236 ++++++++++
 tests/sctp/sctp_bind.c                 |  61 +++
 tests/sctp/sctp_bindx.c                | 116 +++++
 tests/sctp/sctp_client.c               | 220 +++++++++
 tests/sctp/sctp_common.c               | 101 +++++
 tests/sctp/sctp_common.h               |  27 ++
 tests/sctp/sctp_connectx.c             | 124 ++++++
 tests/sctp/sctp_peeloff_server.c       | 260 +++++++++++
 tests/sctp/sctp_server.c               | 335 ++++++++++++++
 tests/sctp/sctp_set_params.c           | 205 +++++++++
 tests/sctp/sctp_set_peer_addr.c        | 414 +++++++++++++++++
 tests/sctp/sctp_set_pri_addr.c         | 135 ++++++
 tests/sctp/test                        | 791 +++++++++++++++++++++++++++++++++
 32 files changed, 3611 insertions(+)
 create mode 100644 policy/test_sctp.te
 create mode 100644 tests/sctp/Makefile
 create mode 100644 tests/sctp/calipso-flush
 create mode 100644 tests/sctp/calipso-load
 create mode 100644 tests/sctp/cipso-fl-flush
 create mode 100644 tests/sctp/cipso-fl-load
 create mode 100644 tests/sctp/cipso-flush
 create mode 100644 tests/sctp/cipso-load-t1
 create mode 100644 tests/sctp/cipso-load-t2
 create mode 100644 tests/sctp/cipso-load-t5
 create mode 100644 tests/sctp/fb-deny-label-flush
 create mode 100644 tests/sctp/fb-deny-label-load
 create mode 100644 tests/sctp/fb-label-flush
 create mode 100644 tests/sctp/fb-label-load
 create mode 100644 tests/sctp/iptables-flush
 create mode 100644 tests/sctp/iptables-load
 create mode 100644 tests/sctp/sctp_asconf_params_client.c
 create mode 100644 tests/sctp/sctp_asconf_params_server.c
 create mode 100644 tests/sctp/sctp_bind.c
 create mode 100644 tests/sctp/sctp_bindx.c
 create mode 100644 tests/sctp/sctp_client.c
 create mode 100644 tests/sctp/sctp_common.c
 create mode 100644 tests/sctp/sctp_common.h
 create mode 100644 tests/sctp/sctp_connectx.c
 create mode 100644 tests/sctp/sctp_peeloff_server.c
 create mode 100644 tests/sctp/sctp_server.c
 create mode 100644 tests/sctp/sctp_set_params.c
 create mode 100644 tests/sctp/sctp_set_peer_addr.c
 create mode 100644 tests/sctp/sctp_set_pri_addr.c
 create mode 100644 tests/sctp/test

diff --git a/policy/Makefile b/policy/Makefile
index 8ed5e46..031429a 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -63,6 +63,10 @@ ifeq ($(shell grep -q nnp_transition $(POLDEV)/include/support/all_perms.spt &&
 export M4PARAM += -Dnnp_nosuid_transition_permission_defined
 endif
 
+ifeq ($(shell grep -q corenet_sctp_bind_all_nodes $(POLDEV)/include/kernel/corenetwork.if && echo true),true)
+TARGETS += test_sctp.te
+endif
+
 ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
 TARGETS:=$(filter-out test_overlayfs.te test_mqueue.te, $(TARGETS))
 endif
diff --git a/policy/test_sctp.te b/policy/test_sctp.te
new file mode 100644
index 0000000..6d43208
--- /dev/null
+++ b/policy/test_sctp.te
@@ -0,0 +1,159 @@
+#
+################# SCTP selinux-testsuite policy module ######################
+#
+
+attribute sctpsocketdomain;
+
+#
+######################## NetLabel labels ############################
+#
+# Fall-back labeling label:
+type netlabel_sctp_peer_t;
+corenet_in_generic_node(netlabel_sctp_peer_t)
+corenet_in_generic_if(netlabel_sctp_peer_t)
+
+# Default label for CIPSO/CALIPSO:
+gen_require(`
+	type netlabel_peer_t;
+')
+
+#
+############### Declare an attribute that will hold all peers ###############
+###############           allowed an association              ###############
+#
+attribute sctp_assoc_peers;
+
+typeattribute netlabel_peer_t sctp_assoc_peers;
+typeattribute netlabel_sctp_peer_t sctp_assoc_peers;
+allow sctp_assoc_peers sctp_assoc_peers:sctp_socket { association };
+
+#
+##################### SCTP portcon for ports 1024-65535 ######################
+#
+corenet_sctp_bind_all_unreserved_ports(sctpsocketdomain)
+corenet_sctp_connect_all_unreserved_ports(sctpsocketdomain)
+
+#
+################################## Server ###################################
+#
+type test_sctp_server_t;
+domain_type(test_sctp_server_t)
+unconfined_runs_test(test_sctp_server_t)
+typeattribute test_sctp_server_t testdomain;
+typeattribute test_sctp_server_t sctpsocketdomain;
+allow test_sctp_server_t self:sctp_socket create_stream_socket_perms;
+allow test_sctp_server_t netlabel_sctp_peer_t:peer { recv };
+corenet_sctp_bind_all_nodes(test_sctp_server_t)
+corenet_inout_generic_node(test_sctp_server_t)
+corenet_inout_generic_if(test_sctp_server_t)
+
+#
+############################### Client #################################
+#
+type test_sctp_client_t;
+domain_type(test_sctp_client_t)
+unconfined_runs_test(test_sctp_client_t)
+typeattribute test_sctp_client_t testdomain;
+typeattribute test_sctp_client_t sctpsocketdomain;
+allow test_sctp_client_t self:sctp_socket create_stream_socket_perms;
+allow test_sctp_server_t test_sctp_client_t:peer { recv };
+allow test_sctp_client_t test_sctp_server_t:peer { recv };
+allow test_sctp_client_t netlabel_sctp_peer_t:peer { recv };
+corenet_inout_generic_node(test_sctp_client_t)
+corenet_inout_generic_if(test_sctp_client_t)
+
+#
+#################### Deny peer recv permission Client ########################
+#
+type test_sctp_deny_peer_client_t;
+domain_type(test_sctp_deny_peer_client_t)
+unconfined_runs_test(test_sctp_deny_peer_client_t)
+typeattribute test_sctp_deny_peer_client_t testdomain;
+typeattribute test_sctp_deny_peer_client_t sctpsocketdomain;
+allow test_sctp_deny_peer_client_t self:sctp_socket create_stream_socket_perms;
+corenet_inout_generic_node(test_sctp_deny_peer_client_t)
+corenet_inout_generic_if(deny_assoc_sctp_peer_t)
+
+#
+####################### Deny association permission #########################
+#
+
+# Declare this type for NetLabel etc. to allow the packet through the system,
+# however do not allow an association:
+type deny_assoc_sctp_peer_t;
+allow test_sctp_server_t deny_assoc_sctp_peer_t:peer { recv };
+allow test_sctp_client_t deny_assoc_sctp_peer_t:peer {recv };
+corenet_inout_generic_node(deny_assoc_sctp_peer_t)
+corenet_inout_generic_if(deny_assoc_sctp_peer_t)
+
+#
+############################# Connectx #################################
+#
+type test_sctp_connectx_t;
+domain_type(test_sctp_connectx_t)
+unconfined_runs_test(test_sctp_connectx_t)
+typeattribute test_sctp_connectx_t testdomain;
+typeattribute test_sctp_connectx_t sctpsocketdomain;
+allow test_sctp_connectx_t self:sctp_socket create_stream_socket_perms;
+allow test_sctp_server_t test_sctp_connectx_t:peer { recv };
+allow test_sctp_connectx_t test_sctp_server_t:peer { recv };
+corenet_sctp_bind_all_nodes(test_sctp_connectx_t)
+corenet_inout_generic_node(test_sctp_connectx_t)
+corenet_inout_generic_if(test_sctp_connectx_t)
+
+#
+############################## Bindx #####################################
+#
+type test_sctp_bindx_t;
+domain_type(test_sctp_bindx_t)
+unconfined_runs_test(test_sctp_bindx_t)
+typeattribute test_sctp_bindx_t testdomain;
+typeattribute test_sctp_bindx_t sctpsocketdomain;
+allow test_sctp_bindx_t self:sctp_socket create_stream_socket_perms;
+allow test_sctp_server_t test_sctp_bindx_t:peer { recv };
+allow test_sctp_bindx_t test_sctp_server_t:peer { recv };
+corenet_sctp_bind_all_nodes(test_sctp_bindx_t)
+corenet_inout_generic_node(test_sctp_bindx_t)
+corenet_inout_generic_if(test_sctp_bindx_t)
+
+#
+########## SET_PRI_ADDR + SET_PEER ADDR for ASCONF process testing ##########
+#
+type test_sctp_set_peer_addr_t;
+domain_type(test_sctp_set_peer_addr_t)
+unconfined_runs_test(test_sctp_set_peer_addr_t)
+typeattribute test_sctp_set_peer_addr_t testdomain;
+typeattribute test_sctp_set_peer_addr_t sctpsocketdomain;
+allow test_sctp_set_peer_addr_t self:sctp_socket create_stream_socket_perms;
+allow test_sctp_server_t test_sctp_set_peer_addr_t:peer { recv };
+allow test_sctp_set_peer_addr_t test_sctp_server_t:peer { recv };
+corenet_sctp_bind_all_nodes(test_sctp_set_peer_addr_t)
+corenet_inout_generic_node(test_sctp_set_peer_addr_t)
+corenet_inout_generic_if(test_sctp_set_peer_addr_t)
+
+#
+######################### SECMARK-specific policy ############################
+#
+type test_sctp_server_packet_t;
+allow unconfined_t test_sctp_server_packet_t:packet { relabelto };
+allow test_sctp_server_t test_sctp_server_packet_t:packet { send recv };
+allow test_sctp_client_t test_sctp_server_packet_t:packet { send recv };
+
+#
+####### Required for getaddrinfo(3), if_nametoindex(3) type functions ########
+########## when resolving IPv6 link local addresses e.g. addr%<if> ###########
+#
+gen_require(`
+	type sysctl_net_t;
+')
+
+allow sctpsocketdomain proc_net_t:file { read };
+allow sctpsocketdomain sysctl_net_t:dir { search };
+allow sctpsocketdomain self:udp_socket { create };
+allow sctpsocketdomain self:unix_dgram_socket { create ioctl };
+
+#
+############ Allow these domains to be entered from sysadm domain ############
+#
+miscfiles_domain_entry_test_files(sctpsocketdomain)
+userdom_sysadm_entry_spec_domtrans_to(sctpsocketdomain)
diff --git a/tests/Makefile b/tests/Makefile
index f2291b2..4f5a1af 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -23,6 +23,10 @@ ifeq ($(shell grep -q icmp_socket $(POLDEV)/include/support/all_perms.spt && gre
 SUBDIRS += extended_socket_class
 endif
 
+ifeq ($(shell grep -q corenet_sctp_bind_all_nodes $(POLDEV)/include/kernel/corenetwork.if && grep -q 1 /sys/fs/selinux/policy_capabilities/extended_socket_class && echo true),true)
+SUBDIRS += sctp
+endif
+
 ifeq ($(shell grep -q netlink_iscsi_socket $(POLDEV)/include/support/all_perms.spt && echo true),true)
 SUBDIRS += netlink_socket
 endif
diff --git a/tests/sctp/Makefile b/tests/sctp/Makefile
new file mode 100644
index 0000000..1debf82
--- /dev/null
+++ b/tests/sctp/Makefile
@@ -0,0 +1,13 @@
+TARGETS = sctp_client sctp_server sctp_bind sctp_bindx sctp_connectx sctp_set_params sctp_set_peer_addr sctp_set_pri_addr sctp_asconf_params_client sctp_asconf_params_server sctp_peeloff_server
+
+DEPS = sctp_common.c sctp_common.h
+CFLAGS ?= -Wall
+
+LDLIBS += -lselinux -lsctp
+
+all: $(TARGETS)
+
+clean:
+	rm -f $(TARGETS)
+
+$(TARGETS): $(DEPS)
diff --git a/tests/sctp/calipso-flush b/tests/sctp/calipso-flush
new file mode 100644
index 0000000..5143962
--- /dev/null
+++ b/tests/sctp/calipso-flush
@@ -0,0 +1,5 @@
+#!/bin/sh
+# Reset NetLabel configuration to unlabeled after CALIPSO/IPv6 tests.
+netlabelctl map del default
+netlabelctl calipso del doi:16
+netlabelctl map add default protocol:unlbl
diff --git a/tests/sctp/calipso-load b/tests/sctp/calipso-load
new file mode 100644
index 0000000..4bb9c7f
--- /dev/null
+++ b/tests/sctp/calipso-load
@@ -0,0 +1,7 @@
+#!/bin/sh
+# Define a doi for testing loopback for CALIPSO/IPv6.
+netlabelctl calipso add pass doi:16
+netlabelctl map del default
+netlabelctl map add default address:0.0.0.0/0 protocol:unlbl
+netlabelctl map add default address:::/0 protocol:unlbl
+netlabelctl map add default address:::1 protocol:calipso,16
diff --git a/tests/sctp/cipso-fl-flush b/tests/sctp/cipso-fl-flush
new file mode 100644
index 0000000..032960d
--- /dev/null
+++ b/tests/sctp/cipso-fl-flush
@@ -0,0 +1,5 @@
+#!/bin/sh
+
+netlabelctl map del default
+netlabelctl cipsov4 del doi:1
+netlabelctl map add default protocol:unlbl
diff --git a/tests/sctp/cipso-fl-load b/tests/sctp/cipso-fl-load
new file mode 100644
index 0000000..3ef85b4
--- /dev/null
+++ b/tests/sctp/cipso-fl-load
@@ -0,0 +1,7 @@
+#!/bin/sh
+
+netlabelctl cipsov4 add local doi:1
+netlabelctl map del default
+netlabelctl map add default address:0.0.0.0/0 protocol:unlbl
+netlabelctl map add default address:::/0 protocol:unlbl
+netlabelctl map add default address:127.0.0.1 protocol:cipsov4,1
diff --git a/tests/sctp/cipso-flush b/tests/sctp/cipso-flush
new file mode 100644
index 0000000..6da5b05
--- /dev/null
+++ b/tests/sctp/cipso-flush
@@ -0,0 +1,5 @@
+#!/bin/sh
+# Reset NetLabel configuration to unlabeled for all after CIPSO/IPv4 tests.
+netlabelctl map del default
+netlabelctl cipsov4 del doi:16
+netlabelctl map add default protocol:unlbl
diff --git a/tests/sctp/cipso-load-t1 b/tests/sctp/cipso-load-t1
new file mode 100644
index 0000000..6e9a161
--- /dev/null
+++ b/tests/sctp/cipso-load-t1
@@ -0,0 +1,7 @@
+#!/bin/sh
+
+netlabelctl cipsov4 add pass doi:16 tags:1
+netlabelctl map del default
+netlabelctl map add default address:0.0.0.0/0 protocol:unlbl
+netlabelctl map add default address:::/0 protocol:unlbl
+netlabelctl map add default address:127.0.0.1 protocol:cipsov4,16
diff --git a/tests/sctp/cipso-load-t2 b/tests/sctp/cipso-load-t2
new file mode 100644
index 0000000..3227ba5
--- /dev/null
+++ b/tests/sctp/cipso-load-t2
@@ -0,0 +1,7 @@
+#!/bin/sh
+
+netlabelctl cipsov4 add pass doi:16 tags:2
+netlabelctl map del default
+netlabelctl map add default address:0.0.0.0/0 protocol:unlbl
+netlabelctl map add default address:::/0 protocol:unlbl
+netlabelctl map add default address:127.0.0.1 protocol:cipsov4,16
diff --git a/tests/sctp/cipso-load-t5 b/tests/sctp/cipso-load-t5
new file mode 100644
index 0000000..661afb8
--- /dev/null
+++ b/tests/sctp/cipso-load-t5
@@ -0,0 +1,7 @@
+#!/bin/sh
+
+netlabelctl cipsov4 add pass doi:16 tags:5
+netlabelctl map del default
+netlabelctl map add default address:0.0.0.0/0 protocol:unlbl
+netlabelctl map add default address:::/0 protocol:unlbl
+netlabelctl map add default address:127.0.0.1 protocol:cipsov4,16
diff --git a/tests/sctp/fb-deny-label-flush b/tests/sctp/fb-deny-label-flush
new file mode 100644
index 0000000..059e0b7
--- /dev/null
+++ b/tests/sctp/fb-deny-label-flush
@@ -0,0 +1,6 @@
+#!/bin/sh
+
+netlabelctl map del default
+netlabelctl map add default protocol:unlbl
+netlabelctl unlbl del interface:lo address:127.0.0.0/8 label:system_u:object_r:netlabel_sctp_peer_t:s0
+netlabelctl unlbl del interface:lo address:::1/128 label:system_u:object_r:deny_assoc_sctp_peer_t:s0
diff --git a/tests/sctp/fb-deny-label-load b/tests/sctp/fb-deny-label-load
new file mode 100644
index 0000000..7c0bd87
--- /dev/null
+++ b/tests/sctp/fb-deny-label-load
@@ -0,0 +1,7 @@
+#!/bin/sh
+
+netlabelctl map del default
+netlabelctl map add default address:0.0.0.0/0 protocol:unlbl
+netlabelctl map add default address:::/0 protocol:unlbl
+netlabelctl unlbl add interface:lo address:127.0.0.0/8 label:system_u:object_r:netlabel_sctp_peer_t:s0
+netlabelctl unlbl add interface:lo address:::1/128 label:system_u:object_r:deny_assoc_sctp_peer_t:s0
diff --git a/tests/sctp/fb-label-flush b/tests/sctp/fb-label-flush
new file mode 100644
index 0000000..13573a8
--- /dev/null
+++ b/tests/sctp/fb-label-flush
@@ -0,0 +1,6 @@
+#!/bin/sh
+
+netlabelctl map del default
+netlabelctl map add default protocol:unlbl
+netlabelctl unlbl del interface:lo address:127.0.0.0/8 label:system_u:object_r:netlabel_sctp_peer_t:s0
+netlabelctl unlbl del interface:lo address:::1/128 label:system_u:object_r:netlabel_sctp_peer_t:s0
diff --git a/tests/sctp/fb-label-load b/tests/sctp/fb-label-load
new file mode 100644
index 0000000..a501515
--- /dev/null
+++ b/tests/sctp/fb-label-load
@@ -0,0 +1,8 @@
+#!/bin/sh
+
+netlabelctl map del default
+netlabelctl map add default address:0.0.0.0/0 protocol:unlbl
+netlabelctl map add default address:::/0 protocol:unlbl
+netlabelctl unlbl add interface:lo address:127.0.0.0/8 label:system_u:object_r:netlabel_sctp_peer_t:s0
+netlabelctl unlbl add interface:lo address:::1/128 label:system_u:object_r:netlabel_sctp_peer_t:s0
+#netlabelctl -p unlbl list
diff --git a/tests/sctp/iptables-flush b/tests/sctp/iptables-flush
new file mode 100644
index 0000000..e74271a
--- /dev/null
+++ b/tests/sctp/iptables-flush
@@ -0,0 +1,4 @@
+#!/bin/sh
+# Flush the security table after IPv4 and IPv6 tests.
+iptables -t security -F
+ip6tables -t security -F
diff --git a/tests/sctp/iptables-load b/tests/sctp/iptables-load
new file mode 100644
index 0000000..9dac576
--- /dev/null
+++ b/tests/sctp/iptables-load
@@ -0,0 +1,27 @@
+#!/bin/sh
+############################ SECMARK IPTABLE ENTRIES ########################
+#
+# Flush the security table first:
+iptables -t security -F
+ip6tables -t security -F
+
+#-------------- INPUT IP Stream --------------------#
+# These rules will replace the above context if sctp ports 1024:1035 are found in the packets:
+iptables -t security -A INPUT -i lo -p sctp -m multiport --port 1024:1035 -j SECMARK --selctx system_u:object_r:test_sctp_server_packet_t:s0
+
+iptables -t security -A INPUT -m state --state ESTABLISHED,RELATED -j CONNSECMARK --save
+
+ip6tables -t security -A INPUT -i lo -p sctp -m multiport --port 1024:1035 -j SECMARK --selctx system_u:object_r:test_sctp_server_packet_t:s0
+
+ip6tables -t security -A INPUT -m state --state ESTABLISHED,RELATED -j CONNSECMARK --save
+
+#-------------- OUTPUT IP Stream --------------------#
+# These rules will replace the above context if sctp ports 1024:1035 are found in the packets:
+iptables -t security -A OUTPUT -o lo -p sctp -m multiport --port 1024:1035 -j SECMARK --selctx system_u:object_r:test_sctp_server_packet_t:s0
+
+iptables -t security -A OUTPUT -m state --state ESTABLISHED,RELATED -j CONNSECMARK --save
+
+ip6tables -t security -A OUTPUT -o lo -p sctp -m multiport --port 1024:1035 -j SECMARK --selctx system_u:object_r:test_sctp_server_packet_t:s0
+
+ip6tables -t security -A OUTPUT -m state --state ESTABLISHED,RELATED -j CONNSECMARK --save
+
diff --git a/tests/sctp/sctp_asconf_params_client.c b/tests/sctp/sctp_asconf_params_client.c
new file mode 100644
index 0000000..2e5acdc
--- /dev/null
+++ b/tests/sctp/sctp_asconf_params_client.c
@@ -0,0 +1,298 @@
+/* This test will allow the server side to add/remove bindx addresses and
+ * inform the client side via ASCONF chunks. It will also allow the server
+ * side to inform the client that the peer primary address is being updated.
+ * The code for checking these parameters are in net/sctp/sm_make_chunk.c
+ * sctp_process_asconf_param().
+ *
+ * To enable the processing of these incoming ASCONF parameters for:
+ *      SCTP_PARAM_SET_PRIMARY, SCTP_PARAM_ADD_IP and SCTP_PARAM_DEL_IP
+ * the following options must be enabled:
+ *	echo 1 > /proc/sys/net/sctp/addip_enable
+ *	echo 1 > /proc/sys/net/sctp/addip_noauth_enable
+ *
+ * If these are not enabled the SCTP_SET_PEER_PRIMARY_ADDR setsockopt
+ * fails with EPERM "Operation not permitted", however the bindx calls
+ * will complete but the client side will not be informed.
+ *
+ * NOTES:
+ *   1) SCTP_SET_PEER_PRIMARY_ADDR requires a non-loopback IP address.
+ *   2) Both addresses used by the client/server MUST be the same type
+ *      (i.e. IPv4 or IPv6).
+ *   3) The iptables default for Fedora does not allow SCTP remote traffic.
+ *      To allow this set the following:
+ *          iptables -I INPUT 1 -p sctp -j ACCEPT
+ *          ip6tables -I INPUT 1 -p sctp -j ACCEPT
+ */
+
+#include "sctp_common.h"
+
+static void usage(char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s [-v] [-n] addr port\n"
+		"\nWhere:\n\t"
+		"-v     Print status information.\n\t"
+		"-n     No bindx_rem will be received from server. This happens\n\t"
+		"       when the client and server are on different systems.\n\t"
+		"addr   IPv4 or IPv6 address (MUST NOT be loopback address).\n\t"
+		"port   port.\n", progname);
+
+	fprintf(stderr,
+		"Notes:\n\t"
+		"1) addr and the server side new_pri_addr address MUST be\n\t"
+		"   same type (IPv4 or IPv6).\n\t"
+		"2) IPv6 link-local addresses require the %%<if_name> to\n\t"
+		"   obtain scopeid. e.g. fe80::7629:afff:fe0f:8e5d%%wlp6s0\n");
+	exit(1);
+}
+
+static int peer_count, peer_count_err;
+static void getpaddrs_alarm(int sig)
+{
+	fprintf(stderr,
+		"Get peer address count timer expired - carry on test\n");
+	peer_count += 1;
+	peer_count_err = true;
+}
+
+static void getprimaddr_alarm(int sig)
+{
+	fprintf(stderr, "Get primary address timer expired - end test.\n");
+	exit(1);
+}
+
+static void get_primaddr(char *addr_buf, int socket)
+{
+	int result;
+	struct sctp_prim prim;
+	struct sockaddr_in *in_addr;
+	struct sockaddr_in6 *in6_addr;
+	struct sockaddr *paddr;
+	socklen_t prim_len;
+	const char *addr_ptr = NULL;
+
+	memset(&prim, 0, sizeof(struct sctp_prim));
+	prim_len = sizeof(struct sctp_prim);
+
+	result = getsockopt(socket, IPPROTO_SCTP, SCTP_PRIMARY_ADDR,
+			    &prim, &prim_len);
+	if (result < 0) {
+		perror("getsockopt: SCTP_PRIMARY_ADDR");
+		exit(1);
+	}
+
+	paddr = (struct sockaddr *)&prim.ssp_addr;
+	if (paddr->sa_family == AF_INET) {
+		in_addr = (struct sockaddr_in *)&prim.ssp_addr;
+		addr_ptr = inet_ntop(AF_INET, &in_addr->sin_addr, addr_buf,
+				     INET6_ADDRSTRLEN);
+	} else if (paddr->sa_family == AF_INET6) {
+		in6_addr = (struct sockaddr_in6 *)&prim.ssp_addr;
+		addr_ptr = inet_ntop(AF_INET6, &in6_addr->sin6_addr, addr_buf,
+				     INET6_ADDRSTRLEN);
+	}
+	if (!addr_ptr) {
+		perror("inet_ntop");
+		exit(1);
+	}
+}
+
+int main(int argc, char **argv)
+{
+	int opt, client_sock, result, len;
+	struct addrinfo client_hints, *client_res;
+	struct sockaddr *paddrs;
+	bool verbose = false, no_bindx_rem = false;
+	char client_prim_addr1[INET6_ADDRSTRLEN];
+	char client_prim_addr2[INET6_ADDRSTRLEN];
+	char buffer[128];
+
+	while ((opt = getopt(argc, argv, "vn")) != -1) {
+		switch (opt) {
+		case 'v':
+			verbose = true;
+			break;
+		case 'n':
+			no_bindx_rem = true;
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
+
+	if ((argc - optind) != 2)
+		usage(argv[0]);
+
+	/* Set up client side and connect */
+	memset(&client_hints, 0, sizeof(struct addrinfo));
+	client_hints.ai_socktype = SOCK_STREAM;
+	client_hints.ai_protocol = IPPROTO_SCTP;
+	result = getaddrinfo(argv[optind], argv[optind + 1],
+			     &client_hints, &client_res);
+	if (result < 0) {
+		fprintf(stderr, "getaddrinfo - client: %s\n",
+			gai_strerror(result));
+		exit(1);
+	}
+
+
+	/* printf("Client scopeID: %d\n",
+	 *        ((struct sockaddr_in6 *)client_res->ai_addr)->sin6_scope_id);
+	 */
+
+	client_sock = socket(client_res->ai_family, client_res->ai_socktype,
+			     client_res->ai_protocol);
+	if (client_sock < 0) {
+		perror("socket");
+		exit(1);
+	}
+
+	result = connect(client_sock, client_res->ai_addr,
+			 client_res->ai_addrlen);
+	if (result < 0) {
+		if (errno != EINPROGRESS)
+			perror("connect");
+		else
+			fprintf(stderr, "connect timeout\n");
+
+		close(client_sock);
+		exit(1);
+	}
+
+	/* Get number of peer addresses on CLIENT (should be 1) for a check
+	 * later as sctp_bindx SERVER -> CLIENT is non-blocking.
+	 */
+	peer_count = sctp_getpaddrs(client_sock, 0, &paddrs);
+	sctp_freepaddrs(paddrs);
+	len = sprintf(buffer, "Client peer address count: %d", peer_count);
+	if (verbose)
+		printf("%s\n", buffer);
+
+
+	/* Get initial CLIENT primary address (that should be ADDR1). */
+	get_primaddr(client_prim_addr1, client_sock);
+
+	/* server waiting for write before sending BINDX_ADD */
+	result = write(client_sock, buffer, len);
+	if (result < 0) {
+		perror("write");
+		close(client_sock);
+		exit(1);
+	}
+
+	/* Sleep a while as server pings us the new address */
+	sleep(1);
+	/* then set an alarm and check number of peer addresses for CLIENT */
+	signal(SIGALRM, getpaddrs_alarm);
+	alarm(2);
+	peer_count_err = false;
+	result = 0;
+
+	while (result != peer_count + 1) {
+		result = sctp_getpaddrs(client_sock, 0, &paddrs);
+		if (result > 0)
+			sctp_freepaddrs(paddrs);
+
+		if (peer_count_err)
+			break;
+	}
+	alarm(0);
+	peer_count = result;
+
+	len = sprintf(buffer, "Client peer address count: %d", result);
+	if (verbose)
+		printf("%s\n", buffer);
+
+	/* server waiting for write before send SCTP_SET_PEER_PRIMARY_ADDR */
+	result = write(client_sock, buffer, len);
+	if (result < 0) {
+		perror("write");
+		close(client_sock);
+		exit(1);
+	}
+
+	/* Now get the new primary address from the client */
+	signal(SIGALRM, getprimaddr_alarm);
+	alarm(2);
+	memcpy(client_prim_addr2, client_prim_addr1, INET6_ADDRSTRLEN);
+
+	while (!strcmp(client_prim_addr1, client_prim_addr2))
+		get_primaddr(client_prim_addr2, client_sock);
+
+	alarm(0);
+	len = sprintf(buffer,
+		      "Client initial SCTP_PRIMARY_ADDR: %s\nClient current SCTP_PRIMARY_ADDR: %s",
+		      client_prim_addr1, client_prim_addr2);
+	if (verbose)
+		printf("%s\n", buffer);
+
+	if (!no_bindx_rem) {
+		/* Let server send bindx_rem */
+		result = write(client_sock, buffer, len);
+		if (result < 0) {
+			perror("write");
+			close(client_sock);
+			exit(1);
+		}
+
+		/* Then delete addr that checks ASCONF - SCTP_PARAM_DEL_IP */
+		if (!peer_count_err) {
+			signal(SIGALRM, getprimaddr_alarm);
+			alarm(2);
+			result = 0;
+			while (result != peer_count - 1) {
+				result = sctp_getpaddrs(client_sock,
+							0, &paddrs);
+				if (result > 0)
+					sctp_freepaddrs(paddrs);
+
+				if (peer_count_err)
+					break;
+			}
+			alarm(0);
+			sprintf(buffer, "Client peer address count: %d",
+				result);
+			if (verbose)
+				printf("%s\n", buffer);
+		}
+	}
+
+	/* server waiting for client peer address count */
+	result = write(client_sock, buffer, len);
+	if (result < 0) {
+		perror("write");
+		close(client_sock);
+		exit(1);
+	}
+
+	/* Compare the client primary addresses, they should be different. */
+	if (!strcmp(client_prim_addr1, client_prim_addr2)) {
+		len = sprintf(buffer,
+			      "Client ADDR1: %s same as ADDR2: %s - SCTP_SET_PEER_PRIMARY_ADDR failed",
+			      client_prim_addr1, client_prim_addr2);
+		fprintf(stderr, "%s\n", buffer);
+
+		/* server waiting for write to finish */
+		result = write(client_sock, buffer, len);
+		if (result < 0) {
+			perror("write");
+			close(client_sock);
+		}
+		exit(1);
+	}
+
+	len = sprintf(buffer, "Client primary address changed successfully\n");
+	if (verbose)
+		printf("%s\n", buffer);
+
+	/* server waiting for write to finish */
+	result = write(client_sock, buffer, len);
+	if (result < 0) {
+		perror("write");
+		close(client_sock);
+		exit(1);
+	}
+
+	close(client_sock);
+	exit(0);
+}
diff --git a/tests/sctp/sctp_asconf_params_server.c b/tests/sctp/sctp_asconf_params_server.c
new file mode 100644
index 0000000..f710097
--- /dev/null
+++ b/tests/sctp/sctp_asconf_params_server.c
@@ -0,0 +1,236 @@
+#include "sctp_common.h"
+
+static void usage(char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s -v addr new_pri_addr port\n"
+		"\nWhere:\n\t"
+		"-v           Print status information.\n\t"
+		"addr         IPv4/IPv6 address for initial connection.\n\t"
+		"new_pri_addr IPv4/IPv6 address that the server will bindx\n\t"
+		"             then set to the new SCTP_PRIMARY_ADDR.\n\t"
+		"port         port.\n", progname);
+	fprintf(stderr,
+		"Notes:\n\t"
+		"1) addr and new_pri_addr MUST NOT be loopback addresses.\n\t"
+		"2) addr and new_pri_addr MUST be same type (IPv4 or IPv6).\n\t"
+		"3) IPv6 link-local addresses require the %%<if_name> to\n\t"
+		"   obtain scopeid. e.g. fe80::7629:afff:fe0f:8e5d%%wlp6s0\n");
+	exit(1);
+}
+
+int main(int argc, char **argv)
+{
+	int opt, srv_sock, new_sock, result, on = 1;
+	struct addrinfo srv_hints, *srv_res;
+	struct addrinfo *new_pri_addr_res;
+	struct sockaddr *sa_ptr;
+	socklen_t sinlen;
+	struct sockaddr_storage sin;
+	struct sctp_setpeerprim setpeerprim;
+	bool verbose = false, is_ipv6 = false;
+	char buffer[128];
+
+	while ((opt = getopt(argc, argv, "v")) != -1) {
+		switch (opt) {
+		case 'v':
+			verbose = true;
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
+
+	if ((argc - optind) != 3)
+		usage(argv[0]);
+
+	if (strchr(argv[optind], ':') && strchr(argv[optind + 1], ':')) {
+		is_ipv6 = true;
+		srv_hints.ai_family = AF_INET6;
+	} else if (strchr(argv[optind], '.') &&
+		   strchr(argv[optind + 1], '.')) {
+		is_ipv6 = false;
+		srv_hints.ai_family = AF_INET;
+	} else {
+		usage(argv[0]);
+	}
+
+	memset(&srv_hints, 0, sizeof(struct addrinfo));
+	srv_hints.ai_flags = AI_PASSIVE;
+	srv_hints.ai_socktype = SOCK_STREAM;
+	srv_hints.ai_protocol = IPPROTO_SCTP;
+
+	/* Set up server side */
+	result = getaddrinfo(argv[optind], argv[optind + 2],
+			     &srv_hints, &srv_res);
+	if (result < 0) {
+		fprintf(stderr, "getaddrinfo - server: %s\n",
+			gai_strerror(result));
+		exit(1);
+	}
+	if (is_ipv6 && verbose)
+		printf("Server scopeID: %d\n",
+		       ((struct sockaddr_in6 *)
+			srv_res->ai_addr)->sin6_scope_id);
+
+	srv_sock = socket(srv_res->ai_family, srv_res->ai_socktype,
+			  srv_res->ai_protocol);
+	if (srv_sock < 0) {
+		perror("socket - server");
+		exit(1);
+	}
+
+	result = setsockopt(srv_sock, SOL_SOCKET, SO_REUSEADDR, &on,
+			    sizeof(on));
+	if (result < 0) {
+		perror("setsockopt: SO_REUSEADDR");
+		close(srv_sock);
+		exit(1);
+	}
+
+	result = bind(srv_sock, srv_res->ai_addr, srv_res->ai_addrlen);
+	if (result < 0) {
+		perror("bind");
+		close(srv_sock);
+		exit(1);
+	}
+
+	listen(srv_sock, 1);
+
+	new_sock = accept(srv_sock, (struct sockaddr *)&sin, &sinlen);
+	if (new_sock < 0) {
+		perror("accept");
+		result = 1;
+		goto err2;
+	}
+
+	/* This waits for a client message before continuing. */
+	result = read(new_sock, &buffer, sizeof(buffer));
+	if (result < 0) {
+		perror("read");
+		exit(1);
+	}
+	buffer[result] = 0;
+	if (verbose)
+		printf("%s\n", buffer);
+
+	/* Obtain address info for the BINDX_ADD and new SCTP_PRIMARY_ADDR. */
+	result = getaddrinfo(argv[optind + 1], argv[optind + 2],
+			     &srv_hints, &new_pri_addr_res);
+	if (result < 0) {
+		fprintf(stderr, "getaddrinfo - new SCTP_PRIMARY_ADDR: %s\n",
+			gai_strerror(result));
+		close(srv_sock);
+		exit(1);
+	}
+	if (is_ipv6 && verbose)
+		printf("new_pri_addr scopeID: %d\n",
+		       ((struct sockaddr_in6 *)
+			new_pri_addr_res->ai_addr)->sin6_scope_id);
+
+
+	/* Now call sctp_bindx to add ADDR2, this will cause an
+	 * ASCONF - SCTP_PARAM_ADD_IP chunk to be sent to the CLIENT.
+	 * This is non-blocking so there maybe a delay before the CLIENT
+	 * receives the asconf chunk.
+	 */
+	if (verbose)
+		printf("Calling sctp_bindx ADD: %s\n", argv[optind + 1]);
+
+	result = sctp_bindx(new_sock,
+			    (struct sockaddr *)new_pri_addr_res->ai_addr,
+			    1, SCTP_BINDX_ADD_ADDR);
+	if (result < 0) {
+		if (errno == EACCES) {
+			perror("sctp_bindx ADD");
+		} else {
+			perror("sctp_bindx ADD");
+			result = 1;
+			goto err1;
+		}
+	}
+
+	/* This waits for a client message before continuing. */
+	result = read(new_sock, &buffer, sizeof(buffer));
+	if (result < 0) {
+		perror("read");
+		exit(1);
+	}
+	buffer[result] = 0;
+	if (verbose)
+		printf("%s\n", buffer);
+
+	/* Now that the CLIENT has the new primary address ensure they use
+	 * it by SCTP_SET_PEER_PRIMARY_ADDR.
+	 */
+	memset(&setpeerprim, 0, sizeof(struct sctp_setpeerprim));
+	sa_ptr = (struct sockaddr *)&setpeerprim.sspp_addr;
+	if (is_ipv6)
+		memcpy(sa_ptr, new_pri_addr_res->ai_addr,
+		       sizeof(struct sockaddr_in6));
+	else
+		memcpy(sa_ptr, new_pri_addr_res->ai_addr,
+		       sizeof(struct sockaddr_in));
+
+	if (verbose)
+		printf("Calling setsockopt SCTP_SET_PEER_PRIMARY_ADDR: %s\n",
+		       argv[optind + 1]);
+
+	result = setsockopt(new_sock, IPPROTO_SCTP,
+			    SCTP_SET_PEER_PRIMARY_ADDR,
+			    &setpeerprim, sizeof(struct sctp_setpeerprim));
+	if (result < 0) {
+		perror("setsockopt: SCTP_SET_PEER_PRIMARY_ADDR");
+		result = 1;
+		goto err1;
+	}
+	/* Sleep a sec to ensure client get info. */
+	result = read(new_sock, &buffer, sizeof(buffer));
+	if (result < 0) {
+		perror("read");
+		exit(1);
+	}
+	buffer[result] = 0;
+	if (verbose)
+		printf("%s\n", buffer);
+
+	/* Then delete addr that checks ASCONF - SCTP_PARAM_DEL_IP. */
+	if (verbose)
+		printf("Calling sctp_bindx REM: %s\n", argv[optind]);
+
+	result = sctp_bindx(new_sock, (struct sockaddr *)srv_res->ai_addr,
+			    1, SCTP_BINDX_REM_ADDR);
+	if (result < 0) {
+		perror("sctp_bindx - REM");
+		result = 1;
+		goto err1;
+	}
+
+	result = read(new_sock, &buffer, sizeof(buffer));
+	if (result <= 0) {
+		if (errno != 0)
+			perror("read");
+		result = 1;
+		goto err1;
+	}
+	buffer[result] = 0;
+	if (verbose)
+		printf("%s\n", buffer);
+
+	result = read(new_sock, &buffer, sizeof(buffer));
+	if (result < 0) {
+		perror("read");
+		exit(1);
+	}
+	buffer[result] = 0;
+	if (verbose)
+		printf("%s\n", buffer);
+
+	result = 0;
+
+err1:
+	close(new_sock);
+err2:
+	close(srv_sock);
+	exit(result);
+}
diff --git a/tests/sctp/sctp_bind.c b/tests/sctp/sctp_bind.c
new file mode 100644
index 0000000..5ff00cc
--- /dev/null
+++ b/tests/sctp/sctp_bind.c
@@ -0,0 +1,61 @@
+#include "sctp_common.h"
+
+static void usage(char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s stream|seq port\n"
+		"\nWhere:\n\t"
+		"stream  Use SCTP 1-to-1 style or:\n\t"
+		"seq     use SCTP 1-to-Many style.\n\t"
+		"port    Listening port.\n", progname);
+	exit(1);
+}
+
+int main(int argc, char **argv)
+{
+	int sock, result, on = 1;
+	struct addrinfo hints, *res;
+
+	if (argc != 3)
+		usage(argv[0]);
+
+	memset(&hints, 0, sizeof(struct addrinfo));
+	hints.ai_flags = AI_PASSIVE;
+	hints.ai_protocol = IPPROTO_SCTP;
+
+	if (!strcmp(argv[1], "stream"))
+		hints.ai_socktype = SOCK_STREAM;
+	else if (!strcmp(argv[1], "seq"))
+		hints.ai_socktype = SOCK_SEQPACKET;
+	else
+		usage(argv[0]);
+
+	result = getaddrinfo(NULL, argv[2], &hints, &res);
+	if (result < 0) {
+		printf("getaddrinfo: %s\n", gai_strerror(result));
+		exit(1);
+	}
+
+	sock = socket(res->ai_family, res->ai_socktype, res->ai_protocol);
+	if (sock < 0) {
+		perror("socket");
+		exit(1);
+	}
+
+	result = setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &on, sizeof(on));
+	if (result < 0) {
+		perror("setsockopt: SO_REUSEADDR");
+		close(sock);
+		exit(1);
+	}
+
+	result = bind(sock, res->ai_addr, res->ai_addrlen);
+	if (result < 0) {
+		perror("bind");
+		close(sock);
+		exit(1);
+	}
+
+	close(sock);
+	exit(0);
+}
diff --git a/tests/sctp/sctp_bindx.c b/tests/sctp/sctp_bindx.c
new file mode 100644
index 0000000..7634bab
--- /dev/null
+++ b/tests/sctp/sctp_bindx.c
@@ -0,0 +1,116 @@
+#include "sctp_common.h"
+
+static void usage(char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s [-r] [-v] stream|seq port\n"
+		"\nWhere:\n\t"
+		"-r      After two bindx ADDs, remove one with bindx REM.\n\t"
+		"-v      Print context information.\n\t"
+		"        The default is to add IPv4 and IPv6 loopback addrs.\n\t"
+		"stream  Use SCTP 1-to-1 style or:\n\t"
+		"seq     use SCTP 1-to-Many style.\n\t"
+		"port    port.\n", progname);
+	exit(1);
+}
+
+int main(int argc, char **argv)
+{
+	int opt, type, sock, result;
+	struct sockaddr_in ipv4;
+	struct sockaddr_in6 ipv6;
+	unsigned short port;
+	bool rem = false;
+	bool verbose = false;
+	char *context;
+
+	while ((opt = getopt(argc, argv, "rv")) != -1) {
+		switch (opt) {
+		case 'v':
+			verbose = true;
+			break;
+		case 'r':
+			rem = true;
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
+
+	if ((argc - optind) != 2)
+		usage(argv[0]);
+
+	if (!strcmp(argv[optind], "stream"))
+		type = SOCK_STREAM;
+	else if (!strcmp(argv[optind], "seq"))
+		type = SOCK_SEQPACKET;
+	else
+		usage(argv[0]);
+
+	port = atoi(argv[optind + 1]);
+	if (!port)
+		usage(argv[0]);
+
+	if (verbose) {
+		if (getcon(&context) < 0)
+			context = strdup("unavailable");
+		printf("Process context: %s\n", context);
+		free(context);
+	}
+
+	sock = socket(PF_INET6, type, IPPROTO_SCTP);
+	if (sock < 0) {
+		perror("socket");
+		exit(1);
+	}
+
+	if (verbose)
+		print_context(sock, "Server");
+
+	memset(&ipv4, 0, sizeof(struct sockaddr_in));
+	ipv4.sin_family = AF_INET;
+	ipv4.sin_port = htons(port);
+	ipv4.sin_addr.s_addr = htonl(0x7f000001);
+
+	result = sctp_bindx(sock, (struct sockaddr *)&ipv4, 1,
+			    SCTP_BINDX_ADD_ADDR);
+	if (result < 0) {
+		perror("sctp_bindx ADD - ipv4");
+		close(sock);
+		exit(1);
+	}
+
+	if (verbose)
+		printf("sctp_bindx ADD - ipv4\n");
+
+	memset(&ipv6, 0, sizeof(struct sockaddr_in6));
+	ipv6.sin6_family = AF_INET6;
+	ipv6.sin6_port = htons(port);
+	ipv6.sin6_addr = in6addr_loopback;
+
+	result = sctp_bindx(sock, (struct sockaddr *)&ipv6, 1,
+			    SCTP_BINDX_ADD_ADDR);
+	if (result < 0) {
+		perror("sctp_bindx ADD - ipv6");
+		close(sock);
+		exit(1);
+	}
+
+	if (verbose)
+		printf("sctp_bindx ADD - ipv6\n");
+
+	if (rem) {
+		result = sctp_bindx(sock, (struct sockaddr *)&ipv6, 1,
+				    SCTP_BINDX_REM_ADDR);
+		if (result < 0) {
+			perror("sctp_bindx - REM");
+			close(sock);
+			exit(1);
+		}
+		if (verbose)
+			printf("sctp_bindx REM - ipv6\n");
+	}
+
+	close(sock);
+	exit(0);
+}
diff --git a/tests/sctp/sctp_client.c b/tests/sctp/sctp_client.c
new file mode 100644
index 0000000..595da75
--- /dev/null
+++ b/tests/sctp/sctp_client.c
@@ -0,0 +1,220 @@
+#include "sctp_common.h"
+
+static void usage(char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s [-e expected_msg] [-v] [-n] [-x] stream|seq addr port\n"
+		"\nWhere:\n\t"
+
+		"-e      Optional expected message from server e.g. \"nopeer\".\n\t"
+		"        If not present the client context will be used as a\n\t"
+		"        comparison with the servers reply.\n\t"
+		"-n      Do NOT call connect(3) or connectx(3).\n\t"
+		"-v      Print context and ip options information.\n\t"
+		"-x      Use sctp_connectx(3) instead of connect(3).\n\t"
+		"stream  Use SCTP 1-to-1 style or:\n\t"
+		"seq     use SCTP 1-to-Many style.\n\t"
+		"addr    IPv4 or IPv6 address (e.g. 127.0.0.1 or ::1).\n\t"
+		"port    Port for accessing server.\n", progname);
+	exit(1);
+}
+
+int main(int argc, char **argv)
+{
+	int opt, sock, result, save_errno;
+	socklen_t opt_len;
+	struct addrinfo hints, *serverinfo;
+	char byte = 0x41, label[1024], *expected = NULL;
+	bool verbose = false, connectx = false, no_connects = false;
+	bool ipv4 = false, expect_ipopt = false;
+	char *context;
+	struct timeval tm;
+
+	while ((opt = getopt(argc, argv, "e:vxmni")) != -1) {
+		switch (opt) {
+		case 'e':
+			expected = optarg;
+			break;
+		case 'i':
+			expect_ipopt = true;
+			break;
+		case 'v':
+			verbose = true;
+			break;
+		case 'n':
+			no_connects = true;
+			break;
+		case 'x':
+			connectx = true;
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
+
+	if ((argc - optind) != 3)
+		usage(argv[0]);
+
+	memset(&hints, 0, sizeof(struct addrinfo));
+	hints.ai_protocol = IPPROTO_SCTP;
+
+	if (!strcmp(argv[optind], "stream"))
+		hints.ai_socktype = SOCK_STREAM;
+	else if (!strcmp(argv[optind], "seq"))
+		hints.ai_socktype = SOCK_SEQPACKET;
+	else
+		usage(argv[0]);
+
+	if (verbose) {
+		if (getcon(&context) < 0)
+			context = strdup("unavailable");
+		printf("Client process context: %s\n", context);
+		free(context);
+	}
+
+	result = getaddrinfo(argv[optind + 1], argv[optind + 2], &hints,
+			     &serverinfo);
+	if (result < 0) {
+		fprintf(stderr, "Client getaddrinfo: %s\n",
+			gai_strerror(result));
+		exit(2);
+	}
+
+	if (serverinfo->ai_family == AF_INET)
+		ipv4 = true;
+
+	sock = socket(serverinfo->ai_family, serverinfo->ai_socktype,
+		      serverinfo->ai_protocol);
+	if (sock < 0) {
+		perror("Client socket");
+		exit(3);
+	}
+
+	/*
+	 * These timeouts are set to test whether the peer { recv } completes
+	 * or not when the permission is denied. These errors will be
+	 * returned during testing:
+	 *    EINPROGRESS - Operation now in progress - SOCK_STREAM
+	 *        Uses SO_SNDTIMEO when using connect(2) or sctp_connectx(3)
+	 *    EAGAIN - Resource temporarily unavailable - SOCK_SEQPACKET
+	 *        Uses SO_RCVTIMEO when NO connects are called.
+	 */
+	tm.tv_sec = 2;
+	tm.tv_usec = 0;
+	result = setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO, &tm, sizeof(tm));
+	if (result < 0) {
+		perror("Client setsockopt: SO_SNDTIMEO");
+		exit(4);
+	}
+
+	result = setsockopt(sock, SOL_SOCKET, SO_RCVTIMEO, &tm, sizeof(tm));
+	if (result < 0) {
+		perror("Client setsockopt: SO_RCVTIMEO");
+		exit(5);
+	}
+
+	if (!no_connects) {
+		if (connectx)
+			result = sctp_connectx(sock, serverinfo->ai_addr,
+					       1, NULL);
+		else
+			result = connect(sock, serverinfo->ai_addr,
+					 serverinfo->ai_addrlen);
+		if (result < 0) {
+			save_errno = errno;
+			close(sock);
+			perror("Client connect");
+			switch (save_errno) {
+			case EINPROGRESS:
+				exit(6);
+				break;
+			case ENOSPC:
+				exit(7);
+				break;
+			case EACCES:
+				exit(8);
+				break;
+			default:
+				exit(9);
+			}
+		}
+		if (verbose) {
+			print_context(sock, "Client connect");
+			print_ip_option(sock, ipv4, "Client connect");
+		}
+	}
+
+	if (hints.ai_socktype == SOCK_STREAM) {
+
+		result = write(sock, &byte, 1);
+		if (result < 0) {
+			perror("Client write");
+			close(sock);
+			exit(10);
+		}
+		if (verbose)
+			print_context(sock, "Client STREAM write");
+
+		result = read(sock, label, sizeof(label));
+		if (result < 0) {
+			perror("Client read");
+			close(sock);
+			exit(11);
+		}
+		if (verbose) {
+			print_context(sock, "Client STREAM read");
+			print_ip_option(sock, ipv4, "Client STREAM read");
+		}
+		if (expect_ipopt)
+			expected = get_ip_option(sock, ipv4, &opt_len);
+
+	} else { /* hints.ai_socktype == SOCK_SEQPACKET */
+
+		result = sctp_sendmsg(sock, &byte, 1,
+				      serverinfo->ai_addr,
+				      serverinfo->ai_addrlen,
+				      0, 0, 0, 0, 0);
+		if (result < 0) {
+			perror("Client sctp_sendmsg");
+			close(sock);
+			exit(12);
+		}
+
+		if (verbose) {
+			print_context(sock, "Client SEQPACKET sctp_sendmsg");
+			print_ip_option(sock, ipv4,
+					"Client SEQPACKET sctp_sendmsg");
+		}
+
+		result = sctp_recvmsg(sock, label, sizeof(label),
+				      NULL, 0, NULL, NULL);
+		if (result < 0) {
+			perror("Client sctp_recvmsg");
+			close(sock);
+			exit(13);
+		}
+		if (expect_ipopt)
+			expected = get_ip_option(sock, ipv4, &opt_len);
+	}
+
+	label[result] = 0;
+	close(sock);
+
+	if (!expected && !expect_ipopt) {
+		result = getcon(&expected);
+		if (result < 0) {
+			perror("Client getcon");
+			exit(14);
+		}
+	}
+
+	if (strcmp(expected, label)) {
+		fprintf(stderr, "Client expected %s, got %s\n",
+			expected, label);
+		exit(15);
+	} else if (verbose) {
+		printf("Client received %s\n", label);
+	}
+
+	exit(0);
+}
diff --git a/tests/sctp/sctp_common.c b/tests/sctp/sctp_common.c
new file mode 100644
index 0000000..100ab22
--- /dev/null
+++ b/tests/sctp/sctp_common.c
@@ -0,0 +1,101 @@
+#include "sctp_common.h"
+
+void print_context(int fd, char *text)
+{
+	char *context;
+
+	if (fgetfilecon(fd, &context) < 0)
+		context = strdup("unavailable");
+	printf("%s fd context: %s\n", text, context);
+	free(context);
+
+	if (getpeercon(fd, &context) < 0)
+		context = strdup("unavailable");
+	printf("%s peer context: %s\n", text, context);
+	free(context);
+}
+
+void print_addr_info(struct sockaddr *sin, char *text)
+{
+	struct sockaddr_in *addr4;
+	struct sockaddr_in6 *addr6;
+	char addr_str[INET6_ADDRSTRLEN + 1];
+
+	switch (sin->sa_family) {
+	case AF_INET:
+		addr4 = (struct sockaddr_in *)sin;
+		inet_ntop(sin->sa_family,
+			  (void *)&addr4->sin_addr,
+			  addr_str, INET6_ADDRSTRLEN + 1);
+		printf("%s IPv4 addr %s\n", text, addr_str);
+		break;
+	case AF_INET6:
+		addr6 = (struct sockaddr_in6 *)sin;
+		if (IN6_IS_ADDR_V4MAPPED(&addr6->sin6_addr)) {
+			inet_ntop(AF_INET,
+				  (void *)&addr6->sin6_addr.s6_addr32[3],
+				  addr_str, INET6_ADDRSTRLEN + 1);
+			printf("%s IPv6->IPv4 MAPPED addr %s\n",
+			       text, addr_str);
+		} else {
+			inet_ntop(sin->sa_family,
+				  (void *)&addr6->sin6_addr,
+				  addr_str, INET6_ADDRSTRLEN + 1);
+			printf("%s IPv6 addr %s\n", text,
+			       addr_str);
+		}
+		break;
+	}
+}
+
+char *get_ip_option(int fd, bool ipv4, socklen_t *opt_len)
+{
+	int result, i;
+	unsigned char ip_options[1024];
+	socklen_t len = sizeof(ip_options);
+	char *ip_optbuf;
+
+	if (ipv4)
+		result = getsockopt(fd, IPPROTO_IP, IP_OPTIONS,
+				    ip_options, &len);
+	else
+		result = getsockopt(fd, IPPROTO_IPV6, IPV6_HOPOPTS,
+				    ip_options, &len);
+
+	if (result < 0) {
+		perror("get ip options error");
+		return NULL;
+	}
+
+	ip_optbuf = calloc(1, len * 2 + 1);
+	if (!ip_optbuf) {
+		perror("get ip options malloc error");
+		return NULL;
+	}
+
+	if (len > 0) {
+		for (i = 0; i < len; i++)
+			sprintf(&ip_optbuf[i * 2], "%02x", ip_options[i]);
+
+		*opt_len = len;
+		return ip_optbuf;
+	}
+
+	return NULL;
+}
+
+void print_ip_option(int fd, bool ipv4, char *text)
+{
+	char *ip_options;
+	socklen_t len;
+
+	ip_options = get_ip_option(fd, ipv4, &len);
+
+	if (ip_options) {
+		printf("%s IP Options Family: %s Length: %d\n\tEntry: %s\n",
+		       text, ipv4 ? "IPv4" : "IPv6", len, ip_options);
+		free(ip_options);
+	} else {
+		printf("%s No IP Options set\n", text);
+	}
+}
diff --git a/tests/sctp/sctp_common.h b/tests/sctp/sctp_common.h
new file mode 100644
index 0000000..d5c1397
--- /dev/null
+++ b/tests/sctp/sctp_common.h
@@ -0,0 +1,27 @@
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE /* For poll(2) POLLRDHUP - Detect client close(2) */
+#endif
+
+#include <arpa/inet.h>
+#include <sys/poll.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <net/if.h>
+#include <netdb.h>
+#include <netinet/in.h>
+#include <netinet/ip.h>
+#include <netinet/sctp.h>
+#include <stdlib.h>
+#include <stddef.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <stdbool.h>
+#include <errno.h>
+#include <signal.h>
+#include <selinux/selinux.h>
+
+void print_context(int fd, char *text);
+void print_addr_info(struct sockaddr *sin, char *text);
+char *get_ip_option(int fd, bool ipv4, socklen_t *opt_len);
+void print_ip_option(int fd, bool ipv4, char *text);
diff --git a/tests/sctp/sctp_connectx.c b/tests/sctp/sctp_connectx.c
new file mode 100644
index 0000000..18d133d
--- /dev/null
+++ b/tests/sctp/sctp_connectx.c
@@ -0,0 +1,124 @@
+#include "sctp_common.h"
+
+static void usage(char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s [-v] stream|seq addr port\n"
+		"\nWhere:\n\t"
+		"-v      Print context information.\n\t"
+		"stream  Use SCTP 1-to-1 style or:\n\t"
+		"seq     use SCTP 1-to-Many style.\n\t"
+		"addr    Servers IPv4 or IPv6 address.\n\t"
+		"port    port.\n", progname);
+	exit(1);
+}
+
+int main(int argc, char **argv)
+{
+	int opt, type, srv_sock, client_sock, result, on = 1;
+	struct addrinfo srv_hints, client_hints, *srv_res, *client_res;
+	bool verbose = false;
+	char *context;
+
+	while ((opt = getopt(argc, argv, "v")) != -1) {
+		switch (opt) {
+		case 'v':
+			verbose = true;
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
+
+	if ((argc - optind) != 3)
+		usage(argv[0]);
+
+	if (!strcmp(argv[optind], "stream"))
+		type = SOCK_STREAM;
+	else if (!strcmp(argv[optind], "seq"))
+		type = SOCK_SEQPACKET;
+	else
+		usage(argv[0]);
+
+	if (verbose) {
+		if (getcon(&context) < 0)
+			context = strdup("unavailable");
+		printf("Process context: %s\n", context);
+		free(context);
+	}
+
+	memset(&srv_hints, 0, sizeof(struct addrinfo));
+	srv_hints.ai_flags = AI_PASSIVE;
+	srv_hints.ai_family = AF_INET6;
+
+	srv_hints.ai_socktype = type;
+	srv_hints.ai_protocol = IPPROTO_SCTP;
+
+	/* Set up server side */
+	result = getaddrinfo(NULL, argv[optind + 2], &srv_hints, &srv_res);
+	if (result < 0) {
+		printf("getaddrinfo - server: %s\n", gai_strerror(result));
+		exit(1);
+	}
+
+	srv_sock = socket(srv_res->ai_family, srv_res->ai_socktype,
+			  srv_res->ai_protocol);
+	if (srv_sock < 0) {
+		perror("socket - server");
+		exit(1);
+	}
+
+	if (verbose)
+		print_context(srv_sock, "Server");
+
+	result = setsockopt(srv_sock, SOL_SOCKET, SO_REUSEADDR, &on,
+			    sizeof(on));
+	if (result < 0) {
+		perror("setsockopt: SO_REUSEADDR");
+		close(srv_sock);
+		exit(1);
+	}
+
+	result = bind(srv_sock, srv_res->ai_addr, srv_res->ai_addrlen);
+	if (result < 0) {
+		perror("bind");
+		close(srv_sock);
+		exit(1);
+	}
+
+	listen(srv_sock, 1);
+
+	/* Set up client side */
+	memset(&client_hints, 0, sizeof(struct addrinfo));
+	client_hints.ai_socktype = type;
+	client_hints.ai_protocol = IPPROTO_SCTP;
+	result = getaddrinfo(argv[optind + 1], argv[optind + 2],
+			     &client_hints, &client_res);
+	if (result < 0) {
+		fprintf(stderr, "getaddrinfo - client: %s\n",
+			gai_strerror(result));
+		exit(1);
+	}
+
+	client_sock = socket(client_res->ai_family, client_res->ai_socktype,
+			     client_res->ai_protocol);
+	if (client_sock < 0) {
+		perror("socket - client");
+		exit(1);
+	}
+
+	if (verbose)
+		print_context(client_sock, "Client");
+
+	result = sctp_connectx(client_sock, client_res->ai_addr, 1, NULL);
+	if (result < 0) {
+		perror("connectx");
+		close(srv_sock);
+		close(client_sock);
+		exit(1);
+	}
+
+	close(srv_sock);
+	close(client_sock);
+	exit(0);
+}
diff --git a/tests/sctp/sctp_peeloff_server.c b/tests/sctp/sctp_peeloff_server.c
new file mode 100644
index 0000000..eb198af
--- /dev/null
+++ b/tests/sctp/sctp_peeloff_server.c
@@ -0,0 +1,260 @@
+#include "sctp_common.h"
+
+static void usage(char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s [-4] [-i] [-n] [-v] port\n"
+		"\nWhere:\n\t"
+		"-4      Listen on IPv4 addresses only.\n\t"
+		"-i      Send IP Options as msg (default is peer label).\n\t"
+		"-n      No peer context will be available therefore send\n\t"
+		"        \"nopeer\" message to client, otherwise the peer context\n\t"
+		"        will be retrieved and sent to client.\n\t"
+		"-v      Print context and ip options information.\n\t"
+		"port    Listening port.\n", progname);
+	exit(1);
+}
+
+static void set_subscr_events(int fd, int value)
+{
+	int result;
+	struct sctp_event_subscribe subscr_events;
+
+	memset(&subscr_events, 0, sizeof(subscr_events));
+	subscr_events.sctp_association_event = value;
+	/* subscr_events.sctp_data_io_event = value; */
+
+	result = setsockopt(fd, IPPROTO_SCTP, SCTP_EVENTS,
+			    &subscr_events, sizeof(subscr_events));
+	if (result < 0) {
+		perror("Server setsockopt: SCTP_EVENTS");
+		close(fd);
+		exit(1);
+	}
+}
+
+static sctp_assoc_t handle_event(void *buf)
+{
+	union sctp_notification *snp = buf;
+	struct sctp_assoc_change *sac;
+
+	switch (snp->sn_header.sn_type) {
+	case SCTP_ASSOC_CHANGE:
+		sac = &snp->sn_assoc_change;
+		return sac->sac_assoc_id;
+	case SCTP_PEER_ADDR_CHANGE:
+	case SCTP_SEND_FAILED:
+	case SCTP_REMOTE_ERROR:
+	case SCTP_SHUTDOWN_EVENT:
+	case SCTP_PARTIAL_DELIVERY_EVENT:
+	case SCTP_ADAPTATION_INDICATION:
+	case SCTP_AUTHENTICATION_INDICATION:
+	case SCTP_SENDER_DRY_EVENT:
+		printf("Unrequested event: %x\n", snp->sn_header.sn_type);
+		break;
+	default:
+		printf("Unknown event: %x\n", snp->sn_header.sn_type);
+		break;
+	}
+	return -1;
+}
+
+int main(int argc, char **argv)
+{
+	int opt, sock, result, peeloff_sk = 0, flags, on = 1;
+	sctp_assoc_t assoc_id;
+	socklen_t sinlen, opt_len;
+	struct sockaddr_storage sin;
+	struct addrinfo hints, *res;
+	char *peerlabel, *context, msglabel[256];
+	bool nopeer = false,  verbose = false, ipv4 = false, snd_opt = false;
+	unsigned short port;
+
+	while ((opt = getopt(argc, argv, "4inv")) != -1) {
+		switch (opt) {
+		case '4':
+			ipv4 = true;
+			break;
+		case 'i':
+			snd_opt = true;
+			break;
+		case 'n':
+			nopeer = true;
+			break;
+		case 'v':
+			verbose = true;
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
+
+	if ((argc - optind) != 1)
+		usage(argv[0]);
+
+	port = atoi(argv[optind]);
+	if (!port)
+		usage(argv[0]);
+
+	memset(&hints, 0, sizeof(struct addrinfo));
+	hints.ai_flags = AI_PASSIVE;
+	hints.ai_protocol = IPPROTO_SCTP;
+
+	if (ipv4)
+		hints.ai_family = AF_INET;
+	else
+		hints.ai_family = AF_INET6;
+
+	/* sctp_peeloff(3) must be from 1 to Many style socket */
+	hints.ai_socktype = SOCK_SEQPACKET;
+
+	if (verbose) {
+		if (getcon(&context) < 0)
+			context = strdup("unavailable");
+		printf("Server process context: %s\n", context);
+		free(context);
+	}
+
+	result = getaddrinfo(NULL, argv[optind], &hints, &res);
+	if (result < 0) {
+		fprintf(stderr, "Server getaddrinfo: %s\n",
+			gai_strerror(result));
+		exit(1);
+	}
+
+	sock = socket(res->ai_family, res->ai_socktype, res->ai_protocol);
+	if (sock < 0) {
+		perror("Server socket");
+		exit(1);
+	}
+
+	result = setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &on, sizeof(on));
+	if (result < 0) {
+		perror("Server setsockopt: SO_REUSEADDR");
+		close(sock);
+		exit(1);
+	}
+
+	result = bind(sock, res->ai_addr, res->ai_addrlen);
+	if (result < 0) {
+		perror("Server bind");
+		close(sock);
+		exit(1);
+	}
+
+	if (verbose)
+		print_context(sock, "Server LISTEN sock");
+
+	if (listen(sock, SOMAXCONN)) {
+		perror("Server listen");
+		close(sock);
+		exit(1);
+	}
+
+	do {
+		set_subscr_events(sock, 1); /* Get assoc_id for sctp_peeloff() */
+		sinlen = sizeof(sin);
+		flags = 0;
+
+		result = sctp_recvmsg(sock, msglabel, sizeof(msglabel),
+				      (struct sockaddr *)&sin, &sinlen,
+				      NULL, &flags);
+		if (result < 0) {
+			perror("Server sctp_recvmsg-1");
+			close(sock);
+			exit(1);
+		}
+
+		if (verbose)
+			print_addr_info((struct sockaddr *)&sin,
+					"Server SEQPACKET recvmsg");
+
+		if (flags & MSG_NOTIFICATION && flags & MSG_EOR) {
+			assoc_id = handle_event(msglabel);
+			if (assoc_id <= 0) {
+				printf("Server Invalid association ID: %d\n",
+				       assoc_id);
+				close(sock);
+				exit(1);
+			}
+			/* No more notifications */
+			set_subscr_events(sock, 0);
+
+			peeloff_sk = sctp_peeloff(sock, assoc_id);
+			if (peeloff_sk < 0) {
+				perror("Server sctp_peeloff");
+				close(sock);
+				exit(1);
+			}
+			if (verbose) {
+				printf("Server sctp_peeloff(3) on sk: %d with association ID: %d\n",
+				       peeloff_sk, assoc_id);
+				print_context(peeloff_sk, "Server PEELOFF");
+			}
+
+			/* Now get the client msg on peeloff socket */
+			result = sctp_recvmsg(peeloff_sk, msglabel, sizeof(msglabel),
+					      (struct sockaddr *)&sin, &sinlen,
+					      NULL, &flags);
+			if (result < 0) {
+				perror("Server sctp_recvmsg-2");
+				close(peeloff_sk);
+				close(sock);
+				exit(1);
+			}
+
+			if (verbose)
+				print_addr_info((struct sockaddr *)&sin,
+						"Server SEQPACKET peeloff recvmsg");
+		} else {
+			printf("Invalid sctp_recvmsg response FLAGS: %x\n",
+			       flags);
+			close(peeloff_sk);
+			close(sock);
+			exit(1);
+		}
+
+		if (nopeer) {
+			peerlabel = strdup("nopeer");
+		} else if (snd_opt) {
+			peerlabel = get_ip_option(sock, ipv4, &opt_len);
+
+			if (!peerlabel)
+				peerlabel = strdup("no_ip_options");
+		} else {
+			result = getpeercon(peeloff_sk, &peerlabel);
+			if (result < 0) {
+				perror("Server getpeercon");
+				close(sock);
+				close(peeloff_sk);
+				exit(1);
+			}
+		}
+
+		printf("Server PEELOFF %s: %s\n",
+		       snd_opt ? "sock_opt" : "peer label", peerlabel);
+
+		result = sctp_sendmsg(peeloff_sk, peerlabel,
+				      strlen(peerlabel),
+				      (struct sockaddr *)&sin,
+				      sinlen, 0, 0, 0, 0, 0);
+		if (result < 0) {
+			perror("Server sctp_sendmsg");
+			close(peeloff_sk);
+			close(sock);
+			exit(1);
+		}
+
+		if (verbose)
+			printf("Server PEELOFF sent: %s\n", peerlabel);
+
+		free(peerlabel);
+
+
+
+		close(peeloff_sk);
+	} while (1);
+
+	close(sock);
+	exit(0);
+}
diff --git a/tests/sctp/sctp_server.c b/tests/sctp/sctp_server.c
new file mode 100644
index 0000000..a119f2d
--- /dev/null
+++ b/tests/sctp/sctp_server.c
@@ -0,0 +1,335 @@
+#include "sctp_common.h"
+
+static void usage(char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s [-4] [-b ipv4_addr] [-h addr] [-i] [-n] [-v] stream|seq port\n"
+		"\nWhere:\n\t"
+		"-4      Listen on IPv4 addresses only (used for CIPSO tests).\n\t"
+		"-b      Call sctp_bindx(3) with the supplied IPv4 address.\n\t"
+		"-h      IPv4 or IPv6 listen address. If IPv6 link-local address,\n\t"
+		"        then requires the %%<if_name> to obtain scopeid. e.g.\n\t"
+		"            fe80::7629:afff:fe0f:8e5d%%wlp6s0\n\t"
+		"-i      Send IP Options as msg (default is peer label).\n\t"
+		"-n      No peer label or IP option will be available therefore\n\t"
+		"        send \"nopeer\" message to client.\n\t"
+		"-v      Print context and ip options information.\n\t"
+		"stream  Use SCTP 1-to-1 style or:\n\t"
+		"seq     use SCTP 1-to-Many style.\n\t"
+		"port    Listening port.\n", progname);
+	exit(1);
+}
+
+int main(int argc, char **argv)
+{
+	int opt, sock, newsock, result, flags, if_index = 0, on = 1;
+	socklen_t sinlen, opt_len;
+	struct sockaddr_storage sin;
+	struct addrinfo hints, *res;
+	struct sctp_sndrcvinfo sinfo;
+	struct pollfd poll_fd;
+	char getsockopt_peerlabel[1024];
+	char byte, *peerlabel, msglabel[1024], if_name[30];
+	bool nopeer = false,  verbose = false,  ipv4 = false, snd_opt = false;
+	char *context, *host_addr = NULL, *bindx_addr = NULL;
+	struct sockaddr_in ipv4_addr;
+	unsigned short port;
+
+	while ((opt = getopt(argc, argv, "4b:h:inv")) != -1) {
+		switch (opt) {
+		case '4':
+			ipv4 = true;
+			break;
+		case 'b':
+			bindx_addr = optarg;
+			break;
+		case 'h':
+			host_addr = optarg;
+			break;
+		case 'i':
+			snd_opt = true;
+			break;
+		case 'n':
+			nopeer = true;
+			break;
+		case 'v':
+			verbose = true;
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
+
+	if ((argc - optind) != 2)
+		usage(argv[0]);
+
+	port = atoi(argv[optind + 1]);
+	if (!port)
+		usage(argv[0]);
+
+	memset(&hints, 0, sizeof(struct addrinfo));
+	hints.ai_flags = AI_PASSIVE;
+	hints.ai_protocol = IPPROTO_SCTP;
+
+	if (ipv4)
+		hints.ai_family = AF_INET;
+	else
+		hints.ai_family = AF_INET6;
+
+	if (!strcmp(argv[optind], "stream"))
+		hints.ai_socktype = SOCK_STREAM;
+	else if (!strcmp(argv[optind], "seq"))
+		hints.ai_socktype = SOCK_SEQPACKET;
+	else
+		usage(argv[0]);
+
+	if (verbose) {
+		if (getcon(&context) < 0)
+			context = strdup("unavailable");
+		printf("Server process context: %s\n", context);
+		free(context);
+	}
+
+	if (host_addr) {
+		char *ptr;
+
+		ptr = strpbrk(host_addr, "%");
+		if (ptr)
+			strcpy(if_name, ptr + 1);
+
+		if_index = if_nametoindex(if_name);
+		if (!if_index) {
+			perror("Server if_nametoindex");
+			exit(1);
+		}
+
+		result = getaddrinfo(host_addr, argv[optind + 1],
+				     &hints, &res);
+
+	} else {
+		result = getaddrinfo(NULL, argv[optind + 1], &hints, &res);
+	}
+
+	if (result < 0) {
+		fprintf(stderr, "Server getaddrinfo: %s\n",
+			gai_strerror(result));
+		exit(1);
+	}
+
+	sock = socket(res->ai_family, res->ai_socktype, res->ai_protocol);
+	if (sock < 0) {
+		perror("Server socket");
+		exit(1);
+	}
+
+	result = setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &on, sizeof(on));
+	if (result < 0) {
+		perror("Server setsockopt: SO_REUSEADDR");
+		close(sock);
+		exit(1);
+	}
+
+	/* Enables sctp_data_io_events for sctp_recvmsg(3) for assoc_id. */
+	result = setsockopt(sock, SOL_SCTP, SCTP_EVENTS, &on, sizeof(on));
+	if (result < 0) {
+		perror("Server setsockopt: SCTP_EVENTS");
+		close(sock);
+		exit(1);
+	}
+
+	if (bindx_addr) {
+		memset(&ipv4_addr, 0, sizeof(struct sockaddr_in));
+		ipv4_addr.sin_family = AF_INET;
+		ipv4_addr.sin_port = htons(port);
+		ipv4_addr.sin_addr.s_addr = inet_addr(bindx_addr);
+
+		result = sctp_bindx(sock, (struct sockaddr *)&ipv4_addr, 1,
+				    SCTP_BINDX_ADD_ADDR);
+		if (result < 0) {
+			perror("Server sctp_bindx ADD - ipv4");
+			close(sock);
+			exit(1);
+		}
+	} else {
+		result = bind(sock, res->ai_addr, res->ai_addrlen);
+		if (result < 0) {
+			perror("Server bind");
+			close(sock);
+			exit(1);
+		}
+	}
+
+	if (verbose) {
+		print_context(sock, "Server LISTEN");
+		print_ip_option(sock, ipv4, "Server LISTEN");
+	}
+
+	if (listen(sock, SOMAXCONN)) {
+		perror("Server listen");
+		close(sock);
+		exit(1);
+	}
+
+	if (hints.ai_socktype == SOCK_STREAM) {
+		if (verbose)
+			print_context(sock, "Server STREAM");
+
+		do {
+			socklen_t labellen = sizeof(getsockopt_peerlabel);
+
+			sinlen = sizeof(sin);
+
+			newsock = accept(sock, (struct sockaddr *)&sin,
+					 &sinlen);
+			if (newsock < 0) {
+				perror("Server accept");
+				close(sock);
+				exit(1);
+			}
+
+			if (verbose) {
+				print_context(newsock,
+					      "Server STREAM accept on newsock");
+				print_addr_info((struct sockaddr *)&sin,
+						"Server connected to Client");
+				print_ip_option(newsock, ipv4,
+						"Server STREAM accept on newsock");
+			}
+
+			if (nopeer) {
+				peerlabel = strdup("nopeer");
+			} else if (snd_opt) {
+				peerlabel = get_ip_option(newsock, ipv4,
+							  &opt_len);
+				if (!peerlabel)
+					peerlabel = strdup("no_ip_options");
+			} else {
+				result = getpeercon(newsock, &peerlabel);
+				if (result < 0) {
+					perror("Server getpeercon");
+					close(sock);
+					close(newsock);
+					exit(1);
+				}
+
+				/* Also test the getsockopt version */
+				result = getsockopt(newsock, SOL_SOCKET,
+						    SO_PEERSEC,
+						    getsockopt_peerlabel,
+						    &labellen);
+				if (result < 0) {
+					perror("Server getsockopt: SO_PEERSEC");
+					close(sock);
+					close(newsock);
+					exit(1);
+				}
+				if (verbose)
+					printf("Server STREAM SO_PEERSEC peer label: %s\n",
+					       getsockopt_peerlabel);
+			}
+			printf("Server STREAM %s: %s\n",
+			       snd_opt ? "sock_opt" : "peer label", peerlabel);
+
+			result = read(newsock, &byte, 1);
+			if (result < 0) {
+				perror("Server read");
+				close(sock);
+				close(newsock);
+				exit(1);
+			}
+
+			result = write(newsock, peerlabel, strlen(peerlabel));
+			if (result < 0) {
+				perror("Server write");
+				close(sock);
+				close(newsock);
+				exit(1);
+			}
+
+			if (verbose)
+				printf("Server STREAM sent: %s\n", peerlabel);
+
+			free(peerlabel);
+
+			/* Let the client close the connection first as this
+			 * will stop OOTB chunks if newsock closed early.
+			 */
+			poll_fd.fd = newsock;
+			poll_fd.events = POLLRDHUP;
+			poll_fd.revents = 1;
+			result = poll(&poll_fd, 1, 1000);
+			if (verbose && result == 1)
+				printf("Server STREAM: Client closed connection\n");
+			else if (verbose && result == 0)
+				printf("Server: poll(2) timed out - OKAY\n");
+			else if (result < 0)
+				perror("Server - poll");
+
+			close(newsock);
+		} while (1);
+	} else { /* hints.ai_socktype == SOCK_SEQPACKET */
+		if (verbose)
+			print_context(sock, "Server SEQPACKET sock");
+
+		do {
+			sinlen = sizeof(sin);
+
+			result = sctp_recvmsg(sock, msglabel, sizeof(msglabel),
+					      (struct sockaddr *)&sin, &sinlen,
+					      &sinfo, &flags);
+			if (result < 0) {
+				perror("Server sctp_recvmsg");
+				close(sock);
+				exit(1);
+			}
+
+			if (verbose) {
+				print_context(sock, "Server SEQPACKET recvmsg");
+				print_addr_info((struct sockaddr *)&sin,
+						"Server SEQPACKET recvmsg");
+				print_ip_option(sock, ipv4,
+						"Server SEQPACKET recvmsg");
+			}
+
+			if (nopeer) {
+				peerlabel = strdup("nopeer");
+			} else if (snd_opt) {
+				peerlabel = get_ip_option(sock, ipv4, &opt_len);
+
+				if (!peerlabel)
+					peerlabel = strdup("no_ip_options");
+			} else {
+				result = getpeercon(sock, &peerlabel);
+				if (result < 0) {
+					perror("Server getpeercon");
+					close(sock);
+					exit(1);
+				}
+			}
+			printf("Server SEQPACKET %s: %s\n",
+			       snd_opt ? "sock_opt" : "peer label", peerlabel);
+
+			if (sin.ss_family == AF_INET6 && host_addr)
+				((struct sockaddr_in6 *)&sin)->sin6_scope_id = if_index;
+
+			result = sctp_sendmsg(sock, peerlabel,
+					      strlen(peerlabel),
+					      (struct sockaddr *)&sin,
+					      sinlen, 0, 0, 0, 0, 0);
+			if (result < 0) {
+				perror("Server sctp_sendmsg");
+				close(sock);
+				exit(1);
+			}
+
+			if (verbose)
+				printf("Server SEQPACKET sent: %s\n",
+				       peerlabel);
+
+			free(peerlabel);
+		} while (1);
+	}
+
+	close(sock);
+	exit(0);
+}
diff --git a/tests/sctp/sctp_set_params.c b/tests/sctp/sctp_set_params.c
new file mode 100644
index 0000000..d4914bb
--- /dev/null
+++ b/tests/sctp/sctp_set_params.c
@@ -0,0 +1,205 @@
+#include "sctp_common.h"
+
+static void usage(char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s [-v] [-o aci|pap|pat] stream|seq addr port\n"
+		"\nWhere:\n\t"
+		"-v      Print information.\n\t"
+		"-o      Test setsockoption(3) using one of the following\n\t"
+		"        options:\n\t\t"
+		"        aci = SCTP_ASSOCINFO\n\t\t"
+		"        pap = SCTP_PEER_ADDR_PARAMS\n\t\t"
+		"        pat = SCTP_PEER_ADDR_THLDS\n\t\t"
+		"stream  SCTP 1-to-1 style or:\n\t"
+		"seq     SCTP 1-to-Many style.\n\t"
+		"addr    Servers IPv4 or IPv6 address.\n\t"
+		"port    port.\n", progname);
+	exit(1);
+}
+
+/* Test set_param permission for SCTP_ASSOCINFO */
+static void sctp_associnfo(int sk, int option)
+{
+	int result;
+	socklen_t len;
+	struct sctp_assocparams assocparams;
+
+	memset(&assocparams, 0, sizeof(struct sctp_assocparams));
+
+	len = sizeof(struct sctp_assocparams);
+	result = getsockopt(sk, IPPROTO_SCTP, option, &assocparams, &len);
+	if (result < 0) {
+		perror("getsockopt: SCTP_ASSOCINFO");
+		close(sk);
+		exit(1);
+	}
+
+	assocparams.sasoc_asocmaxrxt += 5;
+	assocparams.sasoc_cookie_life += 15;
+
+	result = setsockopt(sk, IPPROTO_SCTP, option, &assocparams, len);
+	if (result < 0) {
+		perror("setsockopt: SCTP_ASSOCINFO");
+		close(sk);
+		exit(1);
+	}
+}
+
+
+/* Test set_param permission for SCTP_PEER_ADDR_PARAMS */
+static void sctp_peer_addr_params(int sk, int option)
+{
+	int result;
+	struct sctp_paddrparams heartbeat;
+
+	memset(&heartbeat, 0, sizeof(struct sctp_paddrparams));
+	heartbeat.spp_flags = SPP_HB_ENABLE;
+	heartbeat.spp_hbinterval = 100;
+	heartbeat.spp_pathmaxrxt = 1;
+
+	result = setsockopt(sk, IPPROTO_SCTP, option,
+			    &heartbeat, sizeof(heartbeat));
+	if (result < 0) {
+		perror("setsockopt: SCTP_PEER_ADDR_PARAMS");
+		close(sk);
+		exit(1);
+	}
+}
+
+int main(int argc, char **argv)
+{
+	int opt, type, srv_sock, client_sock, result, sockoption = 0;
+	struct addrinfo srv_hints, client_hints, *srv_res, *client_res;
+	bool verbose = false;
+	char *context;
+
+	while ((opt = getopt(argc, argv, "o:v")) != -1) {
+		switch (opt) {
+		case 'o':
+			if (!strcmp(optarg, "aci"))
+				sockoption = SCTP_ASSOCINFO;
+			else if (!strcmp(optarg, "pap"))
+				sockoption = SCTP_PEER_ADDR_PARAMS;
+			else if (!strcmp(optarg, "pat")) {
+				printf("SCTP_PEER_ADDR_THLDS not currently supported by userspace\n");
+				exit(1);
+			} else
+				usage(argv[0]);
+			break;
+		case 'v':
+			verbose = true;
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
+
+	if ((argc - optind) != 3)
+		usage(argv[0]);
+
+	if (!strcmp(argv[optind], "stream"))
+		type = SOCK_STREAM;
+	else if (!strcmp(argv[optind], "seq"))
+		type = SOCK_SEQPACKET;
+	else
+		usage(argv[0]);
+
+	if (verbose) {
+		if (getcon(&context) < 0)
+			context = strdup("unavailable");
+
+		printf("Process context: %s\n", context);
+		free(context);
+	}
+
+	memset(&srv_hints, 0, sizeof(struct addrinfo));
+	srv_hints.ai_flags = AI_PASSIVE;
+	srv_hints.ai_family = AF_INET6;
+
+	srv_hints.ai_socktype = type;
+	srv_hints.ai_protocol = IPPROTO_SCTP;
+
+	/* Set up server side */
+	result = getaddrinfo(NULL, argv[optind + 2], &srv_hints, &srv_res);
+	if (result < 0) {
+		printf("getaddrinfo - server: %s\n", gai_strerror(result));
+		exit(1);
+	}
+
+	srv_sock = socket(srv_res->ai_family, srv_res->ai_socktype,
+			  srv_res->ai_protocol);
+	if (srv_sock < 0) {
+		perror("socket - server");
+		exit(1);
+	}
+
+	if (verbose)
+		print_context(srv_sock, "Server");
+
+	if (bind(srv_sock, srv_res->ai_addr, srv_res->ai_addrlen) < 0) {
+		perror("bind");
+		close(srv_sock);
+		exit(1);
+	}
+
+	listen(srv_sock, 1);
+
+	/* Set up client side */
+	memset(&client_hints, 0, sizeof(struct addrinfo));
+	client_hints.ai_socktype = type;
+	client_hints.ai_protocol = IPPROTO_SCTP;
+	result = getaddrinfo(argv[optind + 1], argv[optind + 2],
+			     &client_hints, &client_res);
+	if (result < 0) {
+		fprintf(stderr, "getaddrinfo - client: %s\n",
+			gai_strerror(result));
+		exit(1);
+	}
+
+	client_sock = socket(client_res->ai_family, client_res->ai_socktype,
+			     client_res->ai_protocol);
+	if (client_sock < 0) {
+		perror("socket - client");
+		exit(1);
+	}
+
+	if (verbose)
+		print_context(client_sock, "Client");
+
+	result = sctp_connectx(client_sock, client_res->ai_addr, 1, NULL);
+	if (result < 0) {
+		perror("connectx");
+		close(client_sock);
+		exit(1);
+	}
+
+	if (sockoption) {
+		switch (sockoption) {
+		case SCTP_ASSOCINFO:
+			if (verbose)
+				printf("Testing: SCTP_ASSOCINFO\n");
+			sctp_associnfo(srv_sock, sockoption);
+			break;
+		case SCTP_PEER_ADDR_PARAMS:
+			if (verbose)
+				printf("Testing: SCTP_PEER_ADDR_PARAMS\n");
+			sctp_peer_addr_params(client_sock, sockoption);
+			break;
+		}
+	} else {
+
+		if (verbose)
+			printf("Testing: SCTP_ASSOCINFO\n");
+		sctp_associnfo(srv_sock, SCTP_ASSOCINFO);
+
+		if (verbose)
+			printf("Testing: SCTP_PEER_ADDR_PARAMS\n");
+		sctp_peer_addr_params(client_sock, SCTP_PEER_ADDR_PARAMS);
+
+	}
+
+	close(srv_sock);
+	close(client_sock);
+	exit(0);
+}
diff --git a/tests/sctp/sctp_set_peer_addr.c b/tests/sctp/sctp_set_peer_addr.c
new file mode 100644
index 0000000..61a3a44
--- /dev/null
+++ b/tests/sctp/sctp_set_peer_addr.c
@@ -0,0 +1,414 @@
+/*
+ * This test will allow the server side to add/remove bindx addresses and
+ * inform the client side via ASCONF chunks. It will also allow the server
+ * side to inform the client that the peer primary address is being updated.
+ * The code for checking these parameters are in net/sctp/sm_make_chunk.c
+ * sctp_process_asconf_param().
+ *
+ * To enable the processing of these incoming ASCONF parameters for:
+ *      SCTP_PARAM_SET_PRIMARY, SCTP_PARAM_ADD_IP and SCTP_PARAM_DEL_IP
+ * the following options must be enabled:
+ *	echo 1 > /proc/sys/net/sctp/addip_enable
+ *	echo 1 > /proc/sys/net/sctp/addip_noauth_enable
+ *
+ * If these are not enabled the SCTP_SET_PEER_PRIMARY_ADDR setsockopt
+ * fails with EPERM "Operation not permitted", however the bindx calls
+ * will complete but the client side will not be informed.
+ *
+ * NOTES:
+ *   1) SCTP_SET_PEER_PRIMARY_ADDR requires a non-loopback IP address.
+ *   2) Both addresses MUST be the same type (i.e. IPv4 or IPv6).
+ */
+
+#include "sctp_common.h"
+
+static void usage(char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s -v addr new_pri_addr port\n"
+		"\nWhere:\n\t"
+		"-v           Print status information.\n\t"
+		"addr         IPv4/IPv6 address for initial connection.\n\t"
+		"new_pri_addr IPv4/IPv6 address that the server will bindx\n\t"
+		"             then set to the new SCTP_PRIMARY_ADDR.\n\t"
+		"port         port.\n", progname);
+	fprintf(stderr,
+		"Notes:\n\t"
+		"1) addr and new_pri_addr MUST NOT be loopback addresses.\n\t"
+		"2) addr and new_pri_addr MUST be same type (IPv4 or IPv6).\n\t"
+		"3) IPv6 link-local addresses require the %%<if_name> to\n\t"
+		"   obtain scopeid. e.g. fe80::7629:afff:fe0f:8e5d%%wlp6s0\n");
+	exit(1);
+}
+
+static int peer_count, peer_count_err;
+
+static void getpaddrs_alarm(int sig)
+{
+	fprintf(stderr, "Get peer address count timer expired - carry on test\n");
+	peer_count += 1;
+	peer_count_err = true;
+}
+
+static void getprimaddr_alarm(int sig)
+{
+	fprintf(stderr, "Get primary address timer expired - end test.\n");
+	exit(1);
+}
+
+static void print_primaddr(char *msg, int socket)
+{
+	int result;
+	struct sctp_prim prim;
+	struct sockaddr_in *in_addr;
+	struct sockaddr_in6 *in6_addr;
+	struct sockaddr *paddr;
+	socklen_t prim_len;
+	char addr_buf[INET6_ADDRSTRLEN];
+	const char *addr_ptr = NULL;
+
+	memset(&prim, 0, sizeof(struct sctp_prim));
+
+	prim_len = sizeof(struct sctp_prim);
+	result = getsockopt(socket, IPPROTO_SCTP, SCTP_PRIMARY_ADDR,
+			    &prim, &prim_len);
+	if (result < 0) {
+		perror("getsockopt: SCTP_PRIMARY_ADDR");
+		exit(1);
+	}
+
+	paddr = (struct sockaddr *)&prim.ssp_addr;
+	if (paddr->sa_family == AF_INET) {
+		in_addr = (struct sockaddr_in *)&prim.ssp_addr;
+		addr_ptr = inet_ntop(AF_INET, &in_addr->sin_addr, addr_buf,
+				     INET6_ADDRSTRLEN);
+	} else if (paddr->sa_family == AF_INET6) {
+		in6_addr = (struct sockaddr_in6 *)&prim.ssp_addr;
+		addr_ptr = inet_ntop(AF_INET6, &in6_addr->sin6_addr, addr_buf,
+				     INET6_ADDRSTRLEN);
+	}
+
+	if (!addr_ptr) {
+		perror("inet_ntop");
+		exit(1);
+	}
+
+	printf("%s SCTP_PRIMARY_ADDR: %s\n", msg, addr_ptr);
+}
+
+static void get_primaddr(char *addr_buf, int socket)
+{
+	int result;
+	struct sctp_prim prim;
+	struct sockaddr_in *in_addr;
+	struct sockaddr_in6 *in6_addr;
+	struct sockaddr *paddr;
+	socklen_t prim_len;
+	const char *addr_ptr = NULL;
+
+	memset(&prim, 0, sizeof(struct sctp_prim));
+	prim_len = sizeof(struct sctp_prim);
+	result = getsockopt(socket, IPPROTO_SCTP, SCTP_PRIMARY_ADDR,
+			    &prim, &prim_len);
+	if (result < 0) {
+		perror("getsockopt: SCTP_PRIMARY_ADDR");
+		exit(1);
+	}
+
+	paddr = (struct sockaddr *)&prim.ssp_addr;
+	if (paddr->sa_family == AF_INET) {
+		in_addr = (struct sockaddr_in *)&prim.ssp_addr;
+		addr_ptr = inet_ntop(AF_INET, &in_addr->sin_addr, addr_buf,
+				     INET6_ADDRSTRLEN);
+	} else if (paddr->sa_family == AF_INET6) {
+		in6_addr = (struct sockaddr_in6 *)&prim.ssp_addr;
+		addr_ptr = inet_ntop(AF_INET6, &in6_addr->sin6_addr, addr_buf,
+				     INET6_ADDRSTRLEN);
+	}
+	if (!addr_ptr) {
+		perror("inet_ntop");
+		exit(1);
+	}
+}
+
+int main(int argc, char **argv)
+{
+	int opt, srv_sock, client_sock, new_sock, result, on = 1;
+	struct addrinfo srv_hints, client_hints, *srv_res, *client_res;
+	struct addrinfo *new_pri_addr_res;
+	struct sockaddr *sa_ptr, *paddrs;
+	socklen_t sinlen;
+	struct sockaddr_storage sin;
+	struct sctp_setpeerprim setpeerprim;
+	bool verbose = false, is_ipv6 = false;
+	char client_prim_addr[INET6_ADDRSTRLEN];
+	char client_prim_new_pri_addr[INET6_ADDRSTRLEN];
+
+	while ((opt = getopt(argc, argv, "v")) != -1) {
+		switch (opt) {
+		case 'v':
+			verbose = true;
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
+
+	if ((argc - optind) != 3)
+		usage(argv[0]);
+
+	if (strchr(argv[optind], ':') && strchr(argv[optind + 1], ':')) {
+		is_ipv6 = true;
+		srv_hints.ai_family = AF_INET6;
+	} else if (strchr(argv[optind], '.') &&
+		   strchr(argv[optind + 1], '.')) {
+		is_ipv6 = false;
+		srv_hints.ai_family = AF_INET;
+	} else {
+		usage(argv[0]);
+	}
+
+	memset(&srv_hints, 0, sizeof(struct addrinfo));
+	srv_hints.ai_flags = AI_PASSIVE;
+	srv_hints.ai_socktype = SOCK_STREAM;
+	srv_hints.ai_protocol = IPPROTO_SCTP;
+
+	/* Set up server side */
+	result = getaddrinfo(argv[optind], argv[optind + 2],
+			     &srv_hints, &srv_res);
+	if (result < 0) {
+		fprintf(stderr, "getaddrinfo - server: %s\n",
+			gai_strerror(result));
+		exit(1);
+	}
+
+	result = getaddrinfo(argv[optind], argv[optind + 2],
+			     &srv_hints, &srv_res);
+	if (result < 0) {
+		fprintf(stderr, "getaddrinfo - server: %s\n",
+			gai_strerror(result));
+		exit(1);
+	}
+	if (is_ipv6 && verbose)
+		printf("Server scopeID: %d\n",
+		       ((struct sockaddr_in6 *)
+			srv_res->ai_addr)->sin6_scope_id);
+
+	srv_sock = socket(srv_res->ai_family, srv_res->ai_socktype,
+			  srv_res->ai_protocol);
+	if (srv_sock < 0) {
+		perror("socket - server");
+		exit(1);
+	}
+
+	result = setsockopt(srv_sock, SOL_SOCKET, SO_REUSEADDR,
+			    &on, sizeof(on));
+	if (result < 0) {
+		perror("setsockopt: SO_REUSEADDR");
+		close(srv_sock);
+		exit(1);
+	}
+
+	result = bind(srv_sock, srv_res->ai_addr, srv_res->ai_addrlen);
+	if (result < 0) {
+		perror("bind");
+		close(srv_sock);
+		exit(1);
+	}
+
+	listen(srv_sock, 1);
+
+	/* Set up client side and connect */
+	memset(&client_hints, 0, sizeof(struct addrinfo));
+	client_hints.ai_socktype = SOCK_STREAM;
+	client_hints.ai_protocol = IPPROTO_SCTP;
+	result = getaddrinfo(argv[optind], argv[optind + 2],
+			     &client_hints, &client_res);
+	if (result < 0) {
+		fprintf(stderr, "getaddrinfo - client: %s\n",
+			gai_strerror(result));
+		close(srv_sock);
+		exit(1);
+	}
+	if (is_ipv6 && verbose)
+		printf("Client scopeID: %d\n",
+		       ((struct sockaddr_in6 *)
+			client_res->ai_addr)->sin6_scope_id);
+
+	client_sock = socket(client_res->ai_family, client_res->ai_socktype,
+			     client_res->ai_protocol);
+	if (client_sock < 0) {
+		perror("socket - client");
+		close(srv_sock);
+		exit(1);
+	}
+
+	result = connect(client_sock, client_res->ai_addr,
+			 client_res->ai_addrlen);
+	if (result < 0) {
+		if (errno != EINPROGRESS)
+			perror("connect");
+		else
+			fprintf(stderr, "connect timeout\n");
+		result = 1;
+		goto err2;
+	}
+
+	/* Obtain address info for the BINDX_ADD and new SCTP_PRIMARY_ADDR. */
+	result = getaddrinfo(argv[optind + 1], argv[optind + 2],
+			     &client_hints, &new_pri_addr_res);
+	if (result < 0) {
+		fprintf(stderr, "getaddrinfo - new SCTP_PRIMARY_ADDR: %s\n",
+			gai_strerror(result));
+		close(srv_sock);
+		exit(1);
+	}
+	if (is_ipv6 && verbose)
+		printf("new_pri_addr scopeID: %d\n",
+		       ((struct sockaddr_in6 *)
+			new_pri_addr_res->ai_addr)->sin6_scope_id);
+
+	/* Get number of peer addresses on CLIENT (should be 1) for a check
+	 * later as sctp_bindx SERVER -> CLIENT is non-blocking.
+	 */
+	peer_count = sctp_getpaddrs(client_sock, 0, &paddrs);
+	sctp_freepaddrs(paddrs);
+	if (verbose)
+		printf("Client peer address count: %d\n", peer_count);
+
+	/* Client and server now set so accept new socket on server side. */
+	new_sock = accept(srv_sock, (struct sockaddr *)&sin, &sinlen);
+	if (new_sock < 0) {
+		perror("accept");
+		result = 1;
+		goto err2;
+	}
+
+	/* Get initial CLIENT primary address (that should be ADDR1). */
+	get_primaddr(client_prim_addr, client_sock);
+
+	/* Now call sctp_bindx to add new_pri_addr, this will cause an
+	 * ASCONF - SCTP_PARAM_ADD_IP chunk to be sent to the CLIENT.
+	 * This is non-blocking so there maybe a delay before the CLIENT
+	 * receives the asconf chunk.
+	 */
+	if (verbose)
+		printf("Calling sctp_bindx ADD: %s\n", argv[optind + 1]);
+
+	result = sctp_bindx(new_sock,
+			    (struct sockaddr *)new_pri_addr_res->ai_addr,
+			    1, SCTP_BINDX_ADD_ADDR);
+	if (result < 0) {
+		if (errno == EACCES) {
+			perror("sctp_bindx ADD");
+		} else {
+			perror("sctp_bindx ADD");
+			result = 1;
+			goto err1;
+		}
+	}
+	/* so set an alarm and check number of peer addresses for CLIENT. */
+	signal(SIGALRM, getpaddrs_alarm);
+	alarm(2);
+	peer_count_err = false;
+	result = 0;
+
+	while (result != peer_count + 1) {
+		result = sctp_getpaddrs(client_sock, 0, &paddrs);
+		sctp_freepaddrs(paddrs);
+
+		if (peer_count_err)
+			break;
+	}
+	peer_count = result;
+
+	if (verbose)
+		printf("Client peer address count: %d\n", result);
+
+	/* Now that the CLIENT has the new primary address ensure they use
+	 * it by SCTP_SET_PEER_PRIMARY_ADDR.
+	 */
+	memset(&setpeerprim, 0, sizeof(struct sctp_setpeerprim));
+	sa_ptr = (struct sockaddr *)&setpeerprim.sspp_addr;
+	if (is_ipv6)
+		memcpy(sa_ptr, new_pri_addr_res->ai_addr,
+		       sizeof(struct sockaddr_in6));
+	else
+		memcpy(sa_ptr, new_pri_addr_res->ai_addr,
+		       sizeof(struct sockaddr_in));
+
+	if (verbose)
+		printf("Calling setsockopt SCTP_SET_PEER_PRIMARY_ADDR: %s\n",
+		       argv[optind + 1]);
+
+	result = setsockopt(new_sock, IPPROTO_SCTP,
+			    SCTP_SET_PEER_PRIMARY_ADDR,
+			    &setpeerprim, sizeof(struct sctp_setpeerprim));
+	if (result < 0) {
+		perror("setsockopt: SCTP_SET_PEER_PRIMARY_ADDR");
+		result = 1;
+		goto err1;
+	}
+
+	/* Now get the new primary address from the client */
+	signal(SIGALRM, getprimaddr_alarm);
+	alarm(2);
+	memcpy(client_prim_new_pri_addr, client_prim_addr, INET6_ADDRSTRLEN);
+
+	while (!strcmp(client_prim_addr, client_prim_new_pri_addr))
+		get_primaddr(client_prim_new_pri_addr, client_sock);
+
+	if (verbose) {
+		printf("Client initial SCTP_PRIMARY_ADDR: %s\n",
+		       client_prim_addr);
+		print_primaddr("Server", new_sock);
+		printf("Client current SCTP_PRIMARY_ADDR: %s\n",
+		       client_prim_new_pri_addr);
+	}
+
+	/* Then delete addr1 that checks ASCONF - SCTP_PARAM_DEL_IP. */
+	if (verbose)
+		printf("Calling sctp_bindx REM: %s\n", argv[optind]);
+
+	result = sctp_bindx(new_sock, (struct sockaddr *)client_res->ai_addr,
+			    1, SCTP_BINDX_REM_ADDR);
+	if (result < 0) {
+		perror("sctp_bindx - REM");
+		result = 1;
+		goto err1;
+	}
+
+	if (!peer_count_err) {
+		alarm(2);
+		result = 0;
+
+		while (result != peer_count - 1) {
+			result = sctp_getpaddrs(client_sock, 0, &paddrs);
+			sctp_freepaddrs(paddrs);
+		}
+
+		if (verbose)
+			printf("Client peer address count: %d\n", result);
+	}
+
+	/* Compare the client primary addresses, they should be different. */
+	if (!strcmp(client_prim_addr, client_prim_new_pri_addr)) {
+		fprintf(stderr,
+			"Client addr: %s same as new_pri_addr: %s - SCTP_SET_PEER_PRIMARY_ADDR failed\n",
+			client_prim_addr, client_prim_new_pri_addr);
+		result = 1;
+		goto err1;
+	}
+
+	if (verbose)
+		printf("Client primary address changed successfully.\n");
+
+	result = 0;
+
+err1:
+	close(new_sock);
+err2:
+	close(srv_sock);
+	close(client_sock);
+	exit(result);
+}
diff --git a/tests/sctp/sctp_set_pri_addr.c b/tests/sctp/sctp_set_pri_addr.c
new file mode 100644
index 0000000..5122001
--- /dev/null
+++ b/tests/sctp/sctp_set_pri_addr.c
@@ -0,0 +1,135 @@
+#include "sctp_common.h"
+
+static void usage(char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s [-v] addr port\n"
+		"\nWhere:\n\t"
+		"-v      Print information.\n\t"
+		"addr    Servers IPv4 or IPv6 address.\n\t"
+		"port    port.\n", progname);
+	exit(1);
+}
+
+static void sctp_primary_addr(int sk, int option)
+{
+	int result;
+	socklen_t len;
+	struct sctp_prim primaddr;
+
+	memset(&primaddr, 0, sizeof(struct sctp_prim));
+
+	len = sizeof(struct sctp_prim);
+	result = getsockopt(sk, IPPROTO_SCTP, option,
+			    &primaddr, &len);
+	if (result < 0) {
+		perror("getsockopt: SCTP_PRIMARY_ADDR");
+		close(sk);
+		exit(1);
+	}
+
+	result = setsockopt(sk, IPPROTO_SCTP, option, &primaddr, len);
+	if (result < 0) {
+		perror("setsockopt: SCTP_PRIMARY_ADDR");
+		close(sk);
+		exit(1);
+	}
+}
+
+int main(int argc, char **argv)
+{
+	int opt, srv_sock, client_sock, result;
+	struct addrinfo srv_hints, client_hints, *srv_res, *client_res;
+	bool verbose = false;
+	char *context;
+
+	while ((opt = getopt(argc, argv, "v")) != -1) {
+		switch (opt) {
+		case 'v':
+			verbose = true;
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
+
+	if ((argc - optind) != 2)
+		usage(argv[0]);
+
+	if (verbose) {
+		if (getcon(&context) < 0)
+			context = strdup("unavailable");
+
+		printf("Process context: %s\n", context);
+		free(context);
+	}
+
+	memset(&srv_hints, 0, sizeof(struct addrinfo));
+	srv_hints.ai_flags = AI_PASSIVE;
+	srv_hints.ai_family = AF_INET6;
+
+	srv_hints.ai_socktype = SOCK_STREAM;
+	srv_hints.ai_protocol = IPPROTO_SCTP;
+
+	/* Set up server side */
+	result = getaddrinfo(NULL, argv[optind + 1], &srv_hints, &srv_res);
+	if (result < 0) {
+		printf("getaddrinfo - server: %s\n", gai_strerror(result));
+		exit(1);
+	}
+
+	srv_sock = socket(srv_res->ai_family, srv_res->ai_socktype,
+			  srv_res->ai_protocol);
+	if (srv_sock < 0) {
+		perror("socket - server");
+		exit(1);
+	}
+
+	if (verbose)
+		print_context(srv_sock, "Server");
+
+	if (bind(srv_sock, srv_res->ai_addr, srv_res->ai_addrlen) < 0) {
+		perror("bind");
+		close(srv_sock);
+		exit(1);
+	}
+
+	listen(srv_sock, 1);
+
+	/* Set up client side */
+	memset(&client_hints, 0, sizeof(struct addrinfo));
+	client_hints.ai_socktype = SOCK_STREAM;
+	client_hints.ai_protocol = IPPROTO_SCTP;
+	result = getaddrinfo(argv[optind], argv[optind + 1], &client_hints,
+			     &client_res);
+	if (result < 0) {
+		fprintf(stderr, "getaddrinfo - client: %s\n",
+			gai_strerror(result));
+		exit(1);
+	}
+
+	client_sock = socket(client_res->ai_family, client_res->ai_socktype,
+			     client_res->ai_protocol);
+	if (client_sock < 0) {
+		perror("socket - client");
+		exit(1);
+	}
+
+	if (verbose)
+		print_context(client_sock, "Client");
+
+	result = sctp_connectx(client_sock, client_res->ai_addr, 1, NULL);
+	if (result < 0) {
+		perror("connectx");
+		close(client_sock);
+		exit(1);
+	}
+
+	if (verbose)
+		printf("Testing: SCTP_PRIMARY_ADDR\n");
+	sctp_primary_addr(client_sock, SCTP_PRIMARY_ADDR);
+
+	close(srv_sock);
+	close(client_sock);
+	exit(0);
+}
diff --git a/tests/sctp/test b/tests/sctp/test
new file mode 100644
index 0000000..c694453
--- /dev/null
+++ b/tests/sctp/test
@@ -0,0 +1,791 @@
+#!/usr/bin/perl
+use Test::More;
+
+BEGIN {
+    $basedir = $0;
+    $basedir =~ s|(.*)/[^/]*|$1|;
+
+    # check if sctp enabled
+    if ( system("checksctp 2> /dev/null") != 0 ) {
+        plan skip_all => "SCTP not supported";
+    }
+    else {
+        $test_count = 71;
+
+        # asconf parameter tests require two local non-loopback addresses.
+        $test_asconf    = 0;
+        $ipaddress_list = `hostname -I`;
+        @ipaddress      = split /\s+/, $ipaddress_list;
+
+        if ( $ipaddress[1] ) {
+            $test_count += 2;
+            $test_asconf = 1;
+        }
+
+        # Determine if CALIPSO supported by netlabelctl(8) and kernel.
+        $test_calipso = 0;
+        $netlabelctl  = `netlabelctl -V`;
+        $netlabelctl =~ s/\D//g;
+        $kvercur = `uname -r`;
+        chomp($kvercur);
+        $kvermincalipso = "4.8";
+
+        $rc = `$basedir/../kvercmp $kvercur $kvermincalipso`;
+        if ( $netlabelctl gt "021" && $rc > 0 ) {
+            $test_count += 13;
+            $test_calipso = 1;
+        }
+
+        plan tests => $test_count;
+    }
+}
+
+#
+# NOTE: direction flow is given as Client->Server (STREAM->SEQ)
+#
+
+#
+########################## Test base configuration ##########################
+#
+print "# Testing base configuration.\n";
+
+# Start the stream server.
+if ( ( $pid = fork() ) == 0 ) {
+    exec "runcon -t test_sctp_server_t $basedir/sctp_server -n stream 1035";
+}
+select( undef, undef, undef, 0.25 );    # Give it a moment to initialize.
+
+# Verify that authorized client can communicate with the server STREAM->STREAM with client using connect(2).
+$result = system
+"runcon -t test_sctp_client_t $basedir/sctp_client -e nopeer stream 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server STREAM->STREAM with client using sctp_connectx(3).
+$result = system
+"runcon -t test_sctp_client_t $basedir/sctp_client -x -e nopeer stream 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server SEQ->STREAM with no client connect(2).
+$result = system
+"runcon -t test_sctp_client_t $basedir/sctp_client -n -e nopeer seq 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server SEQ->STREAM.
+$result = system
+  "runcon -t test_sctp_client_t $basedir/sctp_client -e nopeer seq ::1 1035";
+ok( $result eq 0 );
+
+######## This test requires setting a portcon statement in policy ###########
+# Verify that the client cannot communicate with server when using port not allowed STREAM->STREAM.
+# Note that the sctp_test policy only allows ports 1024-65535
+$result = system
+"runcon -t test_sctp_client_t -- $basedir/sctp_client -e nopeer stream ::1 1023 2>&1";
+ok( $result >> 8 eq 8 );
+
+# Kill the stream server.
+kill TERM, $pid;
+
+######## This test requires setting a portcon statement in policy ###########
+# Verify that the server cannot start when using port not allowed STREAM->STREAM.
+# Note that the sctp_test policy only allows ports 1024-65535
+$result =
+  system "runcon -t test_sctp_server_t -- $basedir/sctp_bind stream 80 2>&1";
+ok($result);
+
+#
+############################### CONNECTX #####################################
+#
+print "# Testing connectx.\n";
+
+$result = system
+  "runcon -t test_sctp_connectx_t $basedir/sctp_connectx stream 127.0.0.1 1035";
+ok( $result eq 0 );
+
+$result =
+  system "runcon -t test_sctp_connectx_t $basedir/sctp_connectx seq ::1 1035";
+ok( $result eq 0 );
+
+#
+################################ BINDX #######################################
+#
+print "# Testing bindx.\n";
+
+$result =
+  system "runcon -t test_sctp_bindx_t $basedir/sctp_bindx -r stream 1035";
+ok( $result eq 0 );
+
+$result = system "runcon -t test_sctp_bindx_t $basedir/sctp_bindx -r seq 1035";
+ok( $result eq 0 );
+
+#
+######################### SET_PRI_ADDR SET_PEER_ADDR ########################
+#
+
+# These tests require two local non-loopback addresses.
+if ($test_asconf) {
+    print "# Testing asconf parameter chunk processing.\n";
+
+    # To enable processing of incoming ASCONF parameters:
+    # SCTP_PARAM_SET_PRIMARY, SCTP_PARAM_ADD_IP and SCTP_PARAM_DEL_IP,
+    # need to set:
+    system("echo 1 > /proc/sys/net/sctp/addip_enable");
+    system("echo 1 > /proc/sys/net/sctp/addip_noauth_enable");
+
+    # Verify ASCONF params.
+    $result = system
+"runcon -t test_sctp_set_peer_addr_t $basedir/sctp_set_peer_addr $ipaddress[0] $ipaddress[1] 1035";
+    ok( $result eq 0 );
+
+    # Start the asconf server.
+    if ( ( $pid = fork() ) == 0 ) {
+        exec
+"runcon -t test_sctp_set_peer_addr_t $basedir/sctp_asconf_params_server $ipaddress[0] $ipaddress[1] 1035";
+    }
+    select( undef, undef, undef, 0.25 );    # Give it a moment to initialize.
+
+# This should fail connect permission attempting to send SCTP_PARAM_ADD_IP to client.
+    $result = system
+"runcon -t test_sctp_client_t -- $basedir/sctp_asconf_params_client $ipaddress[0] 1035 2>&1";
+    ok($result);
+
+    # The server should automatically exit.
+    kill TERM, $pid;
+
+    system("echo 0 > /proc/sys/net/sctp/addip_enable");
+    system("echo 0 > /proc/sys/net/sctp/addip_noauth_enable");
+}
+
+#
+######################## Test NetLabel Configurations #######################
+#
+########################## Fallback peer Labeling ############################
+#
+
+# Load NetLabel configuration using "netlabel_sctp_peer_t" as the label.
+print "# Testing NetLabel fallback peer labeling.\n";
+system "/bin/sh $basedir/fb-label-load";
+
+# Start stream server.
+if ( ( $pid = fork() ) == 0 ) {
+    exec "runcon -t test_sctp_server_t $basedir/sctp_server stream 1035";
+}
+select( undef, undef, undef, 0.25 );    # Give it a moment to initialize.
+
+# Verify that authorized client can communicate with the server STREAM->STREAM.
+$result = system
+"runcon -t test_sctp_client_t $basedir/sctp_client -e system_u:object_r:netlabel_sctp_peer_t:s0 stream 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server SEQ->STREAM.
+$result = system
+"runcon -t test_sctp_client_t $basedir/sctp_client -e system_u:object_r:netlabel_sctp_peer_t:s0 seq 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that a client without peer { recv } permission cannot communicate with the server STREAM->STREAM.
+$result = system
+"runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client -e system_u:object_r:netlabel_sctp_peer_t:s0 stream 127.0.0.1 1035 2>&1";
+ok( $result >> 8 eq 6 );
+
+# Kill the stream server.
+kill TERM, $pid;
+
+# Start seq server.
+if ( ( $pid = fork() ) == 0 ) {
+    exec "runcon -t test_sctp_server_t $basedir/sctp_server seq 1035";
+}
+select( undef, undef, undef, 0.25 );    # Give it a moment to initialize
+
+# Verify that authorized client can communicate with the server SEQ->SEQ.
+$result = system
+"runcon -t test_sctp_client_t $basedir/sctp_client -e system_u:object_r:netlabel_sctp_peer_t:s0 seq ::1 1035";
+ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server STREAM->SEQ.
+$result = system
+"runcon -t test_sctp_client_t $basedir/sctp_client -e system_u:object_r:netlabel_sctp_peer_t:s0 stream ::1 1035";
+ok( $result eq 0 );
+
+# Verify that a client using connect(2) without peer { recv } permission cannot communicate with the server SEQ->SEQ.
+$result = system
+"runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client -e system_u:object_r:netlabel_sctp_peer_t:s0 seq ::1 1035 2>&1";
+ok( $result >> 8 eq 6 );
+
+# Verify that a client using sctp_connectx(3) without peer { recv } permission cannot communicate with the server SEQ->SEQ.
+$result = system
+"runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client -x -e system_u:object_r:netlabel_sctp_peer_t:s0 seq ::1 1035 2>&1";
+ok( $result >> 8 eq 6 );
+
+# Verify that a client not using any connect without peer { recv } permission cannot communicate with the server SEQ->SEQ.
+$result = system
+"runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client -n -e system_u:object_r:netlabel_sctp_peer_t:s0 seq ::1 1035 2>&1";
+ok( $result >> 8 eq 13 );
+
+# Kill the seq server.
+kill TERM, $pid;
+
+system "/bin/sh $basedir/fb-label-flush";
+
+#
+#################### Test deny association permission ########################
+#
+print "# Testing deny association.\n";
+system "/bin/sh $basedir/fb-deny-label-load";
+
+if ( ( $pid = fork() ) == 0 ) {
+    exec "runcon -t test_sctp_server_t $basedir/sctp_server stream 1035";
+}
+select( undef, undef, undef, 0.25 );    # Give it a moment to initialize
+
+# Verify that authorized client can communicate with the server STREAM->STREAM.
+# This sets the servers initial peer context to netlabel_sctp_peer_t:s0
+$result = system
+"runcon -t test_sctp_client_t $basedir/sctp_client -e system_u:object_r:netlabel_sctp_peer_t:s0 stream 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that the server is denied this association as the client will timeout on connect.
+$result = system
+"runcon -t test_sctp_client_t -- $basedir/sctp_client -e system_u:object_r:deny_assoc_sctp_peer_t:s0 stream ::1 1035 2>&1";
+ok( $result >> 8 eq 6 );
+
+# Kill the seq server.
+kill TERM, $pid;
+
+system "/bin/sh $basedir/fb-deny-label-flush";
+
+#
+############################## CIPSO/IPv4 TAG 1 ###############################
+#
+print "# Testing CIPSO/IPv4 - TAG 1 using socket ip_option data\n";
+system "/bin/sh $basedir/cipso-load-t1";
+
+# Start the stream server for IPv4 only.
+if ( ( $pid = fork() ) == 0 ) {
+    exec
+"runcon -t test_sctp_server_t -l s0:c182.c192 $basedir/sctp_server -4 -i stream 1035";
+}
+select( undef, undef, undef, 0.25 );    # Give it a moment to initialize.
+
+# Verify that authorized client can communicate with the server STREAM->STREAM with client using sctp_connectx(3).
+$result = system
+"runcon -t test_sctp_client_t -l s0:c182.c192 $basedir/sctp_client -x -i stream 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server STREAM->STREAM with client using connect(2).
+$result = system
+"runcon -t test_sctp_client_t -l s0:c182.c192 $basedir/sctp_client -i stream 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server using different valid level STREAM->STREAM.
+$result = system
+"runcon -t test_sctp_client_t -l s0:c182,c187,c190 $basedir/sctp_client -i stream 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server using different valid level SEQ->STREAM
+$result = system
+"runcon -t test_sctp_client_t -l s0:c189,c192 $basedir/sctp_client -i seq 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that authorized client cannot communicate with the server using invalid level STREAM->STREAM.
+$result = system
+"runcon -t test_sctp_client_t -l s0:c182.c193 -- $basedir/sctp_client stream 127.0.0.1 1035 2>&1";
+ok( $result >> 8 eq 6 );
+
+# Kill the stream server.
+kill TERM, $pid;
+
+# Start the seq server.
+if ( ( $pid = fork() ) == 0 ) {
+    exec
+"runcon -t test_sctp_server_t -l s0:c20.c300 $basedir/sctp_server -i -4 seq 1035";
+}
+select( undef, undef, undef, 0.25 );    # Give it a moment to initialize
+
+# Verify that authorized client can communicate with the server. SEQ->SEQ
+$result = system
+"runcon -t test_sctp_client_t -l s0:c27.c28 $basedir/sctp_client -i seq 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server using STREAM->SEQ.
+$result = system
+"runcon -t test_sctp_client_t -l s0:c20.c30 $basedir/sctp_client -i stream 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server using SEQ->SEQ with diff valid level.
+$result = system
+"runcon -t test_sctp_client_t -l s0:c20.c24,c26,c27.c29 $basedir/sctp_client -i seq 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that client cannot communicate with the server using SEQ->SEQ with invalid level.
+$result = system
+"runcon -t test_sctp_client_t -l s0:c19.c100 -- $basedir/sctp_client -i seq 127.0.0.1 1035 2>&1";
+ok( $result >> 8 eq 6 );
+
+# TAG 1 allows categories 0 to 239 to be sent, if greater then ENOSPC (No space left on device)
+$result = system
+"runcon -t test_sctp_client_t -l s0:c20.c300 -- $basedir/sctp_client -i seq 127.0.0.1 1035 2>&1";
+ok( $result >> 8 eq 7 );
+
+# Kill server.
+kill TERM, $pid;
+
+print "# Testing CIPSO/IPv4 - TAG 1 PEELOFF using socket ip_option data\n";
+
+# Test sctp_peeloff(3) using 1 to Many SOCK_SEQPACKET
+if ( ( $pid = fork() ) == 0 ) {
+    exec
+"runcon -t test_sctp_server_t -l s0:c0.c10 $basedir/sctp_peeloff_server -4 -i 1035";
+}
+select( undef, undef, undef, 0.25 );    # Give it a moment to initialize
+
+# Verify that authorized client can communicate with the server using SEQ->SEQ->Peeloff with same level.
+$result = system
+"runcon -t test_sctp_client_t -l s0:c0.c10 $basedir/sctp_client -i seq 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server using STREAM->SEQ->peeloff with same level.
+$result = system
+"runcon -t test_sctp_client_t -l s0:c0.c10 $basedir/sctp_client -x -i stream 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that client cannot communicate with the server using STREAM->SEQ->peeloff with invalid level.
+$result = system
+"runcon -t test_sctp_client_t -l s0:c0.c11 -- $basedir/sctp_client -x -i stream 127.0.0.1 1035 2>&1";
+ok( $result >> 8 eq 6 );
+
+# Kill the seq server.
+kill TERM, $pid;
+
+system "/bin/sh $basedir/cipso-flush";
+
+#
+############################## CIPSO/IPv4 TAG 2 ###############################
+#
+print "# Testing CIPSO/IPv4 - TAG 2 using socket ip_option data\n";
+system "/bin/sh $basedir/cipso-load-t2";
+
+# Start the stream server for IPv4 only.
+if ( ( $pid = fork() ) == 0 ) {
+    exec
+"runcon -t test_sctp_server_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_server -4 -i stream 1035";
+}
+select( undef, undef, undef, 0.25 );    # Give it a moment to initialize.
+
+# Verify that authorized client can communicate with the server STREAM->STREAM with client using sctp_connectx(3).
+$result = system
+"runcon -t test_sctp_client_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_client -x -i stream 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server STREAM->STREAM with client using connect(2).
+$result = system
+"runcon -t test_sctp_client_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_client -i stream 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server using different valid level STREAM->STREAM.
+$result = system
+"runcon -t test_sctp_client_t -l s0:c769,c788,c803,c842,c864 $basedir/sctp_client -i stream 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server using different valid level SEQ->STREAM
+$result = system
+"runcon -t test_sctp_client_t -l s0:c769,c788,c803 $basedir/sctp_client -i seq 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that authorized client cannot communicate with the server using invalid level STREAM->STREAM.
+$result = system
+"runcon -t test_sctp_client_t -l s0:c1023 -- $basedir/sctp_client stream 127.0.0.1 1035 2>&1";
+ok( $result >> 8 eq 6 );
+
+# Kill the stream server.
+kill TERM, $pid;
+
+# Start the seq server.
+if ( ( $pid = fork() ) == 0 ) {
+    exec
+"runcon -t test_sctp_server_t -l s0:c20.c335 $basedir/sctp_server -i -4 seq 1035";
+}
+select( undef, undef, undef, 0.25 );    # Give it a moment to initialize
+
+# Verify that authorized client can communicate with the server. SEQ->SEQ
+$result = system
+"runcon -t test_sctp_client_t -l s0:c328.c333 $basedir/sctp_client -i seq 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server using STREAM->SEQ.
+$result = system
+"runcon -t test_sctp_client_t -l s0:c20.c34 $basedir/sctp_client -i stream 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server using SEQ->SEQ with diff valid level.
+$result = system
+"runcon -t test_sctp_client_t -l s0:c20.c30,c31,c335 $basedir/sctp_client -i seq 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that client cannot communicate with the server using SEQ->SEQ with invalid level.
+$result = system
+"runcon -t test_sctp_client_t -l s0:c19.c30 -- $basedir/sctp_client -i seq 127.0.0.1 1035 2>&1";
+ok( $result >> 8 eq 6 );
+
+# TAG 2 allows a maximum of 15 categories in exchange, if greater then ENOSPC (No space left on device)
+$result = system
+"runcon -t test_sctp_client_t -l s0:c200.c216 -- $basedir/sctp_client -i seq 127.0.0.1 1035 2>&1";
+ok( $result >> 8 eq 7 );
+
+# Kill server.
+kill TERM, $pid;
+
+print "# Testing CIPSO/IPv4 - TAG 2 PEELOFF using socket ip_option data\n";
+
+# Test sctp_peeloff(3) using 1 to Many SOCK_SEQPACKET
+if ( ( $pid = fork() ) == 0 ) {
+    exec
+"runcon -t test_sctp_server_t -l s0:c0.c10 $basedir/sctp_peeloff_server -4 -i 1035";
+}
+select( undef, undef, undef, 0.25 );    # Give it a moment to initialize
+
+# Verify that authorized client can communicate with the server using SEQ->SEQ->Peeloff with same level.
+$result = system
+"runcon -t test_sctp_client_t -l s0:c0.c10 $basedir/sctp_client -i seq 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server using STREAM->SEQ->peeloff with same level.
+$result = system
+"runcon -t test_sctp_client_t -l s0:c0.c10 $basedir/sctp_client -x -i stream 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that client cannot communicate with the server using STREAM->SEQ->peeloff with invalid level.
+$result = system
+"runcon -t test_sctp_client_t -l s0:c0.c11 -- $basedir/sctp_client -x -i stream 127.0.0.1 1035 2>&1";
+ok( $result >> 8 eq 6 );
+
+# Kill the seq server.
+kill TERM, $pid;
+
+system "/bin/sh $basedir/cipso-flush";
+
+#
+############################## CIPSO/IPv4 TAG 5 ###############################
+#
+print "# Testing CIPSO/IPv4 - TAG 5 using socket ip_option data\n";
+system "/bin/sh $basedir/cipso-load-t5";
+
+# Start the stream server for IPv4 only.
+if ( ( $pid = fork() ) == 0 ) {
+    exec
+"runcon -t test_sctp_server_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_server -4 -i stream 1035";
+}
+select( undef, undef, undef, 0.25 );    # Give it a moment to initialize.
+
+# Verify that authorized client can communicate with the server STREAM->STREAM with client using sctp_connectx(3).
+$result = system
+"runcon -t test_sctp_client_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_client -x -i stream 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server STREAM->STREAM with client using connect(2).
+$result = system
+"runcon -t test_sctp_client_t -l s0:c782,c714,c769,c788,c803,c842,c864 $basedir/sctp_client -i stream 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server using different valid level STREAM->STREAM.
+$result = system
+"runcon -t test_sctp_client_t -l s0:c769,c788,c803,c842,c864 $basedir/sctp_client -i stream 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server using different valid level SEQ->STREAM
+$result = system
+"runcon -t test_sctp_client_t -l s0:c769,c788,c803 $basedir/sctp_client -i seq 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that authorized client cannot communicate with the server using invalid level STREAM->STREAM.
+$result = system
+"runcon -t test_sctp_client_t -l s0:c1023 -- $basedir/sctp_client stream 127.0.0.1 1035 2>&1";
+ok( $result >> 8 eq 6 );
+
+# Kill the stream server.
+kill TERM, $pid;
+
+# Start the seq server.
+if ( ( $pid = fork() ) == 0 ) {
+    exec
+"runcon -t test_sctp_server_t -l s0:c20.c50 $basedir/sctp_server -i -4 seq 1035";
+}
+select( undef, undef, undef, 0.25 );    # Give it a moment to initialize
+
+# Verify that authorized client can communicate with the server. SEQ->SEQ
+$result = system
+"runcon -t test_sctp_client_t -l s0:c28.c48 $basedir/sctp_client -i seq 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server using STREAM->SEQ.
+$result = system
+"runcon -t test_sctp_client_t -l s0:c20.c50 $basedir/sctp_client -i stream 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server using SEQ->SEQ with diff valid level.
+$result = system
+"runcon -t test_sctp_client_t -l s0:c20.c30,c31,c35,c40.c45 $basedir/sctp_client -i seq 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that client cannot communicate with the server using SEQ->SEQ with invalid level.
+$result = system
+"runcon -t test_sctp_client_t -l s0:c20.c51 -- $basedir/sctp_client -i seq 127.0.0.1 1035 2>&1";
+ok( $result >> 8 eq 6 );
+
+# TAG 2 allows a maximum of 7 ranges in exchange, if greater then ENOSPC (No space left on device)
+$result = system
+"runcon -t test_sctp_client_t -l s0:c20,c22,c24,c30.c33,c38,c42.c45,c48,c50 -- $basedir/sctp_client -i seq 127.0.0.1 1035 2>&1";
+ok( $result >> 8 eq 7 );
+
+# Kill server.
+kill TERM, $pid;
+
+print "# Testing CIPSO/IPv4 - TAG 5 PEELOFF using socket ip_option data\n";
+
+# Test sctp_peeloff(3) using 1 to Many SOCK_SEQPACKET
+if ( ( $pid = fork() ) == 0 ) {
+    exec
+"runcon -t test_sctp_server_t -l s0:c0.c10 $basedir/sctp_peeloff_server -4 -i 1035";
+}
+select( undef, undef, undef, 0.25 );    # Give it a moment to initialize
+
+# Verify that authorized client can communicate with the server using SEQ->SEQ->Peeloff with same level.
+$result = system
+"runcon -t test_sctp_client_t -l s0:c0.c10 $basedir/sctp_client -i seq 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server using STREAM->SEQ->peeloff with same level.
+$result = system
+"runcon -t test_sctp_client_t -l s0:c0.c10 $basedir/sctp_client -x -i stream 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that client cannot communicate with the server using STREAM->SEQ->peeloff with invalid level.
+$result = system
+"runcon -t test_sctp_client_t -l s0:c0.c11 -- $basedir/sctp_client -x -i stream 127.0.0.1 1035 2>&1";
+ok( $result >> 8 eq 6 );
+
+# Kill the seq server.
+kill TERM, $pid;
+
+system "/bin/sh $basedir/cipso-flush";
+
+#
+################## CIPSO/IPv4 Full Labeling over Loopback ####################
+#
+
+print "# Testing CIPSO/IPv4 full labeling over loopback.\n";
+system "/bin/sh $basedir/cipso-fl-load";
+
+# Start the stream server for IPv4 only.
+if ( ( $pid = fork() ) == 0 ) {
+    exec "runcon -t test_sctp_server_t $basedir/sctp_server -4 stream 1035";
+}
+select( undef, undef, undef, 0.25 );    # Give it a moment to initialize.
+
+# Verify that authorized client can communicate with the server STREAM->STREAM.
+$result = system
+  "runcon -t test_sctp_client_t $basedir/sctp_client stream 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify a client without peer { recv } for client/server process cannot communicate with server STREAM->STREAM.
+$result = system
+"runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client stream 127.0.0.1 1035 2>&1";
+ok( $result >> 8 eq 6 );
+
+# Kill the stream server.
+kill TERM, $pid;
+
+# Start the seq server for IPv4 only.
+if ( ( $pid = fork() ) == 0 ) {
+    exec "runcon -t test_sctp_server_t $basedir/sctp_server -4 seq 1035";
+}
+select( undef, undef, undef, 0.25 );    # Give it a moment to initialize
+
+# Verify that authorized client can communicate with the server SEQ->STREAM.
+$result =
+  system "runcon -t test_sctp_client_t $basedir/sctp_client seq 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that a client without peer { recv } permission cannot communicate with the server SEQ->SEQ.
+$result = system
+"runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client seq 127.0.0.1 1035 2>&1";
+ok( $result >> 8 eq 6 );
+
+# Kill the seq server.
+kill TERM, $pid;
+
+system "/bin/sh $basedir/cipso-fl-flush";
+
+#
+############################### CALIPSO/IPv6 #################################
+#
+
+if ($test_calipso) {
+    print "# Testing CALIPSO/IPv6 using socket ip_option data\n";
+    system "/bin/sh $basedir/calipso-load";
+
+    # Start the stream server.
+    if ( ( $pid = fork() ) == 0 ) {
+        exec
+"runcon -t test_sctp_server_t -l  s0:c0,c12,c24,c36,c28,c610,c712,c414,c516,c318,c820,c622,c924,c726,c128,c330,c832,c534,c936,c138,c740,c42,c44,c246,c648,c950,c152,c354,c856,c158,c960,c662,c634,c686,c368,c570,c782,c714,c769,c788,c803,c842,c864,c986,c788,c290,c392,c594,c896,c698,c1023  $basedir/sctp_server -i stream 1035";
+    }
+    select( undef, undef, undef, 0.25 );    # Give it a moment to initialize.
+
+# Verify that authorized client can communicate with the server STREAM->STREAM with client using sctp_connectx(3).
+    $result = system
+"runcon -t test_sctp_client_t -l s0:c0,c12,c24,c36,c28,c610,c712,c414,c516,c318,c820,c622,c924,c726,c128,c330,c832,c534,c936,c138,c740,c42,c44,c246,c648,c950,c152,c354,c856,c158,c960,c662,c634,c686,c368,c570,c782,c714,c769,c788,c803,c842,c864,c986,c788,c290,c392,c594,c896,c698,c1023  $basedir/sctp_client -x -i stream ::1 1035";
+    ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server STREAM->STREAM with client using connect(2).
+    $result = system
+"runcon -t test_sctp_client_t -l s0:c0,c12,c24,c36,c28,c610,c712,c414,c516,c318,c820,c622,c924,c726,c128,c330,c832,c534,c936,c138,c740,c42,c44,c246,c648,c950,c152,c354,c856,c158,c960,c662,c634,c686,c368,c570,c782,c714,c769,c788,c803,c842,c864,c986,c788,c290,c392,c594,c896,c698,c1023  $basedir/sctp_client -i stream ::1 1035";
+    ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server using different valid level STREAM->STREAM.
+    $result = system
+"runcon -t test_sctp_client_t -l s0:c924,c726,c128,c330,c832,c534,c936,c138,c740,c42 $basedir/sctp_client -i stream ::1 1035";
+    ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server using different valid level SEQ->STREAM
+    $result = system
+"runcon -t test_sctp_client_t -l s0:c924,c726,c128,c330,c832,c534,c936,c138,c740,c42 $basedir/sctp_client -i seq ::1 1035";
+    ok( $result eq 0 );
+
+# Verify that authorized client cannot communicate with the server using invalid level STREAM->STREAM.
+    $result = system
+"runcon -t test_sctp_client_t -l s0:c8.c12 -- $basedir/sctp_client -i stream ::1 1035 2>&1";
+    ok( $result >> 8 eq 6 );
+
+    # Kill the stream server.
+    kill TERM, $pid;
+
+    # Start the seq server.
+    if ( ( $pid = fork() ) == 0 ) {
+        exec
+"runcon -t test_sctp_server_t -l s0:c20.c50 $basedir/sctp_server -i seq 1035";
+    }
+    select( undef, undef, undef, 0.25 );    # Give it a moment to initialize
+
+    # Verify that authorized client can communicate with the server. SEQ->SEQ
+    $result = system
+"runcon -t test_sctp_client_t -l s0:c28.c48 $basedir/sctp_client -i seq ::1 1035";
+    ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server using STREAM->SEQ.
+    $result = system
+"runcon -t test_sctp_client_t -l s0:c20.c50 $basedir/sctp_client -i stream ::1 1035";
+    ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server using SEQ->SEQ with diff valid level.
+    $result = system
+"runcon -t test_sctp_client_t -l s0:c20.c30,c31,c35,c40.c45 $basedir/sctp_client -i seq ::1 1035";
+    ok( $result eq 0 );
+
+# Verify that client cannot communicate with the server using SEQ->SEQ with invalid level.
+    $result = system
+"runcon -t test_sctp_client_t -l s0:c20.c51 $basedir/sctp_client -i seq ::1 1035 2>&1";
+    ok( $result >> 8 eq 6 );
+
+# Verify that client cannot communicate with the server using SEQ->SEQ with invalid level.
+    $result = system
+"runcon -t test_sctp_client_t -l s0:c19.c50 -- $basedir/sctp_client -i seq ::1 1035 2>&1";
+    ok( $result >> 8 eq 6 );
+
+    # Kill server.
+    kill TERM, $pid;
+
+    print "# Testing CALIPSO/IPv6 PEELOFF using socket ip_option data\n";
+
+    # Test sctp_peeloff(3) using 1 to Many SOCK_SEQPACKET
+    if ( ( $pid = fork() ) == 0 ) {
+        exec
+"runcon -t test_sctp_server_t -l s0:c0.c10 $basedir/sctp_peeloff_server -i 1035";
+    }
+    select( undef, undef, undef, 0.25 );    # Give it a moment to initialize
+
+# Verify that authorized client can communicate with the server using SEQ->SEQ->Peeloff with same level.
+    $result = system
+"runcon -t test_sctp_client_t -l s0:c0.c10 $basedir/sctp_client -i seq ::1 1035";
+    ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server using STREAM->SEQ->peeloff with same level.
+    $result = system
+"runcon -t test_sctp_client_t -l s0:c0.c10 $basedir/sctp_client -x -i stream ::1 1035";
+    ok( $result eq 0 );
+
+# Verify that client cannot communicate with the server using STREAM->SEQ->peeloff with invalid level.
+    $result = system
+"runcon -t test_sctp_client_t -l s0:c0.c11 -- $basedir/sctp_client -x -i stream ::1 1035 2>&1";
+    ok( $result >> 8 eq 6 );
+
+    # Kill the seq server.
+    kill TERM, $pid;
+
+    system "/bin/sh $basedir/calipso-flush";
+}
+
+#
+##################### Test iptables configuration ############################
+#
+print "# Testing iptables (IPv4/IPv6).\n";
+system "/bin/sh $basedir/iptables-load";
+
+# Start the stream server.
+if ( ( $pid = fork() ) == 0 ) {
+    exec "runcon -t test_sctp_server_t $basedir/sctp_server -n stream 1035";
+}
+select( undef, undef, undef, 0.25 );    # Give it a moment to initialize.
+
+# Verify that authorized client can communicate with the server STREAM->STREAM.
+$result = system
+"runcon -t test_sctp_client_t $basedir/sctp_client -e nopeer stream 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that a client without peer { recv } permission cannot communicate with the server STREAM->STREAM.
+$result = system
+"runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client -e nopeer stream 127.0.0.1 1035 2>&1";
+ok( $result >> 8 eq 6 );
+
+# Verify that authorized client can communicate with the server STREAM->STREAM.
+$result = system
+  "runcon -t test_sctp_client_t $basedir/sctp_client -e nopeer stream ::1 1035";
+ok( $result eq 0 );
+
+# Verify that a client without peer { recv } permission cannot communicate with the server STREAM->STREAM.
+$result = system
+"runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client -e nopeer stream ::1 1035 2>&1";
+ok( $result >> 8 eq 6 );
+
+# Kill the stream server.
+kill TERM, $pid;
+
+# Start the seq server.
+if ( ( $pid = fork() ) == 0 ) {
+    exec "runcon -t test_sctp_server_t $basedir/sctp_server -n seq 1035";
+}
+select( undef, undef, undef, 0.25 );    # Give it a moment to initialize.
+
+# Verify that authorized client can communicate with the server SEQ->SEQ.
+$result = system
+"runcon -t test_sctp_client_t $basedir/sctp_client -e nopeer seq 127.0.0.1 1035";
+ok( $result eq 0 );
+
+# Verify that a client without peer { recv } permission cannot communicate with the server SEQ->SEQ.
+$result = system
+"runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client -e nopeer seq 127.0.0.1 1035 2>&1";
+ok( $result >> 8 eq 6 );
+
+# Verify that authorized client can communicate with the server SEQ->SEQ.
+$result = system
+  "runcon -t test_sctp_client_t $basedir/sctp_client -e nopeer seq ::1 1035";
+ok( $result eq 0 );
+
+# Verify that a client without peer { recv } permission cannot communicate with the server SEQ->SEQ.
+$result = system
+"runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client -e nopeer seq ::1 1035 2>&1";
+ok( $result >> 8 eq 6 );
+
+# Kill the seq server.
+kill TERM, $pid;
+
+system "/bin/sh $basedir/iptables-flush";
+
+exit;
-- 
2.14.3
