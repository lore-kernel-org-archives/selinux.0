From: =?utf-8?q?T=C3=B6r=C3=B6k_Edwin?= <edwin@gurde.com>
To: selinux@tycho.nsa.gov
Subject: Re: [2/4] Labeling only policy for fireflier (fireflier.pp)
Date: Mon, 1 May 2006 19:34:00 +0300
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        fireflier-devel@lists.sourceforge.net
References: <200604021240.21290.edwin@gurde.com> <1146079604.28745.183.camel@moss-spartans.epoch.ncsc.mil> <200605011917.54954.edwin@gurde.com>
In-Reply-To: <200605011917.54954.edwin@gurde.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200605011934.00791.edwin@gurde.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[this policy (together with the base in mail [1/4]) is intended for systems 
where there is no selinux by default. for selinux enabled systems i'll create 
modules to be used with reference policy, i'll send that in a separate mail 
when it will be ready]

Still I want to provide "some" protection against changing labels (it would be 
just too easy to escape protection, but only for root, right?)

So I implemented something similar to what selinuxutil.te does to protect the 
module store, and also restricted policy loading to only a few domains.
Also restricted policy loading/setbool/setenforce with booleans. Also 
restricted module loading, and rawio.

I didn't use the unconfined interfaces from the reference policy, since they 
allowed too much rights to programs (IMHO). So I modified them to fit my 
needs, and put them in unconfined_norelabel.if.

