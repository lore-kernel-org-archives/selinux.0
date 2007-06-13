Subject: Re: [RFC][PATCH] selinux:  enable authoritative granting of
	capabilities
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serue@us.ibm.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <1181747197.21771.5.camel@sgc.columbia.tresys.com>
References: <1181591750.8805.151.camel@moss-spartans.epoch.ncsc.mil>
	 <1181654688.17547.110.camel@moss-spartans.epoch.ncsc.mil>
	 <1181681436.17547.280.camel@moss-spartans.epoch.ncsc.mil>
	 <1181682766.17547.304.camel@moss-spartans.epoch.ncsc.mil>
	 <1181745113.17547.357.camel@moss-spartans.epoch.ncsc.mil>
	 <1181747197.21771.5.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 13 Jun 2007 11:28:35 -0400
Message-Id: <1181748515.17547.380.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-06-13 at 11:06 -0400, Christopher J. PeBenito wrote:
> On Wed, 2007-06-13 at 10:31 -0400, Stephen Smalley wrote:
> > Updated policy patch below, defines the new class and permissions,
> > and introduces an interface for allowing the cap_override permissions
> > that ensures that these domains are excluded from the set of domains
> > that can be controlled by unconfined domains.
> 
> [...]
> 
> > +interface(`domain_capoverride',`
> 
> I would probably call this domain_capability_override() or
> domain_cap_override(), maybe even domain_authoritative_caps().
> 
> > +	gen_require(`
> > +		attribute capoverride_domain_type;
> > +	')
> > +
> > +	typeattribute $1 capoverride_domain_type;
> > +
> > +	allow $1 self:cap_override $2;
> 
> I think it would be better to just have the allow rule in the TE file.
> Then you can put your cap_override and capability allow rules next to
> each other and see more clearly which ones are being overridden and
> which aren't.

Ok, so you'd prefer the patch below?
BTW, one other issue that I noticed is that this has a side effect if I
grant capoverride to any of the unconfined domains (not that one should
do that, but still), because it seems that unconfined domains are
implicitly picking up permissions to self through the allow
unconfined_domain_type domain: rules.  Seems like those should be
separated?

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
@@ -1254,3 +1254,21 @@
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
+##	Domain allowed to override capabilities.
+##	</summary>
+## </param>
+#
+interface(`domain_cap_override',`
+	gen_require(`
+		attribute cap_override_domain_type;
+	')
+
+	typeattribute $1 cap_override_domain_type;
+')
Index: refpolicy/policy/modules/kernel/domain.te
===================================================================
--- refpolicy/policy/modules/kernel/domain.te	(revision 2324)
+++ refpolicy/policy/modules/kernel/domain.te	(working copy)
@@ -15,6 +15,11 @@
 # Domains that are unconfined
 attribute unconfined_domain_type;
 
+# Domains that have capability overrides.
+attribute cap_override_domain_type;
+
+neverallow { domain -cap_override_domain_type } self:cap_override *;
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
+allow unconfined_domain_type { domain -cap_override_domain_type }:process ~{ transition dyntransition execmem execstack execheap };
 
+# More limited access to domains with capability overrides.
+allow unconfined_domain_type cap_override_domain_type:process { signull getsched getpgid getattr };
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
