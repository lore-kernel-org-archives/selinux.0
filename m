Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t2P4tnrs029261
 for <selinux@tycho.nsa.gov>; Wed, 25 Mar 2015 00:55:49 -0400
Received: by pdbop1 with SMTP id op1so16069092pdb.2
 for <selinux@tycho.nsa.gov>; Tue, 24 Mar 2015 21:55:47 -0700 (PDT)
Date: Wed, 25 Mar 2015 12:55:43 +0800
From: Jason Zaman <jason@perfinion.com>
To: Tracy Reed <treed@ultraviolet.org>
Subject: Re: Is there a macro for this?
Message-ID: <20150325045543.GA27174@meriadoc.perfinion.com>
References: <20150325015752.GG32173@tracyreed.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150325015752.GG32173@tracyreed.org>
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Mar 24, 2015 at 06:57:53PM -0700, Tracy Reed wrote:
> I've written my own policy to confine a custom in-house developed
> service.  I am getting the following denials. I'm pretty sure there is a
> macro or macros I can use to allow all of these common sorts of things to
> happen as I'm pretty sure I used it a few years ago but I can't recall or
> find it. Can anyone point me in the right direction?
> 
> Thanks!

Swift has some really useful bash functions to help find macros.
https://github.com/sjvermeu/small.coding/blob/master/selinux-local/localfuncs
it is documented a bit here:
https://wiki.gentoo.org/wiki/Project:SELinux/Development#Starting_from_scratch

> 
> #============= initrc_t ==============
> allow initrc_t myapp_cid_t:dir { getattr search };
> allow initrc_t myapp_cid_t:file { read getattr open };
read_files_pattern(initrc_t, myapp_cid_t, myapp_cid_t)
would cover those two lines above, but its best to find an interface
that will do part of that for you.

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
this likely has nothing to do with your app, you can probably remove it
safely.
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
the execute_no_trans means it will be executing without transitioning
into another domain, you should probably be making your own myapp_t and
do something like:
unconfined_domtrans_to(myapp_t, myapp_exec_t)
then you'll want to use manage/read_files_pattern and manage/list_dirs_patterns to
allow myapp_t to manage/readonly its files.

also if you make cronjob_t transition to the myapp_t domain then the
cronjob section could mostly be replaced with:
cron_system_entry(myapp_t, myapp_exec_t)

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
> -- 
> Tracy Reed



> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