So nobody besides a domain with policymanager attribute can load policy, and 
nobody besides them are allowed to change the module store. 
Any bypasses?
Of course if somebody replaces load_policy he can load any policy (but that 
isn't possible with this policy, right?). If load_policy & friends aren't 
statically linked, than someone can bypass it by changing libc, and 
protecting against that brings me very close to strict policy. So let's 
assume that load_policy would be statically linked, and it would get a 
sanitized environment.

The module store is managed via semodule, so it has to have write access. The 
problem is whom I allow to execute semodule, because anybody doing that will 
override my policy. So I restricted transition to semanage_t only for 
policymanager domains.

Last I have a program named policymanager, that will generate the policy 
(doesn't exist yet). Obviously this will be the weakest link in the chain.
So in the end, I am not sure it is worth all this policy store protection, 
maybe I could do with a simpler policy.

Maybe just using auditallow&allow for loading policy protected with a boolean 
would be enough? (audit: so that the sysadmin thas the chance to know 
somebody changed the policy, if he uses remote logging, otherwise all is lost 
if somebody changes policy.) But then somebody could just replace the binary 
policy, and have it loaded automatically on next reboot?

(why i don't want too much protection against root: 
 - if somebody didn't have selinux, with fireflier 1.1.x somebody could just 
have deleted the iptables rules to bypass fireflier's protection. You can't 
get real protection against this, unless you use a strict policy,right?
Also I don't intend to make fireflier an selinux rule management tool,besides 
there are some nice tools from tresys that do that ;)
)




fireflier.te:
-----
policy_module(fireflier,0.1.0) 
########################################
#
# Declarations
#
gen_require(`
	      type file_t;
	      type sbin_t;
	      bool secure_mode_policyload;
	      bool secure_mode;
	      type selinux_config_t;
')
bool dac_override_audit true;

type fireflier_unconfined_t;

attribute can_unconfined_sockets;
attribute fireflier_unconfined_domain;
attribute has_restricted_sockets;

fireflier_unconfined(fireflier_unconfined_t,file_t,can_unconfined_sockets)
domain_auto_trans(fireflier_unconfined_domain,file_t,fireflier_unconfined_t)
kernel_domtrans_to(fireflier_unconfined_t,sbin_t)
neverallow fireflier_unconfined_t file_type:file {relabelfrom relabelto};

attribute policymanager;

gen_policymanager_type(load_policy)
gen_policymanager_type(boolset)
gen_policymanager_type(semanage)
gen_policymanager_type(restorecon)
gen_policymanager_type(policy_manager)
domain_auto_trans(fireflier_unconfined_domain,policy_manager_exec_t,policy_manager_t)

attribute policy_config;
type policy_config_t;
typeattribute policy_config_t policy_config;
typeattribute selinux_config_t policy_config;
#avoiding files_type(policy_config_t), because unconfined domains have access 
to all files
allow policy_config_t fs_t:filesystem associate;
allow selinux_config_t fs_t:filesystem associate;

type_transition domain policy_config_t:{dir file lnk_file} policy_config_t;
attribute can_relabelto_binary_policy;
neverallow ~can_relabelto_binary_policy policy_config_t:file relabelto;

type semanage_lock_t;
allow semanage_lock_t fs_t:filesystem associate;
allow load_policy_t semanage_lock_t:file rw_file_perms;
allow load_policy_t selinux_config_t:file rw_file_perms;
allow fireflier_unconfined_domain semanage_lock_t:file rw_file_perms;

typeattribute restorecon_t can_relabelto_binary_policy;
allow restorecon_t self:capability { dac_override dac_read_search fowner };
allow restorecon_t self:fifo_file rw_file_perms;
allow fireflier_unconfined_domain policy_config :dir r_dir_perms;
allow fireflier_unconfined_domain policy_config :file r_file_perms;
allow fireflier_unconfined_domain policy_config :lnk_file r_file_perms;
allow fireflier_unconfined_domain policy_config:dir search;

if(!secure_mode_policyload) {
	auditallow load_policy_t security_t:security {load_policy};
	allow load_policy_t security_t:security {load_policy};
	auditallow boolset_t security_t:security {setbool};
	allow boolset_t security_t:security {setbool};
	auditallow semanage_t policy_config_t:file { read write };
	allow semanage_t policy_config_t:file { read write lock create unlink 
rename};
	allow semanage_t selinux_config_t:file { read write lock create unlink 
rename};	
	allow semanage_t unlabeled_t:process sigchld;
	allow semanage_t policy_config_t:dir { read write getattr unlink create 
rename add_name remove_name rmdir};
	allow semanage_t selinux_config_t:dir { read write getattr unlink create 
rename add_name remove_name rmdir};
}
if(!secure_mode) {
	auditallow restorecon_t {selinux_config_t policy_config_t file_type}:{dir 
file} {relabelfrom relabelto};
	allow restorecon_t {selinux_config_t policy_config_t file_type}:{dir file} 
{relabelfrom relabelto};
}
#allow fireflier_unconfined_domain selinux_config_t:{dir file} *;


#from test_module

-----------
fireflier.if:
-------------
########################################
## <summary>
##      Make the specified domain unconfined.
##      Except that it does not allow it to change labels, and load policy
## </summary>
## <param name="domain">
##      <summary>
##      Domain to make unconfined.
##      </summary>
## </param>
## <param name="entrypoint">
##    <summary> 
##       File entry 
##    </summary>
## </param>
## <param name="attribute">
##    <summary> 
##       Attribute needed to get access to socket
##    </summary>
## </param>

#
interface(`fireflier_unconfined',`
        gen_require(`
            role system_r;
			attribute fireflier_unconfined_domain;
			type security_t;
			bool secure_mode;
			bool secure_mode_insmod;
			bool dac_override_audit;
        ')

        domain_type($1)
        domain_entry_file($1,$2)


        role system_r types $1;
		role user_r	  types $1;
		
		allow $1 self:capability ~{sys_module sys_rawio dac_override 
dac_read_search};
		if(!secure_mode && dac_override_audit) {
				 auditallow $1 self:capability {dac_override dac_read_search};
		}
		if (!secure_mode) {
		   allow $1 self:capability {dac_override dac_read_search};
		}
		
		allow $1 self:fifo_file create_file_perms;
		allow $1 self:process transition;
		allow $1 self:security ~{setenforce load_policy setbool setsecparam 
setcheckreqprot};
	 	allow $1 security_t:security ~{setenforce load_policy setbool setsecparam 
setcheckreqprot};
		
		kernel_unconfined_norelabel($1)
		kernel_load_module_safe($1)
		corenet_unconfined($1)
        dev_unconfined_norawio($1)
        domain_unconfined_norelabel($1)
        domain_dontaudit_read_all_domains_state($1)
        files_unconfined_norelabel($1)
        fs_unconfined_norelabel($1)

		typeattribute $1 $3;

		neverallow $1 domain:{file sock_file} {relabelfrom relabelto};
		neverallow ~$3 domain:{socket_class_set socket key_socket} *;
		
		allow $1 self:process execheap;
		allow $1 self:process execmem;
		allow $1 self:process execstack;
	        allow $1 self:{socket_class_set socket key_socket} *;
		
		allow $1 domain:process getattr;
		allow $1 device_t:{chr_file blk_file} getattr;
		allow $3 $1:{socket_class_set socket key_socket} *;
		typeattribute $1 fireflier_unconfined_domain;
')

########################################
## <summary>
##      Generates an unconfined domain.
##      Except that it does not allow it to change labels, and load policy
##      It will generate: $1_t,$1_exec_t,has_$1_socket_access
## </summary>
## <param name="domain">
##      <summary>
##		 Base name
##      </summary>
## </param>

#
interface(`fireflier_gen_unconfined_type',`
   gen_require(`
   		attribute has_restricted_sockets;
		type file_t;
		type fireflier_unconfined_t;
   ')
   type $1_t;
   type $1_exec_t;
   
   attribute has_$1_socket_access;
   files_type($1_exec_t)
   typeattribute $1_t has_restricted_sockets;
   fireflier_unconfined($1_t,$1_exec_t,has_$1_socket_access)
   domain_auto_trans(fireflier_unconfined_domain,$1_exec_t,$1_t)
#   domain_auto_trans($1_t,file_t,fireflier_unconfined_t)
')

########################################
## <summary>
## 	    Allows access for @domain to @restricted's sockets     
## </summary>
## <param name="domain">
##      <summary>
##		 The domain that needs access granted
##      </summary>
## </param>
## <param name="restricted">
##      <summary>
##		 The domain that has the restricted socket
##      </summary>
## </param>

#
interface(`allow_access_to_socket',`
    gen_require(`
    		 attribute has_$1_socket_access;
		 type $2_t;
    ')
    typeattribute $2_t has_$1_socket_access;
')

########################################
## <summary>
## 	    Unconfined type, that can modify the policy somehow
##	    Cannot be executed from other unconfined domains
## </summary>
## <param name="base">
##      <summary>
##		 The base name
##      </summary>

#
interface(`gen_policymanager_type',`
    gen_require(`
    		 attribute policymanager;
    ')
    type $1_t;
    type $1_exec_t;
   
    typeattribute $1_t policymanager;
    attribute has_$1_socket_access;
    fireflier_unconfined($1_t,$1_exec_t,has_$1_socket_access)
    neverallow ~policymanager $1_t:process transition;
    neverallow ~policymanager $1_exec_t:file {write unlink relabelfrom 
relabelto};
    domain_auto_trans(policymanager,$1_exec_t,$1_t)
')

---------------
fireflier.fc:
-------------
/etc/selinux/fireflier/modules/semanage.read.LOCK    --	
gen_context(system_u:object_r:semanage_lock_t,s0)
/etc/selinux/fireflier/modules/semanage.trans.LOCK   --	
gen_context(system_u:object_r:semanage_lock_t,s0)
/etc/selinux(/.*)?			gen_context(system_u:object_r:selinux_config_t,s0)
/etc/selinux/([^/]*/)?contexts(/.*)?                
gen_context(system_u:object_r:policy_config_t,s0)
/etc/selinux/([^/]*/)?policy(/.*)?	
gen_context(system_u:object_r:policy_config_t,s15:c0.c255)
/etc/selinux/([^/]*/)?seusers	--	
gen_context(system_u:object_r:selinux_config_t,s15:c0.c255)
/etc/selinux([^/]*/)?modules/(active|tmp|previous)(/.*)?     -- 
gen_context(system_u:object_r:policy_config_t,s0)
/etc/selinux/([^/]*/)?users(/.*)?	--	
gen_context(system_u:object_r:policy_config_t,s15:c0.c255)
/sbin/load_policy		--	gen_context(system_u:object_r:load_policy_exec_t,s0)
/usr/sbin/load_policy		--	gen_context(system_u:object_r:load_policy_exec_t,s0)
/sbin/restorecon		--	gen_context(system_u:object_r:restorecon_exec_t,s0)
/usr/sbin/semodule		--	gen_context(system_u:object_r:semanage_exec_t,s0)
/usr/sbin/setsebool	--	gen_context(system_u:object_r:boolset_exec_t,s0)
/usr/sbin/setenforce	--	gen_context(system_u:object_r:load_policy_exec_t,s0)

/usr/sbin/policymanager	-- 
gen_context(system_u:object_r:policy_manager_exec_t,s0)

unconfined_norelabel.if
----------
## <summary>fireflier policy generation</summary>
########################################
## <summary>
##      Unconfined access to devices, except rawio
## </summary>
## <param name="domain">
##      <summary>
##      Domain allowed access.
##      </summary>
## </param>
#
interface(`dev_unconfined_norawio',`
        gen_require(`
                attribute device_node, memory_raw_write, memory_raw_read;
                type mtrr_device_t;
        ')
	allow $1 device_node:{ dir lnk_file sock_file fifo_file blk_file chr_file} *;
        allow $1 mtrr_device_t:{ dir file } *;
')
########################################
## <summary>
##      Unconfined access to domains, except relabeling
## </summary>
## <param name="domain">
##      <summary>
##      The type of the process performing this action.
##      </summary>
## </param>
#
interface(`domain_unconfined_norelabel',`
        gen_require(`
                attribute domain, set_curr_context;
		attribute has_restricted_sockets;
        ')
        # Use/sendto/connectto sockets created by any domain.
        allow $1 {domain - has_restricted_sockets}:{ socket_class_set socket 
key_socket } *;

        # Use descriptors and pipes created by any domain.
        allow $1 domain:fd use;
        allow $1 domain:fifo_file rw_file_perms;

        # Act upon any other process.
        allow $1 domain:process ~{ transition dyntransition execmem execstack 
execheap setcurrent};

        # Create/access any System V IPC objects.
        allow $1 domain:{ sem msgq shm } *;
        allow $1 domain:msg { send receive };

        # For /proc/pid
        allow $1 domain:dir r_dir_perms;
        allow $1 {domain}:file r_file_perms;
        allow $1 domain:lnk_file r_file_perms;
')

########################################
## <summary>
##      Unconfined access to kernel module resources, except relabeling
## </summary>
## <param name="domain">
##      <summary>
##      Domain allowed access.
##      </summary>
## </param>
#
interface(`kernel_unconfined_norelabel',`
        gen_require(`
                type kernel_t, unlabeled_t, sysctl_t;
                attribute proc_type, sysctl_type;
                attribute kern_unconfined;
                attribute can_load_kernmodule, can_receive_kernel_messages;
        ')

        allow $1 proc_type:{ dir file } ~{relabelfrom relabelto};

        allow $1 sysctl_t:{ dir file } ~{relabelfrom relabelto};

        allow $1 kernel_t:system *;

        allow $1 unlabeled_t:dir_file_class_set ~{relabelfrom relabelto};
        allow $1 unlabeled_t:filesystem *;
        allow $1 unlabeled_t:association *;

        typeattribute $1 can_load_kernmodule, can_receive_kernel_messages;
        typeattribute $1 kern_unconfined;

        kernel_rw_all_sysctls($1)
')
########################################
## <summary>
##      Unconfined access to files, except relabeling
## </summary>
## <param name="domain">
##      <summary>
##      Domain allowed access.
##      </summary>
## </param>
#
interface(`files_unconfined_norelabel',`
        gen_require(`
                attribute file_type;
        ')

        # Create/access any file in a labeled filesystem;
        allow $1 file_type:{ file chr_file} ~{ execmod relabelfrom 
relabelto };
        allow $1 file_type:{ dir lnk_file fifo_file blk_file } *;
#	allow $1 {file_type -has_restricted_sockets}:sock_file *;
	allow $1 file_type:sock_file *;

        # Mount/unmount any filesystem with the context= option.
        allow $1 file_type:filesystem *;

        # Bind to any network address.
        # cjp: need to check this, I dont think this has any effect.
        allow $1 file_type:{ unix_stream_socket unix_dgram_socket } name_bind;

        allow $1 file_type:file execmod;
')

########################################
## <summary>
##      Unconfined access to filesystems, except relabeling
## </summary>
## <param name="domain">
##      <summary>
##      Domain allowed access.
##      </summary>
## </param>
#
interface(`fs_unconfined_norelabel',`
        gen_require(`
                attribute filesystem_type;
        ')

        allow $1 filesystem_type:filesystem ~{relabelfrom relabelto};

        # Create/access other files.  fs_type is to pick up various
        # pseudo filesystem types that are applied to both the filesystem
        # and its files.
        allow $1 filesystem_type:{ dir file lnk_file sock_file fifo_file } 
~{relabelfrom relabelto};
	allow $1 filesystem_type:{ blk_file chr_file } *;
')

########################################
## <summary>
##	Allows caller to load kernel modules, if !secure_mode_insmod
## </summary>
## <param name="domain">
##	<summary>
##	The process type to allow to load kernel modules.
##	</summary>
## </param>
#
interface(`kernel_load_module_safe',`
	gen_require(`
		attribute can_load_kernmodule;
	')
	if(!secure_mode_insmod) {
				allow $1 self:capability sys_module;
				}
				typeattribute $1 can_load_kernmodule;

')

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
