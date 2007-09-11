Subject: Re: Role Creation Wizard
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Eric Paris <eparis@parisplace.org>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <46DF0DD5.3080207@redhat.com>
References: <46DF0DD5.3080207@redhat.com>
Content-Type: text/plain
Date: Tue, 11 Sep 2007 13:30:57 -0400
Message-Id: <1189531857.3163.13.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-09-05 at 16:13 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I have been working on creating a role creation wizard, for policy
> writers to be able to create user types and admin roles.
> 
> Working from a base line user (guest_t, xguest_t),  You can assign
> transitions to other domains (mozilla, ssh) or to admin roles webadm_t,
> dbadm_t.  Most of the work is done.
> 
> The admin roles will be able to manipulate there own service.  I have
> begun labeling initscripts.
> 
> ls -lZ /etc/init.d/httpd
> - -rwxr-xr-x  root root system_u:object_r:httpd_script_exec_t:s0
> /etc/init.d/httpd
> 
> So a webadm_t will only be able to run /etc/init.d/httpd (Labeled
> httpd_script_exec_t).
> 
> I don't want to require the use of run_init.  Mainly because this
> requires the entry of the password,  (I don't want to give these admin
> roles "rootok".  So pam_rootok will not fix this problem.  I am also not
> sure if we transition to run_init, we can prevent the admin from
> executing other init scripts.
> 
> So in my test environment I have created a terminal user mytuser_u;  and
> an admin user mydbadm_t, which can modify postgresql and mysql environments.
> 
> # semanage user -l | grep mytuser
> mytuser_u       mytuser    s0         s0
> mydbadm_r mytuser_r
> 
> Then I assign the rwalsh account to it
> 
> semanage login -l | grep mytuser
> rwalsh                    mytuser_u                 s0
> 
> I log in as rwalsh,
> sudo/newrole to mydbadm_t
> 
> When I try to start the init script, I fail with the following error.
> 
> 
> service mysqld restart
> env: /etc/init.d/mysqld: Permission denied
> 
> 
> This is happening because of the following SELINUX_ERR
> 
> grep SELINUX /var/log/audit/audit.log
> type=SELINUX_ERR msg=audit(1189021260.698:974): security_compute_sid:
> invalid context mytuser_u:system_r:initrc_t:s0 for
> scontext=mytuser_u:mydbadm_r:mydbadm_t:s0
> tcontext=system_u:object_r:mysqld_script_exec_t:s0 tclass=process
> 
> Which indicates system_r is not available to mytuser_u.
> 
> So in order to get this to work,  I will have to add system_r to every
> admin user.  Which seems to me to be a potential risk.
> 
> We have role_transition and type_transition but no user_transition.
> 
> Any ideas on better way to handle this, or is my only choice run_init,
> or system_r for the admin user.

The approach in Hardened Gentoo was to integrate run_init-like
functionality into the init system, IIRC, but omitting the
re-authentication stage (which isn't security-critical).

Adding user_transition support to the policy compiler and kernel would
be a useful feature though.  And I don't believe the 'wait for
policyrep' mantra - if it matters, we should just do it now.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
