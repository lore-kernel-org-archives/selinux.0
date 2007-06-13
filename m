Subject: Re: [RFC][PATCH] selinux:  enable authoritative granting of
	capabilities
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serue@us.ibm.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <1181682766.17547.304.camel@moss-spartans.epoch.ncsc.mil>
References: <1181591750.8805.151.camel@moss-spartans.epoch.ncsc.mil>
	 <1181654688.17547.110.camel@moss-spartans.epoch.ncsc.mil>
	 <1181681436.17547.280.camel@moss-spartans.epoch.ncsc.mil>
	 <1181682766.17547.304.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 13 Jun 2007 10:31:53 -0400
Message-Id: <1181745113.17547.357.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-06-12 at 17:12 -0400, Stephen Smalley wrote:
> On Tue, 2007-06-12 at 16:50 -0400, Stephen Smalley wrote:
> > On Tue, 2007-06-12 at 09:24 -0400, Stephen Smalley wrote:
> > > On Mon, 2007-06-11 at 15:55 -0400, Stephen Smalley wrote:
> > > > Extend SELinux to allow capabilities to be granted authoritatively.
> > > > Introduces a new cap_override access vector to indicate when the
> > > > secondary module (i.e. capability or dummy) check should be skipped.
> > > > Handle the new class gracefully even if the policy does not yet have
> > > > it defined.
> > > 
> > > For people who want to test/experiment with this kernel patch, below is
> > > the policy patch I used to define the new class and permissions (it also
> > > includes the previously added memprotect class since that hasn't been
> > > added upstream yet).  If you rebuild your base policy with this patch
> > > (e.g. grab the source package, add this patch, rebuild and reinstall),
> > > then you can subsequently create loadable policy modules that use the
> > > new cap_override permissions for testing.
> > 
> > One thing to note is that the applicability of this approach under
> > targeted policy seems somewhat limited, as we have to ensure that a
> > DAC-unprivileged process in unconfined_t (like an ordinary user shell)
> > cannot ultimately gain unauthorized access to these capabilities granted
> > to another domain, but at present, confined domains are always at the
> > mercy of unconfined_t.
> 
> I suppose we would need to ensure that even the unconfined domains are
> not given certain permissions (e.g. ptrace, sig*, setsched) to any
+noatsecure
> domain that is allowed these overrides.  That should be equivalent to
> the same restrictions imposed by the file capabilities code.

Updated policy patch below, defines the new class and permissions,
and introduces an interface for allowing the cap_override permissions
that ensures that these domains are excluded from the set of domains
that can be controlled by unconfined domains.

Index: refpolicy/policy/flask/security_classes
===================================================================
--- refpolicy/policy/flask/security_classes	(revision 2324)
+++ refpolicy/policy/flask/security_classes	(working copy)
@@ -97,4 +97,8 @@
 
 class dccp_socket
 
+class memprotect
+
+class cap_override
+
 # FLASK
Index: refpolicy/policy/flask/access_vectors
===================================================================
--- refpolicy/policy/flask/access_vectors	(revision 2324)
+++ refpolicy/policy/flask/access_vectors	(working copy)
@@ -648,3 +648,47 @@
 	node_bind
 	name_connect
 }
+
+class memprotect
+{
+	mmap_zero
+}
+
+class cap_override
+{
+	# The capabilities are defined in include/linux/capability.h
+	# Care should be taken to ensure that these are consistent with
+	# those definitions. (Order matters)
+
+	chown           
+	dac_override    
+	dac_read_search 
+	fowner          
+	fsetid          
+	kill            
+	setgid           
+	setuid           
+	setpcap          
+	linux_immutable  
+	net_bind_service 
+	net_broadcast    
+	net_admin        
+	net_raw          
+	ipc_lock         
+	ipc_owner        
+	sys_module       
+	sys_rawio        
+	sys_chroot       
+	sys_ptrace       
+	sys_pacct        
+	sys_admin        
+	sys_boot         
+	sys_nice         
+	sys_resource     
+	sys_time         
+	sys_tty_config  
+	mknod
+	lease
+	audit_write
+	audit_control
+}
Index: refpolicy/policy/modules/kernel/domain.if
===================================================================
--- refpolicy/policy/modules/kernel/domain.if	(revision 2324)
+++ refpolicy/policy/modules/kernel/domain.if	(working copy)
@@ -1254,3 +1254,28 @@
 	typeattribute $1 can_change_object_identity;
 	typeattribute $1 set_curr_context;
 ')
+
+########################################
+## <summary>
+##	Ability to override capabilities.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <param name="capabilities">
+##	<summary>
+##	Capabilities that can be overridden.
+##	</summary>
+## </param>
+#
+interface(`domain_capoverride',`
+	gen_require(`
+		attribute capoverride_domain_type;
+	')
+
+	typeattribute $1 capoverride_domain_type;
+
+	allow $1 self:cap_override $2;
+')
Index: refpolicy/policy/modules/kernel/domain.te
===================================================================
--- refpolicy/policy/modules/kernel/domain.te	(revision 2324)
+++ refpolicy/policy/modules/kernel/domain.te	(working copy)
@@ -15,6 +15,11 @@
 # Domains that are unconfined
 attribute unconfined_domain_type;
 
+# Domains that have capability overrides.
+attribute capoverride_domain_type;
+
+neverallow { domain -capoverride_domain_type } self:cap_override *;
+
 # Domains that can set their current context
 # (perform dynamic transitions)
 attribute set_curr_context;
@@ -130,9 +135,12 @@
 allow unconfined_domain_type domain:fd use;
 allow unconfined_domain_type domain:fifo_file rw_file_perms;
 
-# Act upon any other process.
-allow unconfined_domain_type domain:process ~{ transition dyntransition execmem execstack execheap };
+# Act upon any other process that lacks capability overrides.
+allow unconfined_domain_type { domain -capoverride_domain_type }:process ~{ transition dyntransition execmem execstack execheap };
 
+# More limited access to domains with capability overrides.
+allow unconfined_domain_type capoverride_domain_type:process { signull getsched getpgid getattr };
+
 # Create/access any System V IPC objects.
 allow unconfined_domain_type domain:{ sem msgq shm } *;
 allow unconfined_domain_type domain:msg { send receive };


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
