Message-ID: <45AFA11B.4090407@tresys.com>
Date: Thu, 18 Jan 2007 11:32:27 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [RFC] 4/4 - Hierarchal apache policy for reference policy (policy
 contexts)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Below is the policy contexts for labeling apache policy types.

Note that roles are essentially hardcoded here. We need a 
genhomedircon-like application to generate per-role contexts for more 
than just home directories. I can envision more user object managers 
having the need for per-role contexts (DBUS, for example, does) so we 
should probably come up with a general way of generating these. We 
haven't thought it through fully though, comments are welcome.

-------------------------------------------------------


type apache_t                
gen_context(system_u:object_r:apache_policy_t,s0)

type apache_t.staff_script        
gen_context(system_u:object_r:staff_apache_policy_t,s0)
type apache_t.staff_script_exec        
gen_context(system_u:object_r:staff_apache_policy_t,s0)
type apache_t.staff_content        
gen_context(system_u:object_r:staff_apache_policy_t,s0)
type apache_t.staff_htaccess        
gen_context(system_u:object_r:staff_apache_policy_t,s0)
type apache_t.staff_content.ro        
gen_context(system_u:object_r:staff_apache_policy_t,s0)
type apache_t.staff_content.rw        
gen_context(system_u:object_r:staff_apache_policy_t,s0)
type apache_t.staff_content.ra        
gen_context(system_u:object_r:staff_apache_policy_t,s0)

type apache_t.sysadm_script        
gen_context(system_u:object_r:sysadm_apache_policy_t,s0)
type apache_t.sysadm_script_exec    
gen_context(system_u:object_r:sysadm_apache_policy_t,s0)
type apache_t.sysadm_content        
gen_context(system_u:object_r:sysadm_apache_policy_t,s0)
type apache_t.sysadm_htaccess        
gen_context(system_u:object_r:sysadm_apache_policy_t,s0)
type apache_t.sysadm_content.ro        
gen_context(system_u:object_r:sysadm_apache_policy_t,s0)
type apache_t.sysadm_content.rw        
gen_context(system_u:object_r:sysadm_apache_policy_t,s0)
type apache_t.sysadm_content.ra        
gen_context(system_u:object_r:sysadm_apache_policy_t,s0)

type apache_t.user_script        
gen_context(system_u:object_r:user_apache_policy_t,s0)
type apache_t.user_script_exec        
gen_context(system_u:object_r:user_apache_policy_t,s0)
type apache_t.user_content        
gen_context(system_u:object_r:user_apache_policy_t,s0)
type apache_t.user_htaccess        
gen_context(system_u:object_r:user_apache_policy_t,s0)
type apache_t.user_content.ro        
gen_context(system_u:object_r:user_apache_policy_t,s0)
type apache_t.user_content.rw        
gen_context(system_u:object_r:user_apache_policy_t,s0)
type apache_t.user_content.ra        
gen_context(system_u:object_r:user_apache_policy_t,s0)



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
