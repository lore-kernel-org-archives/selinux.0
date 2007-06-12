Subject: Re: [RFC][PATCH] selinux:  enable authoritative granting of
	capabilities
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serue@us.ibm.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <1181591750.8805.151.camel@moss-spartans.epoch.ncsc.mil>
References: <1181591750.8805.151.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-LqS5FqoefeMJB31jNqj2"
Date: Tue, 12 Jun 2007 09:24:48 -0400
Message-Id: <1181654688.17547.110.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-LqS5FqoefeMJB31jNqj2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2007-06-11 at 15:55 -0400, Stephen Smalley wrote:
> Extend SELinux to allow capabilities to be granted authoritatively.
> Introduces a new cap_override access vector to indicate when the
> secondary module (i.e. capability or dummy) check should be skipped.
> Handle the new class gracefully even if the policy does not yet have
> it defined.

For people who want to test/experiment with this kernel patch, below is
the policy patch I used to define the new class and permissions (it also
includes the previously added memprotect class since that hasn't been
added upstream yet).  If you rebuild your base policy with this patch
(e.g. grab the source package, add this patch, rebuild and reinstall),
then you can subsequently create loadable policy modules that use the
new cap_override permissions for testing.

-- 
Stephen Smalley
National Security Agency

--=-LqS5FqoefeMJB31jNqj2
Content-Disposition: attachment; filename=policy-capoverride.diff
Content-Type: text/x-patch; name=policy-capoverride.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

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

--=-LqS5FqoefeMJB31jNqj2--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
