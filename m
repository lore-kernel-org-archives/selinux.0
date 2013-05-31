Received: from [192.168.25.4] (moss-lions [192.168.25.4])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r4VIUHsM016774
	for <selinux@tycho.nsa.gov>; Fri, 31 May 2013 14:30:17 -0400
Message-ID: <51A8ECE1.4020504@tycho.nsa.gov>
Date: Fri, 31 May 2013 14:33:05 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
Subject: Role associated with an attribute is not being associated with all
 types having that attribute.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Short description:

webadm_r has the following rule: role webadm_r types httpd_script_domains;

Types are assigned this attribute only in the macro apache_content_template with 
the following rule: type httpd_$1_script_t, httpd_script_domains;

In the final policy, webadm_r is associated with only those types created in 
calls of apache_content_template from outside of an optional block.

If the type declarations are moved outside the optional block, then everything 
works.


Longer description:

The role webadm_r has the following rules in the policy.

role webadm_r;
role webadm_r types webadm_t;
role webadm_r types httpd_script_domains;
roleattribute webadm_r httpd_helper_roles;


I would expect webadm_r to have all types that have attribute httpd_script_domains.


By apol, these types are as follows:

httpd_script_domains (22 types)
     httpd_apcupsd_cgi_script_t  { domain httpd_script_domains }
     httpd_awstats_script_t  { domain httpd_script_domains }
     httpd_bugzilla_script_t  { domain httpd_script_domains }
     httpd_collectd_script_t  { domain httpd_script_domains }
     httpd_cvs_script_t  { domain httpd_script_domains }
     httpd_dspam_script_t  { domain httpd_script_domains }
     httpd_git_script_t  { domain httpd_script_domains nsswitch_domain }
     httpd_lightsquid_script_t  { domain httpd_script_domains }
     httpd_man2html_script_t  { domain httpd_script_domains }
     httpd_mediawiki_script_t  { domain httpd_script_domains }
     httpd_mojomojo_script_t  { domain httpd_script_domains }
     httpd_munin_script_t  { domain httpd_script_domains }
     httpd_nagios_script_t  { domain httpd_script_domains }
     httpd_nutups_cgi_script_t  { domain httpd_script_domains }
     httpd_prewikka_script_t  { domain httpd_script_domains nsswitch_domain }
     httpd_smokeping_cgi_script_t  { domain httpd_script_domains }
     httpd_squid_script_t  { domain httpd_script_domains }
     httpd_sys_script_t  { domain httpd_script_domains nsswitch_domain 
sepgsql_client_type }
     httpd_unconfined_script_t  { can_change_object_identity can_load_kernmodule 
can_read_shadow_passwords can_relabelto_binary_policy 
can_relabelto_shadow_passwords can_write_shadow_passwords 
corenet_unconfined_type devices_unconfined_type domain files_unconfined_type 
filesystem_unconfined_type httpd_script_domains kern_unconfined 
process_uncond_exempt selinux_unconfined_type sepgsql_unconfined_type 
set_curr_context storage_unconfined_type unconfined_domain_type x_domain 
xserver_unconfined_type }
     httpd_user_script_t  { domain httpd_script_domains sepgsql_client_type 
ubac_constrained_type }
     httpd_w3c_validator_script_t  { domain httpd_script_domains }
     httpd_webalizer_script_t  { domain httpd_script_domains }


But webadm_r only has 10 of these. (webadm_t and httpd_helper_t do not have the 
httpd_script_domains attribute)

webadm_r (12 types)
     httpd_awstats_script_t
     httpd_bugzilla_script_t
     httpd_collectd_script_t
     httpd_git_script_t
     httpd_helper_t
     httpd_man2html_script_t
     httpd_mediawiki_script_t
     httpd_mojomojo_script_t
     httpd_sys_script_t
     httpd_user_script_t
     httpd_w3c_validator_script_t
     webadm_t


The apache_content_template macro contains the type rule defining these types 
and adding the httpd_script_domains attribute.

In none of the instance where apache_content_template is called in an optional 
block is the type included in webadm_r. In every case where it is called outside 
an optional block, the type is included.

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
