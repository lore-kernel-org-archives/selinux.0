Message-ID: <004801c14af9$5d7ed5b0$68026c85@ilios104>
From: "Yuichi Nakamura" <ynakam@ori.hitachi-sk.co.jp>
To: "SELinuxML" <SELinux@tycho.nsa.gov>
References: <Pine.LNX.4.33.0109270904260.12723-100000@zorg.gw.tislabs.com>
Subject: Re: I can ' t use named on LSM-based Prototype. Why?
Date: Tue, 2 Oct 2001 13:19:01 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I could use named(bind 9.1.0) on SELinux-lsm. Named worked without option
"-u". When I used Stephen Smalley's patch(cap_stack.patch),it worked  with
option "-u". Thank you!

Chris Vance wrote:
>Has anyone on this list already created a policy for named?

The policy files for named which I used are following(for RH 7.1). I created
named.te and modified file_contexts,initrc.te,network.te,net_contexts,rbac.

################
#setfiles/file_contexts
/var/named(|/.*)      system_u:object_r:named_conf_t
/etc/named.conf       system_u:object_r:named_conf_t
/usr/sbin/named       system_u:object_r:named_exec_t

#########################
#policy/domains/system/named.te
#By Y.Nakamura

#named_t is general domain label and can communicate with syslog.
type named_t, domain, privlog;

#A type for /usr/sbin/named
type named_exec_t, file_type,sysadmfile, exec_type;

# A type for configuration files of named.
type named_conf_t, file_type,sysadmfile;

# A type for files in /var/run specific to named
type named_var_run_t, file_type, sysadmfile;

# Use capabilities. Surplus capabilities may be allowed.
allow named_t named_t:capability { setuid setgid net_bind_service };

# Inherit and use descriptors from init.
allow named_t init_t:fd inherit_fd_perms;

#Named can use network
can_network(named_t)

# Bind to the named port.
allow named_t named_port_t:udp_socket name_bind;

# Allow named_t to put a pid file in /var/run
file_type_auto_trans(named_t, var_run_t, named_var_run_t)

#named can append to log files.
allow named_t var_log_t:file ra_file_perms;

#read configuration files
allow named_t named_conf_t:file r_file_perms;
allow named_t named_conf_t:dir search;

#when sysadm_t runs named.
#Don't forget to add entry in rbac(role sysadm_r types{named_t}).
#domain_auto_trans(sysadm_t, named_exec_t,named_t)

########################
#policy/domains/system/initrc.te
domain_auto_trans(initrc_t, named_exec_t,named_t)

###################
#policy/types/network.te
type named_port_t,port_type;

###############
#policy/net_contexts
udp 53 system_u:object_r:named_port_t

##########
#policy/rbac
role system_r types {
 ....
 ....
 ....
 named_t   #added
};
#END

-------------------------------------
Yuichi Nakamura
Hitachi Software Engineering Co.,Ltd.
ynakam@ori.hitachi-sk.co.jp





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
