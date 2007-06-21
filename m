Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5LHRLfZ013409
	for <selinux@tycho.nsa.gov>; Thu, 21 Jun 2007 13:27:21 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5LHRJjl021315
	for <selinux@tycho.nsa.gov>; Thu, 21 Jun 2007 17:27:19 GMT
Message-ID: <467AB4F2.6000104@redhat.com>
Date: Thu, 21 Jun 2007 13:27:14 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: As part of the merger of Strict and Targeted policy I have gone about
 reorganizing user definitions.
Content-Type: multipart/mixed;
 boundary="------------000802010002070405050803"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000802010002070405050803
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

One of my goals with the next version of policy is to allow the easy
creation of selinux users/roles.  I think the way that strict policy did
this was wrong, and led to user_t and staff_t being basically the same
role/type other then differences in home directory context, and the
ability to become sysadm_t.

Login Users:
My goal has been to create several "login" users.  Where I define a
login user as someone who is able to "login" to the system via one or
more of the  login programs (sshd, login, rshd, xdm).  Users I have defined.

guest_u - Login only via terminal or sshd.  No XWindows,  No Network, No
setuid apps.
xguest_u - Login via Xwindows only, No login via ssh, login...  No
Networking.
                    Three Booleans for xguest_mozilla_t
                    browser_xguest_transition  - Whether or not firefox
will transition/run
                    browser_xguest_readonly  - Read only on the Home
Dirs.  Write to directories labeled mozilla_rw_t
                    browser_xguest_readwrite Read/Write Home DIrectories.
                    One of the goals of this user is to also work with
pam_namespace, so that when the user logs out the homedirectory and /tmp
disappears.
                    Two possible users of this user would be with
switchuser,  Some comes up to you and asks to use your machine, you say
sure, switch to the guest account, let them do anything they want.  When
they are done you switch back, desctroying anything they might have left
behind.
                    Second example would be a kiosk/library public
machine.  Where all it runs is Mozilla.  User comes up to machine, hits
Ctrl-Alt-Backspace.  XWindows dies and automatically logs into machine
with browser running.

user_u  - Similar to current user except no transitions to setuid
applications (su, sudo, userhelper)  mozilla transition also optional.
Networking available.  Envisioned user would be a student or any user
who does not need root privs.

staff_u - Current policy is fine with optional mozilla transition.

Unconfined_u/system_u - Current unconfined user.

Any and all of the users should be able to run and inter-operate on the
machine at any time.

Root Users:

     One of the major goals of SELinux has always been to confine the
root user.  Up to now SELinux has done a good job of confining the
daemon applications that need to run as root.  If/when these become
compromized they are limited by least privledge.  No policy up to now
has been able to do is to confine the root logged in user.  We have
defined sysadm_t which is pretty close to unconfined_t and mls has
defined auditadm.  (secadm has also been defined, but really not used.)

With the release of selinux-policy-3.0.1 I am introducing the following
root user types

sysadm_t - Same as was in strict policy.  staff_t can can transition here

webadm_t - Root shell, can execute all bin programs. can start and stop
httpd, can manage all     files in all directories labeled with an http
file type.  Eventually this admin user should be able to manage the http
booleans

logadm_t - Root Shell, can execute all bin programs, can start and stop
syslog and audit daemons.  Can manage all files labeled with a logfile type.

Future root user types bindadm, dbadm, backupadm.

----------------------------------------------------------------------------------------------------------------------------------------
My goal with this was to find an easy way for users/third parties to
start to define user types,  we need several changes to the userdomain
interface file.

We need one interfaces to define the minimal requirements to get a
logged in user
userdom_unpriv_login_user


So the entire guest.te file is just

> policy_module(guest,1.0.0)
>
> userdom_unpriv_login_user(guest)


The xguest.te file is something like

