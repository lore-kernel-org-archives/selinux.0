Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o7G5dRcq014303
	for <selinux@tycho.nsa.gov>; Mon, 16 Aug 2010 01:39:32 -0400
Received: from tyo201.gate.nec.co.jp (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o7G5dLoO019279
	for <selinux@tycho.nsa.gov>; Mon, 16 Aug 2010 05:39:21 GMT
Message-ID: <4C68CEF0.2070202@ak.jp.nec.com>
Date: Mon, 16 Aug 2010 14:38:56 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: memcached@googlegroups.com, Kelvin Edmison <kelvin@kindsight.net>,
        SELinux <selinux@tycho.nsa.gov>,
        Reference Policy <refpolicy@oss1.tresys.com>
Subject: Re: memcached permissions
References: <C87E39DA.3481E%kelvin@kindsight.net> <4C5A03DD.5080605@ak.jp.nec.com>
In-Reply-To: <4C5A03DD.5080605@ak.jp.nec.com>
Content-Type: multipart/mixed;
 boundary="------------020708090101050807030303"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020708090101050807030303
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

The attached patch is a revised version of memcached permissions.

The 'calculate' permission has gone, and INCR/DECR requires us
both of 'read' and 'write' permissions.
It means we should switch domain of the client process when we
need special treatments to unaccessable items; something like
trusted procedures.

Rest of the patch is not changed.

(2010/08/05 9:20), KaiGai Kohei wrote:
> (2010/08/04 10:25), Kelvin Edmison wrote:
>> I'm still not sure how allowing a 'calculate' permission would be helpful in
>> this case.  Incr and decr allow for incrementing and decrementing by any
>> amount.  There does not seem to be any real difference between that and
>> 'write' to me.
>>
> INCR and DECR allow users to set a numerical value according to arithmetic
> rule, although SET allows to set a fully arbitrary value.
> If administrator want to allow users to modify a value in a limited way,
> he can grant 'calculate' permission, instead of 'write' permission.
> 
> If we would be talking about RDBMS, it is possible to switch client's
> privileges during execution of a certain stored procedure.
> However, memcached does not have such a feature, so we need to consider
> more fine grained permissions.
> 
> BTW, I noticed a different viewpoint, although I didn't reach the idea before.
> Since memcached does not have stored procedure, it might be a correct answer
> that the client switches its privileges when it tries to modify read-only
> values. Like set-uid programs in unix, SELinux has a feature to switch
> privileges of process on execve(2) time. It allows a small number of trusted
> programs to write values, but prevents to modify items by others.
> 
>> If a strict security partitioning is desired, then perhaps a single
>> reference counter isn't feasible.  Would it not be better, from a security
>> point of view, to have individual counters for the different clients?
>> The clients would have 'create|read|write' permissions, and any overall
>> administrative app could have read-only permissions on all those counters to
>> collect and sum (or otherwise report) them?
>>
> If a strict security partitioning environment, it seems to me what you introduced
> is reasonable.
> 
> Thanks,
> 
>> Kelvin
>>
>> On 02/08/10 1:45 AM, "KaiGai Kohei"<kaigai@ak.jp.nec.com>   wrote:
>>
>>> (2010/07/30 22:55), Kelvin Edmison wrote:
>>>> While I haven't yet read the patch, I would like to understand why there is
>>>> a need for a Calculate permission.  Why would someone be granted 'calculate'
>>>> permission but not 'write' permission?
>>>>
>>>> Kelvin
>>>>
>>> The issue depends on individual user's requirement of security.
>>> If they want not to leak anything over the security domains,
>>> they should grant the 'calculate' permission on everybody who
>>> already have both 'read' and 'write' permissions.
>>> It it equivalent to these permissions.
>>> However, it may lack flexibility in configuration of access
>>> controls, if users don't consider 'INCR' and 'DECR' are risk
>>> information leaks/manipulations.
>>> For example, it is not a rare case that we don't want to expose
>>> individual client's items, but want to control a shared reference
>>> counter.
>>>
>>> Ideally, I'd like to define more fine grained permissions to
>>> distinguish a security sensitive operations and others.
>>> But here is limitation of protocol. We cannot automatically
>>> determine what is security sensitive data and what is not.
>>>
>>> Thanks,
>>>
>>>> On 30/07/10 12:49 AM, "KaiGai Kohei"<kaigai@ak.jp.nec.com>    wrote:
>>>>
>>>>> I'll mainly submit the patch and message to SELinux community,
>>>>> but please don't hesitate to comment anything from memcached
>>>>> community.
>>>>> --------
>>>>>
>>>>> The attached patch adds policies to support access controls
>>>>> on key-value items managed by memcached with SELinux engine.
>>>>>
>>>>> Nowadays, various kind of key-value-stores support memcached
>>>>> compatible protocol as a de-facto standard. So, it will be a
>>>>> reasonable start to consider the protocol to control accesses
>>>>> from clients; typically web applications.
>>>>>
>>>>>      http://github.com/memcached/memcached/blob/master/doc/protocol.txt
>>>>>
>>>>> 1) new permissions
>>>>>
>>>>> This patch adds 'kv_item' class with the following permissions
>>>>>     - create
>>>>>     - getattr
>>>>>     - setattr
>>>>>     - remove
>>>>>     - relabelfrom
>>>>>     - relabelto
>>>>>     - read
>>>>>     - write
>>>>>     - append
>>>>>     - calculate
>>>>>
>>>>>       Most of permission works as literal.
>>>>>       On the 'SET' or 'CAS' operations, it creates a new item when here
>>>>>       is no items with same kye. In this case, 'create' permission shall
>>>>>       be checked. Elsewhere, 'write' permission shall be checked on the
>>>>>       existing items.
>>>>>
>>>>>       When an item get expired, it shall be unlinked internally. In this
>>>>>       case, no permissions are checked, because it does not work according
>>>>>       to the user's request.
>>>>>
>>>>>       On the 'FLUSH_ALL' operation, it unlinks any items older than
>>>>>       a certain watermark. In this case, 'remove' permission shall be
>>>>>       checked on the items to be unlinked. If violated, it skips to
>>>>>       unlink this item.
>>>>>
>>>>>       On 'INCR' or 'DECR' operation, 'calculate' permission shall be checked.
>>>>>       Is it necessary to distinguish between 'INCR' and 'DECR' here?
>>>>>       E.g, an item which can be incremented, but unavailable to decrement.
>>>>>
>>>>> 2) new types
>>>>>     - memcached_db_t
>>>>>       Some of modular memcached engines support on-disk storage, not only
>>>>>       volatile ram. The selinux_engine.so allows us to use a certain file
>>>>>       as a backend storage, but existing policy does not have definition
>>>>>       of data file type. This type allows memcached_t read/write accesses.
>>>>>
>>>>>     - memcached_item_t         (default of unconfined domain)
>>>>>     - memcached_ro_item_t
>>>>>     - memcached_secret_item_t
>>>>>     - user_memcached_item_t    (default of rbac domain)
>>>>>     - unpriv_memcached_item_t  (default of unprivileged domain)
>>>>>       These are types of individual key-value items.
>>>>>       The three default types are read-writable for its domains,
>>>>>       memcached_ro_item_t is read-only for confined domains, and
>>>>>       memcached_secret_t is invisible from confined domains.
>>>>>
>>>>> 3) supplemental policies
>>>>>     - This patch also adds permission on memcached_t to communicate with
>>>>>       SELinux using netlink socket and selinuxfs.
>>>>>     - This patch also adds permission on memcached_t to write out audit
>>>>>       logs onto auditd daemon, although it is not implemented yet.
>>>>>
>>>>> Thanks, Any comments please.
>>>>
>>
>>
> 
> 


