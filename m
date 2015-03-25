Message-ID: <5512FAC8.8070300@tycho.nsa.gov>
Date: Wed, 25 Mar 2015 14:13:28 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Tracy Reed <treed@ultraviolet.org>, selinux@tycho.nsa.gov
Subject: Re: Is there a macro for this?
References: <20150325015752.GG32173@tracyreed.org>
In-Reply-To: <20150325015752.GG32173@tracyreed.org>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/24/2015 09:57 PM, Tracy Reed wrote:
> I've written my own policy to confine a custom in-house developed
> service.  I am getting the following denials. I'm pretty sure there is a
> macro or macros I can use to allow all of these common sorts of things to
> happen as I'm pretty sure I used it a few years ago but I can't recall or
> find it. Can anyone point me in the right direction?
> 
> Thanks!

Did you try using audit2allow -R?
Also, your question is more suited to the refpolicy list.

> 
> #============= initrc_t ==============
> allow initrc_t myapp_cid_t:dir { getattr search };
> allow initrc_t myapp_cid_t:file { read getattr open };
> allow initrc_t myapp_java_t:dir { getattr search };
> 
> #============= locate_t ==============
> allow locate_t myapp_bin_t:dir getattr;
> allow locate_t myapp_cid_t:dir { read search open getattr };
> allow locate_t myapp_include_t:dir { getattr search };
> allow locate_t myapp_java_t:dir { read getattr open search };
> allow locate_t myapp_lib64_t:dir { read search open getattr };
> allow locate_t myapp_lib_t:dir { read getattr open search };
> allow locate_t myapp_logs_t:dir { read search open getattr };
> allow locate_t myapp_node_api_t:dir getattr;
> allow locate_t myapp_node_bin_t:dir getattr;
> allow locate_t myapp_node_conf_t:dir { getattr search };
> allow locate_t myapp_node_incoming-dist_t:dir getattr;
> allow locate_t myapp_node_lib_t:dir { getattr search };
> allow locate_t myapp_node_logs_t:dir getattr;
> allow locate_t myapp_node_scripts_t:dir getattr;
> allow locate_t myapp_node_tomcat_t:dir { read getattr open search };
> allow locate_t myapp_node_util_t:dir getattr;
> allow locate_t myapp_node_var_t:dir getattr;
> allow locate_t myapp_node_webapps_t:dir { read getattr open search };
> allow locate_t myapp_runbooktmp_t:dir getattr;
> allow locate_t myapp_share_t:dir { read getattr open search };
> allow locate_t myapp_snc-provision_t:dir { read getattr open search };
> allow locate_t myapp_temp_t:dir getattr;
> 
> #============= logrotate_t ==============
> allow logrotate_t var_t:file getattr;
> 
> #============= rpm_t ==============
> allow rpm_t myapp_bin_t:dir { getattr search };
> allow rpm_t myapp_bin_t:file { read getattr open };
> allow rpm_t myapp_bin_t:lnk_file { read getattr };
> allow rpm_t myapp_cid_t:dir { search getattr };
> allow rpm_t myapp_cid_t:file { read getattr open };
> allow rpm_t myapp_include_t:dir { getattr search };
> allow rpm_t myapp_include_t:file { read getattr open };
> allow rpm_t myapp_java_t:dir { getattr search };
> allow rpm_t myapp_java_t:file { read getattr open };
> allow rpm_t myapp_java_t:lnk_file { read getattr };
> allow rpm_t myapp_lib64_t:dir { getattr search };
> allow rpm_t myapp_lib64_t:file { read getattr open };
> allow rpm_t myapp_lib_t:dir { search getattr };
> allow rpm_t myapp_lib_t:file { read getattr open };
> allow rpm_t myapp_lib_t:lnk_file { read getattr };
> allow rpm_t myapp_logs_t:dir getattr;
> allow rpm_t myapp_runbooktmp_t:dir getattr;
> allow rpm_t myapp_share_t:dir { getattr search };
> allow rpm_t myapp_share_t:file { read getattr open };
> allow rpm_t myapp_temp_t:dir getattr;
> 
> #============= system_cronjob_t ==============
> allow system_cronjob_t myapp_bin_t:dir { search getattr };
> allow system_cronjob_t myapp_bin_t:file { ioctl execute read open getattr execute_no_trans };
> allow system_cronjob_t myapp_bin_t:lnk_file { read getattr };
> allow system_cronjob_t myapp_include_t:dir search;
> allow system_cronjob_t myapp_include_t:file { read getattr open };
> allow system_cronjob_t myapp_lib64_t:dir { read search open getattr };
> allow system_cronjob_t myapp_lib64_t:file { read getattr open execute };
> allow system_cronjob_t myapp_lib_t:dir { read search open getattr };
> allow system_cronjob_t myapp_lib_t:file { read getattr open execute };
> allow system_cronjob_t myapp_logs_t:dir { read getattr open search };
> allow system_cronjob_t myapp_logs_t:lnk_file read;
> allow system_cronjob_t myapp_node_api_t:dir { read getattr open search };
> allow system_cronjob_t myapp_node_bin_t:dir { read getattr open search };
> allow system_cronjob_t myapp_node_conf_t:dir { read getattr open search };
> allow system_cronjob_t myapp_node_conf_t:file { read ioctl open getattr };
> allow system_cronjob_t myapp_node_myapp-release_t:file { read getattr open };
> allow system_cronjob_t myapp_node_incoming-dist_t:dir { read getattr open search };
> allow system_cronjob_t myapp_node_lib_t:dir { read getattr open search };
> allow system_cronjob_t myapp_node_logs_t:dir { read getattr open search };
> allow system_cronjob_t myapp_node_logs_t:file getattr;
> allow system_cronjob_t myapp_node_scripts_t:dir { read getattr open search };
> allow system_cronjob_t myapp_node_tomcat_t:dir { read getattr open search };
> allow system_cronjob_t myapp_node_util_t:dir { read getattr open search };
> allow system_cronjob_t myapp_node_var_t:dir { read getattr open search };
> allow system_cronjob_t myapp_node_webapps_t:dir { read getattr open search };
> 
> #============= unconfined_t ==============
> allow unconfined_t myapp_bin_t:dir { search getattr };
> allow unconfined_t myapp_bin_t:file { read getattr open execute execute_no_trans };
> allow unconfined_t myapp_bin_t:lnk_file { read getattr };
> allow unconfined_t myapp_include_t:dir search;
> allow unconfined_t myapp_include_t:file { read getattr open };
> allow unconfined_t myapp_lib64_t:dir { read search open getattr };
> allow unconfined_t myapp_lib64_t:file { read getattr open execute };
> allow unconfined_t myapp_lib_t:dir { read search open getattr };
> allow unconfined_t myapp_lib_t:file { read getattr open execute };
> allow unconfined_t myapp_node_bin_t:file getattr;
> allow unconfined_t myapp_node_conf_t:dir search;
> allow unconfined_t myapp_node_conf_t:file { read getattr open };
> allow unconfined_t myapp_node_webapps_t:dir search;
> #!!!! The source type 'unconfined_t' can write to a 'dir' of the following types:
> # user_home_dir_t, user_tmpfs_t, user_tmp_t, unlabeled_t, proc_type, sandbox_file_t, filesystem_type, user_home_type, sysctl_type, file_type, nfs_t
> 
> 
> 
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> 