> policy_module(xguest,1.0.0)
>
> userdom_unpriv_login_user(xguest)
> userdom_xwindows_client_template(xguest)
>
> optional_policy(`
>     ssh_per_role_template(xguest, xguest_t, xguest_r)
> ')
>
> optional_policy(`
>     gnome_per_role_template(xguest, xguest_t, xguest_r)
> ')
>
> optional_policy(`
>     dbus_per_role_template(xguest, xguest_t, xguest_r)
> ')


If I wanted to define a ssh account (gadmin) for a user to enter a
system and then allow them to sudo and newrole to a confined root user
(webadm ), the policy would look like
>
> policy_module(gadmin,1.0.0)
>
> userdom_unpriv_login_user(gadmin)
> sudo_per_role_template(gadmin, gadmin_t, gadmin_r)
> seutil_run_newrole(gadmin_t, gadmin_r, { gadmin_devtty_t 
> gadmin_tty_device_t })
> gen_require(`
>     type gadmin_t;
> ')
> allow gadmin_t webadm_t:process transition;
> allow webadm_t gadmin_t:dir getattr;


As for defining root confined user, the only interface you need is
userdom_base_user_template
Then you begin building up the rules from this.
>
> policy_module(webadm,1.0.0)
>
> ########################################
> #
> # webadmin local policy
> #
>
> userdom_login_user_template(webadm)
> allow webadm_t self:capability { dac_override dac_read_search kill 
> sys_ptrace sys_nice };
>
> # Allow webadm_t to restart the apache service
> domain_dontaudit_search_all_domains_state(webadm_t)
> apache_domtrans(webadm_t)
> init_exec_script_files(webadm_t)
> domain_role_change_exemption(webadm_t)
> domain_obj_id_change_exemption(webadm_t)
> role_transition webadm_r httpd_exec_t system_r;
> allow webadm_r system_r;
>
> apache_manage_all_content(webadm_t)
> apache_manage_config(webadm_t)
> apache_manage_log(webadm_t)
> apache_manage_modules(webadm_t)
> apache_manage_lock(webadm_t)
> apache_manage_pid(webadm_t)
> apache_read_state(webadm_t)
> apache_signal(webadm_t)
> apache_getattr(webadm_t)
> apache_relabel(webadm_t)
>
> seutil_domtrans_restorecon(webadm_t)
>
> files_dontaudit_search_all_dirs(webadm_t)
> files_dontaudit_getattr_all_files(webadm_t)
> files_manage_generic_locks(webadm_t)
> files_list_var(webadm_t)
> selinux_get_enforce_mode(webadm_t)
>
> logging_send_syslog_msg(webadm_t)
>
> ifdef(`targeted_policy',`
>     term_use_generic_ptys(webadm_t)
>     term_use_unallocated_ttys(webadm_t)
> ')
>
> userdom_dontaudit_search_sysadm_home_dirs(webadm_t)
> userdom_dontaudit_search_generic_user_home_dirs(webadm_t)
>
> bool webadm_read_user_files false;
> bool webadm_manage_user_files false;
>
> if (webadm_read_user_files) {
>     userdom_read_unpriv_users_home_content_files(webadm_t)
>     userdom_read_unpriv_users_tmp_files(webadm_t)
> }
>
> if (webadm_manage_user_files) {
>     userdom_manage_unpriv_users_home_content_dirs(webadm_t)
>     userdom_read_unpriv_users_tmp_files(webadm_t)
>     userdom_write_unpriv_users_tmp_files(webadm_t)
> }

One of the shortcomings of the current way we are building policy is
that the Makefile searches for all per_role_ functions, and we end up
with user_t having the ability to execute su and sudo, which I don't
believe it should be able to .  I think this should be removed and we
have to explicitly define all domain transitions like I have above.



--------------000802010002070405050803
Content-Type: application/x-gzip;
 name="userdomain.if.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="userdomain.if.gz"

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
jCW5JL5JLOb/B7e2Tbm59gEA
--------------000802010002070405050803--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