-- 
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------020708090101050807030303
Content-Type: text/x-patch;
 name="refpolicy-memcached.2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="refpolicy-memcached.2.patch"

diff --git a/policy/flask/access_vectors b/policy/flask/access_vectors
index 6760c95..f6b82a2 100644
--- a/policy/flask/access_vectors
+++ b/policy/flask/access_vectors
@@ -816,3 +816,16 @@ inherits x_device
 
 class x_keyboard
 inherits x_device
+
+class kv_item
+{
+	create
+	getattr
+	setattr
+	remove
+	relabelfrom
+	relabelto
+	read
+	write
+	append
+}
diff --git a/policy/flask/security_classes b/policy/flask/security_classes
index fa65db2..9ace105 100644
--- a/policy/flask/security_classes
+++ b/policy/flask/security_classes
@@ -125,4 +125,7 @@ class tun_socket
 class x_pointer			# userspace
 class x_keyboard		# userspace
 
+# key-value-store, such as memcached
+class kv_item			# userspace
+
 # FLASK
diff --git a/policy/mcs b/policy/mcs
index af90ef2..0d762fa 100644
--- a/policy/mcs
+++ b/policy/mcs
@@ -132,4 +132,13 @@ mlsconstrain db_procedure { drop getattr setattr execute install }
 mlsconstrain db_blob { drop getattr setattr relabelfrom read write import export }
 	( h1 dom h2 );
 
