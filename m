Content-Type: text/plain;
  charset="us-ascii"
From: Brian Fegler <fegler@bigfoot.com>
Reply-To: fegler@bigfoot.com
To: SELinux@tycho.nsa.gov
Subject: rule analyzer
Date: Fri, 18 Oct 2002 11:50:49 -0600
MIME-Version: 1.0
Message-Id: <200210181150.49348.fegler@bigfoot.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I wrote a short rule analyzer. It works off of a policy.conf file. I know a 
couple already exist, but I wanted a script that was a stand alone file, and 
had full functionality from the command line.

It is primative, but it gets the job done. In a nutshell, it shows what 
can access what. (doesn't show type_transitions or anything else yet). 

I've been using it for awhile, but figured I should spruce it up a bit, throw 
it out there, and get some feedback. 

If it's used there are a few things I wouldn't mind adding (see todo list).  

Feedback and comments are welcome. 

Here are a few examples. (the name of the program is cando - as in what 
"cando" what). "..." added for readability.

###################################
cando --dst=user_gpg_secret
sysadm_gpg_t
    user_gpg_secret_t
        dir          { rename create write getattr remove_name... }
        file         { rename create write getattr ioctl append... } 

user_gpg_t
    user_gpg_secret_t
        dir          { rename create write getattr remove_name... }

user_t
    user_gpg_secret_t
        dir          { write getattr remove_name search setattr read... }
        file         { getattr }


###################################
cando --src=user_t --dst=var.*
user_t
        var_lib_nfs_t
                dir          { read lock access getattr ioctl search poll }
        var_lib_rpm_t
                dir          { read lock access getattr ioctl search poll }
        var_lib_t
                dir          { read lock access getattr ioctl search poll }
        var_lock_t
                dir          { read lock access getattr ioctl search poll }
        var_log_sa_t
                dir          { read lock access getattr ioctl search poll }
        var_log_t
                dir          { read lock access getattr ioctl search poll }
        var_run_t
                dir          { read lock access getattr ioctl search poll }
        var_spool_t
                dir          { read lock access getattr ioctl search poll }
        var_t
                dir          { read lock access getattr ioctl search poll }
        var_yp_t
                dir          { read lock access getattr ioctl search poll }


###################################
cando --src=bootloader_t --dst=boot -d
bootloader_t
        boot_t
                dir          { write getattr remove_name search read...
        bootloader_exec_t
                file         { getattr ioctl read execute lock...
        bootloader_tmp_t
                dir          { rename create write getattr remove_name...
        etc_bootloader_t
                file         { getattr ioctl read lock access poll }


###################################
(-s means short -a means align)
cando  --src=httpd --dst=^user -sa
allow httpd_t                     user_home_t: dir       { search };
allow httpd_t                     user_home_t: file      { read getattr };
allow httpd_user_script_process_t user_home_t: dir       { getattr search };
allow httpd_user_script_process_t user_t:      fd        { use };
allow httpd_user_script_process_t user_t:      fifo_file { write getattr ... 
};
allow httpd_user_script_process_t user_t:      process   { sigchld };


###################################
cando --dst=bin_t --class=file --perm=execute --l=1

this will show all of the domains that can execute a file of type bin_t


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
