Message-ID: <3C1D871D.8020908@pcez.com>
Date: Sun, 16 Dec 2001 21:48:13 -0800
From: Shaun Savage <savages@pcez.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_homegate.savages.net-12121-1008568454-0001-2"
To: Paul Krumviede <pwk@acm.org>
CC: SELinux@tycho.nsa.gov
Subject: Re: iptables.te  errors
References: <3C1CE2BD.20707@pcez.com> <136657933.1008526709@localhost>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_homegate.savages.net-12121-1008568454-0001-2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Thanks it works

I have a iptables.te with some documentation.  Here is what I learned.
you need to add
role sysadm_r types DOMAIN_T
This allows the DOMAIN_T from sysadm_r role, the same for system_r

Allow the change from sysadm_t to DOMAIN_T
domain_auto_trans(sysadm_t, DOMAIN_EXEC_T,DOMAIN_T)
when execute a program of type DOMAIN_EXEC_T from sysadm_t
the new  domain is DOMAIN_T

Next allow input/output
allow DOMAIN_T sysadm_tty_device_t:chr_file rw_file_perms;
allow DOMAIN_T sysadm_devpts_t:chr_file rw_file_perms;
allow DOMAIN_T sysadm_gph_t:fd inherent_fd_perms;




Paul Krumviede wrote:

> --On Sunday, 16 December, 2001 10:06 -0800 Shaun Savage 
> <savages@pcez.com> wrote:
>
>> HI
>> I am having a hard time with getting courier to work that I decided to
>> try somwthing easier. iptables. Attached is the te file that I am using.
>> During make load I get the error
>>
>> security: context system_u:system_r:iptables_t is invalid
>
>
> iptables_t needs to be added to the allowed set of types
> for the system_r role. this can be done in policy/rbac or
> it can be added to iptables.te (i prefer the latter since
> it makes the .te file relatively self-contained, but at the
> expense of not having all the allowed types for a given
> role in one place to look at; tastes may vary).
>
>> the during the command iptables -t nat -L
>> I get the errors
>> avc: denied { create } for pid=9757 exe=/sbin/iptables
>> scontext=root:sysadmin_r:sysadmin_t tcontext=root_u:sysadm_r:sysadm_t
>> tclass=rawip_socket avc: denied { getopt } for pid=9757
>> exe=/sbin/iptables scontext=root:sysadmin_r:sysadmin_t
>> tcontext=root_u:sysadm_r:sysadm_t tclass=rawip_socket
>
>
> there is no rule to change the domain of the process when
> iptables is run in the system administrator role (nor does
> there seem to be domain transition rule for when ipchains
> is run by init). this could be added in policy/domains/admin/sysadm.te
> or in iptables.te (similarly, a domain transition rule could be added
> to policy/domains/system/initrc.te or to iptables.te).
>
> -paul
>
>



--=_homegate.savages.net-12121-1008568454-0001-2
Content-Type: text/plain; name="iptables.te"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="iptables.te"

#
# Authors:  Justin Smith <jsmith@mcs.drexel.edu>
#

# add iptables_t to system_r (from rbac)
role system_r types iptables_t;

# add iptable_t o sysadm_r (from rbac)
role sysadm_r types iptables_t;

# allow the admin to enter iptables_t domain (from sysadm.te)
domain_auto_trans(sysadm_t, iptables_exec_t, iptables_t)
# allow output (from sysadm.te)
allow iptables_t sysadm_tty_device_t:chr_file rw_file_perms;
allow iptables_t sysadm_devpts_t:chr_file rw_file_perms;
allow iptables_t sysadm_gph_t:fd inherit_fd_perms;
 
#
# Rules for the iptables_t domain.
#
type iptables_t, domain, privlog;
type iptables_exec_t, file_type, sysadmfile, exec_type;
type iptables_var_run_t, file_type, sysadmfile, pidfile;

# run insmod and ifconfig with new domain
domain_auto_trans(iptables_t, insmod_exec_t, insmod_t)
domain_auto_trans(iptables_t, ifconfig_exec_t, ifconfig_t)

# set pid files ( hold over from ipchains)
file_type_auto_trans(iptables_t, var_run_t, iptables_var_run_t)

# Inherit and use descriptors from init.
allow iptables_t init_t:fd inherit_fd_perms;

allow iptables_t bin_t:file { execute execute_no_trans };
allow iptables_t iptables_exec_t:file { execute_no_trans };
allow iptables_t iptables_t:capability { net_admin net_raw };
allow iptables_t iptables_t:rawip_socket { create setopt getopt };

--=_homegate.savages.net-12121-1008568454-0001-2--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