+#
+# MCS policy for key-value items with SELinux support
+#
+mlsconstrain kv_item { create relabelto }
+	(( h1 dom h2 ) and ( l2 eq h2 ));
+
+mlsconstrain kv_item { getattr setattr remove read write append }
+	( h1 dom h2 );
+
 ') dnl end enable_mcs
diff --git a/policy/mls b/policy/mls
index b9f0a3e..9b9e955 100644
--- a/policy/mls
+++ b/policy/mls
@@ -827,4 +827,42 @@ mlsvalidatetrans { db_database db_table db_procedure db_column db_tuple db_blob
 	  (( t3 == mlsdbdowngrade ) and ( h1 dom h2 )) or
 	  (( t3 == mlsdbdowngrade ) and ( h1 incomp h2 ))));
 
+#
+# MLS policy for key-value store
+#
+
+# make sure kv_item has single level
+mlsconstrain { kv_item } { create relabelto }
+	( l2 eq h2 );
+
+# new label must be dominated by the subjects clearance
+mlsconstrain { kv_item } { relabelto }
+	( h1 dom h2 );
+
+# the key-value item "read" operations
+mlsconstrain { kv_item } { getattr read }
+	(( l1 dom l2 ) or
+	 (( t1 == mlsdbreadtoclr ) and ( h1 dom l2 )) or
+	  ( t1 == mlsdbread ) or
+	  ( t2 == mlstrustedobject ));
+
+# the key-value item "write" operations
+mlsconstrain { kv_item } { create remove setattr write append }
+	(( l1 eq l2 ) or
+	 (( t1 == mlsdbwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
+	 (( t2 == mlsdbwriteinrange ) and ( l1 dom l2 ) and ( h1 domby h2 )) or
+	 ( t1 == mlsdbwrite ) or
+	 ( t2 == mlstrustedobject ));
+
+# the key-value item upgrade/downgrade rule
+mlsvalidatetrans { kv_item }
+	((( l1 eq l2 ) or
+	  (( t3 == mlsdbupgrade ) and ( l1 domby l2 )) or
+	  (( t3 == mlsdbdowngrade ) and ( l1 dom l2 )) or
+	  (( t3 == mlsdbdowngrade ) and ( l1 incomp l2 ))) and
+	 (( l1 eq h2 ) or
+	  (( t3 == mlsdbupgrade ) and ( h1 domby h2 )) or
+	  (( t3 == mlsdbdowngrade ) and ( h1 dom h2 )) or
+	  (( t3 == mlsdbdowngrade ) and ( h1 incomp h2 ))));
+
 ') dnl end enable_mls
diff --git a/policy/modules/roles/staff.te b/policy/modules/roles/staff.te
index a589c55..cfde531 100644
--- a/policy/modules/roles/staff.te
+++ b/policy/modules/roles/staff.te
@@ -23,6 +23,10 @@ optional_policy(`
 ')
 
 optional_policy(`
+	memcached_role(staff_r, staff_t)
+')
+
+optional_policy(`
 	postgresql_role(staff_r, staff_t)
 ')
 
diff --git a/policy/modules/roles/unprivuser.te b/policy/modules/roles/unprivuser.te
index e8a507d..dae1d40 100644
--- a/policy/modules/roles/unprivuser.te
+++ b/policy/modules/roles/unprivuser.te
@@ -17,6 +17,10 @@ optional_policy(`
 ')
 
 optional_policy(`
+	memcached_role(user_r, user_t)
+')
+
+optional_policy(`
 	screen_role_template(user, user_r, user_t)
 ')
 
diff --git a/policy/modules/services/apache.if b/policy/modules/services/apache.if
index c9e1a44..05cee50 100644
--- a/policy/modules/services/apache.if
+++ b/policy/modules/services/apache.if
@@ -175,6 +175,14 @@ template(`apache_content_template',`
 	')
 
 	optional_policy(`
+		memcached_unpriv_client(httpd_$1_script_t)
+
+		tunable_policy(`httpd_enable_cgi && httpd_can_network_connect_db',`
+			memcached_tcp_connect(httpd_$1_script_t)
+		')
+	')
+
+	optional_policy(`
 		tunable_policy(`httpd_enable_cgi && allow_ypbind',`
 			nis_use_ypbind_uncond(httpd_$1_script_t)
 		')
diff --git a/policy/modules/services/apache.te b/policy/modules/services/apache.te
index e33b9cd..da1b513 100644
--- a/policy/modules/services/apache.te
+++ b/policy/modules/services/apache.te
@@ -570,6 +570,16 @@ optional_policy(`
 ')
 
 optional_policy(`
+	# Allow httpd to work with memcached
+	memcached_stream_connect(httpd_t)
+	memcached_unpriv_client(httpd_t)
+
+	tunable_policy(`httpd_can_network_connect_db',`
+		memcached_tcp_connect(httpd_t)
+	')
+')
+
+optional_policy(`
 	openca_domtrans(httpd_t)
 	openca_signal(httpd_t)
 	openca_sigstop(httpd_t)
diff --git a/policy/modules/services/memcached.if b/policy/modules/services/memcached.if
index db4fd6f..6e410c2 100644
--- a/policy/modules/services/memcached.if
+++ b/policy/modules/services/memcached.if
@@ -71,3 +71,148 @@ interface(`memcached_admin',`
 
 	admin_pattern($1, memcached_var_run_t)
 ')
+
+########################################
+## <summary>
+##	Marks as a memcached key/value item type
+## </summary>
+## <param name="type">
+##	<summary>
+##	Type marked as a memcached key/value item type.
+##	</summary>
+## </param>
+#
+interface(`memcached_item_object',`
+	gen_require(`
+		attribute memcached_item_type;
+	')
+
+	typeattribute $1 memcached_item_type;
+')
+
+########################################
+## <summary>
+##	Allow the specified domain to connect to memcached with a tcp socket.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`memcached_tcp_connect',`
+	gen_require(`
+		type memcached_t;
+	')
+
+	corenet_tcp_recvfrom_labeled($1, memcached_t)
+	corenet_tcp_sendrecv_memcache_port($1)
+	corenet_tcp_connect_memcache_port($1)
+	corenet_sendrecv_memcache_client_packets($1)
+')
+
+########################################
+## <summary>
+##	Allow the specified domain to connect to memcached with a unix socket.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <rolecap/>
+#
+interface(`memcached_stream_connect',`
+	gen_require(`
+		type memcached_t;
+		type memcached_var_run_t;
+	')
+
+	files_search_pids($1)
+	allow $1 memcached_t:unix_stream_socket connectto;
+	# we recommend to put the sock file in /var/run/memcached
+	rw_sock_files_pattern($1, memcached_var_run_t, memcached_var_run_t)
+')
+
+########################################
+## <summary>
+##	Allow the specified domain unconfined accesses to any memcached items.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`memcached_unconfined',`
+	gen_require(`
+		attribute memcached_unconfined_type;
+	')
+	typeattribute $1 memcached_unconfined_type;
+')
+
+#######################################
+## <summary>
+##	Role access to memcached with SELinux suport
+## </summary>
+## <param name="user_role">
+##	<summary>
+##	The role associated with the user domain.
+##	</summary>
+## </param>
+## <param name="user_domain">
+##	<summary>
+##	The type of the user domain.
+##	</summary>
+## </param>
+#
+interface(`memcached_role',`
+	gen_require(`
+		class kv_item all_kv_item_perms;
+
+		attribute memcached_client_type;
+		type memcached_t;
+		type user_memcached_item_t;
+	')
+
+	########################################
+	#
+	# Client local policy
+	#
+	typeattribute $2 memcached_client_type;
+
+	type_transition $2 memcached_t:kv_item user_memcached_item_t;
+
+	allow $2 user_memcached_item_t:kv_item { create getattr setattr remove read write append };
+')
+
+########################################
+## <summary>
+##	Allow the specified domain unprivileged accesses to unifined key-value
+##	items managed by memcached with SELinux support.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`memcached_unpriv_client',`
+        gen_require(`
+		class kv_item all_kv_item_perms;
+
+		attribute memcached_client_type;
+		type memcached_t;
+		type unpriv_memcached_item_t;
+	')
+
+	########################################
+	#
+	# Client local policy
+	#
+	typeattribute $1 memcached_client_type;
+
+	type_transition $1 memcached_t:kv_item unpriv_memcached_item_t;
+
+	allow $1 unpriv_memcached_item_t:kv_item { create getattr setattr remove read write };
+')
diff --git a/policy/modules/services/memcached.te b/policy/modules/services/memcached.te
index b681608..5e7e763 100644
--- a/policy/modules/services/memcached.te
+++ b/policy/modules/services/memcached.te
@@ -15,6 +15,33 @@ init_script_file(memcached_initrc_exec_t)
 type memcached_var_run_t;
 files_pid_file(memcached_var_run_t)
 
+type memcached_db_t;
+files_type(memcached_db_t)
+
+# memcached clients
+attribute memcached_client_type;
+attribute memcached_unconfined_type;
+
+# memcached key/value items
+attribute memcached_item_type;
+
+type memcached_item_t;
+memcached_item_object(memcached_item_t)
+
+type memcached_ro_item_t;
+memcached_item_object(memcached_ro_item_t)
+
+type memcached_secret_item_t;
+memcached_item_object(memcached_secret_item_t)
+
+type user_memcached_item_t;
+typealias user_memcached_item_t alias { staff_memcached_item_t sysadm_memcached_item_t };
+typealias user_memcached_item_t alias { auditadm_memcached_item_t secadm_memcached_item_t };
+memcached_item_object(user_memcached_item_t)
+
+type unpriv_memcached_item_t;
+memcached_item_object(unpriv_memcached_item_t)
+
 ########################################
 #
 # memcached local policy
@@ -27,6 +54,7 @@ allow memcached_t self:tcp_socket create_stream_socket_perms;
 allow memcached_t self:udp_socket { create_socket_perms listen };
 allow memcached_t self:fifo_file rw_fifo_file_perms;
 allow memcached_t self:unix_stream_socket create_stream_socket_perms;
+allow memcached_t self:netlink_selinux_socket create_socket_perms;
 
 corenet_all_recvfrom_unlabeled(memcached_t)
 corenet_udp_sendrecv_generic_if(memcached_t)
@@ -42,17 +70,41 @@ corenet_udp_bind_memcache_port(memcached_t)
 
 manage_dirs_pattern(memcached_t, memcached_var_run_t, memcached_var_run_t)
 manage_files_pattern(memcached_t, memcached_var_run_t, memcached_var_run_t)
+manage_sock_files_pattern(memcached_t, memcached_var_run_t, memcached_var_run_t)
 files_pid_filetrans(memcached_t, memcached_var_run_t, { file dir })
 
+manage_files_pattern(memcached_t, memcached_db_t, memcached_db_t)
+
 kernel_read_kernel_sysctls(memcached_t)
 kernel_read_system_state(memcached_t)
 
 files_read_etc_files(memcached_t)
 
+selinux_get_enforce_mode(memcached_t)
+selinux_validate_context(memcached_t)
+selinux_compute_access_vector(memcached_t)
+selinux_compute_create_context(memcached_t)
+selinux_compute_relabel_context(memcached_t)
+
 term_dontaudit_use_all_ptys(memcached_t)
 term_dontaudit_use_all_ttys(memcached_t)
 term_dontaudit_use_console(memcached_t)
 
 auth_use_nsswitch(memcached_t)
 
+logging_send_audit_msgs(memcached_t)
+
 miscfiles_read_localization(memcached_t)
+
+########################################
+#
+# Rules to managed items by memcached with SELinux support
+#
+gen_require(`
+	class kv_item all_kv_item_perms;
+')
+
+allow memcached_client_type memcached_item_t:kv_item { getattr setattr read write append };
+allow memcached_client_type memcached_ro_item_t:kv_item { getattr read };
+type_transition memcached_unconfined_type memcached_t:kv_item memcached_item_t;
+allow memcached_unconfined_type memcached_item_type:kv_item *;
diff --git a/policy/modules/system/unconfined.if b/policy/modules/system/unconfined.if
index 416e668..01bec5d 100644
--- a/policy/modules/system/unconfined.if
+++ b/policy/modules/system/unconfined.if
@@ -77,6 +77,10 @@ interface(`unconfined_domain_noaudit',`
 	')
 
 	optional_policy(`
+		memcached_unconfined($1)
+	')
+
+	optional_policy(`
 		nscd_unconfined($1)
 	')
 
diff --git a/policy/modules/system/userdomain.if b/policy/modules/system/userdomain.if
index 8b4f6d8..ce33925 100644
--- a/policy/modules/system/userdomain.if
+++ b/policy/modules/system/userdomain.if
@@ -626,6 +626,11 @@ template(`userdom_common_user_template',`
 		locate_read_lib_files($1_t)
 	')
 
+	optional_policy(`
+		memcached_stream_connect($1_t)
+		memcached_tcp_connect($1_t)
+	')
+
 	# for running depmod as part of the kernel packaging process
 	optional_policy(`
 		modutils_read_module_config($1_t)
@@ -1159,6 +1164,10 @@ template(`userdom_admin_user_template',`
 	')
 
 	optional_policy(`
+		memcached_unconfined($1_t)
+	')
+
+	optional_policy(`
 		postgresql_unconfined($1_t)
 	')
 

--------------020708090101050807030303--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
