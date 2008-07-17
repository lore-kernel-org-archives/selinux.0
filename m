Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6HMdvsk017247
	for <selinux@tycho.nsa.gov>; Thu, 17 Jul 2008 18:39:57 -0400
Received: from an-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6HMdvDU022781
	for <selinux@tycho.nsa.gov>; Thu, 17 Jul 2008 22:39:57 GMT
Received: by an-out-0708.google.com with SMTP id d30so188472and.75
        for <selinux@tycho.nsa.gov>; Thu, 17 Jul 2008 15:39:56 -0700 (PDT)
Message-ID: <dd18b0c30807171539m772f87fh64f706e8f9cf0e9e@mail.gmail.com>
Date: Thu, 17 Jul 2008 22:39:56 +0000
From: "Justin Mattock" <justinmattock@gmail.com>
To: selinux@tycho.nsa.gov
Subject: firefox3
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm trying to tighten up firefox, from what I can see over here:
when I use firefox I usually change roles to  user_r
then run firefox. Now I noticed when I execute firefox in sysadm_r
firefox is able to start up(when in enforce mode).  I remember in the
past firefox would not
start in sysadm_r only user_r for me. Is there something I'm missing,
or is this something new. (below are the allow rules for firefox)

allow sysadm_xserver_t user_mozilla_t:shm { associate getattr read
unix_read unix_write write };
allow sysadm_xserver_t user_mozilla_tmpfs_t:file { read write };
allow sysadm_xserver_t user_mplayer_t:shm { associate getattr read
unix_read unix_write write };
allow sysadm_xserver_t user_mplayer_tmpfs_t:file { read write };
allow sysadm_xserver_t user_t:shm { associate getattr read unix_read
unix_write write };
allow sysadm_xserver_t user_tmpfs_t:file { read write };
allow user_mozilla_t apmd_t:dir { getattr search };
allow user_mozilla_t apmd_t:file read;
allow user_mozilla_t bluetooth_t:dir { getattr search };
allow user_mozilla_t bluetooth_t:file read;
allow user_mozilla_t crond_t:dir { getattr search };
allow user_mozilla_t crond_t:file read;
allow user_mozilla_t devpts_t:dir search;
allow user_mozilla_t gconf_etc_t:dir { getattr read search };
allow user_mozilla_t gconf_etc_t:file { getattr read };
allow user_mozilla_t getty_t:dir { getattr search };
allow user_mozilla_t getty_t:file read;
allow user_mozilla_t hald_t:dir { getattr search };
allow user_mozilla_t hald_t:file read;
allow user_mozilla_t init_t:dir { getattr search };
allow user_mozilla_t init_t:file read;
allow user_mozilla_t initrc_t:dir { getattr search };
allow user_mozilla_t initrc_t:file read;
allow user_mozilla_t initrc_var_run_t:dir search;
allow user_mozilla_t initrc_var_run_t:sock_file write;
allow user_mozilla_t kernel_t:dir { getattr search };
allow user_mozilla_t kernel_t:file read;
allow user_mozilla_t klogd_t:dir { getattr search };
allow user_mozilla_t klogd_t:file read;
allow user_mozilla_t lib_t:file execute_no_trans;
allow user_mozilla_t local_login_t:dir { getattr search };
allow user_mozilla_t local_login_t:file read;
allow user_mozilla_t newrole_t:dir { getattr search };
allow user_mozilla_t newrole_t:fd use;
allow user_mozilla_t newrole_t:file read;
allow user_mozilla_t newrole_t:lnk_file read;
allow user_mozilla_t staff_t:dir { getattr search };
allow user_mozilla_t staff_t:file read;
allow user_mozilla_t sysadm_gconf_home_t:dir { add_name getattr read
remove_name search write };
allow user_mozilla_t sysadm_gconf_home_t:file { append create getattr
read rename unlink write };
allow user_mozilla_t sysadm_home_dir_t:dir { getattr search };
allow user_mozilla_t sysadm_home_t:dir { add_name getattr read
remove_name search write };
allow user_mozilla_t sysadm_home_t:file { append create getattr read
rename unlink };
allow user_mozilla_t sysadm_mozilla_home_t:dir { add_name create
getattr read remove_name rmdir search write };
allow user_mozilla_t sysadm_mozilla_home_t:file { create getattr lock
read rename unlink write };
allow user_mozilla_t sysadm_mozilla_home_t:lnk_file { create unlink };
allow user_mozilla_t sysadm_sudo_t:dir { getattr search };
allow user_mozilla_t sysadm_sudo_t:file read;
allow user_mozilla_t sysadm_t:dir { getattr search };
allow user_mozilla_t sysadm_t:file read;
allow user_mozilla_t sysadm_t:lnk_file read;
allow user_mozilla_t sysadm_tty_device_t:chr_file getattr;
allow user_mozilla_t sysadm_xauth_home_t:file { getattr read };
allow user_mozilla_t sysadm_xserver_t:dir { getattr search };
allow user_mozilla_t sysadm_xserver_t:file read;
allow user_mozilla_t sysadm_xserver_t:unix_stream_socket connectto;
allow user_mozilla_t syslogd_t:dir { getattr search };
allow user_mozilla_t syslogd_t:file read;
allow user_mozilla_t system_dbusd_t:dir { getattr search };
allow user_mozilla_t system_dbusd_t:file read;
allow user_mozilla_t tmp_t:dir { add_name create remove_name rmdir
setattr write };
allow user_mozilla_t tmp_t:file { create getattr link lock read unlink write };
allow user_mozilla_t tmp_t:sock_file { create unlink write };
allow user_mozilla_t udev_t:dir { getattr search };
allow user_mozilla_t udev_t:file read;
allow user_mozilla_t user_devpts_t:chr_file { getattr ioctl read write };
allow user_mozilla_t user_t:dir { getattr search };
allow user_mozilla_t user_t:file read;
allow user_mozilla_t user_t:lnk_file read;
allow user_mozilla_t user_t:sem { associate getattr read setattr
unix_read unix_write write };
allow user_mozilla_t user_t:shm { associate getattr read setattr
unix_read unix_write write };
allow user_mozilla_t user_tmpfs_t:file { read write };
allow user_mozilla_t v4l_device_t:chr_file { read write };

###########make enableaudit

allow user_mozilla_t security_t:dir { getattr search };
allow user_mozilla_t security_t:file read;
allow user_mozilla_t security_t:filesystem getattr;
allow user_mozilla_t selinux_config_t:dir search;
allow user_mozilla_t selinux_config_t:file { getattr read };
allow user_mozilla_t tmp_t:dir read;

Is this safe?  should I comment out some of the allow rules
and if so which ones.
regards;


-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
