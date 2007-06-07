Subject: Re: three problems about normal user login in strict policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ken YANG <spng.yang@gmail.com>
Cc: SELinux List <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <4667F878.9030805@gmail.com>
References: <4667F878.9030805@gmail.com>
Content-Type: text/plain
Date: Thu, 07 Jun 2007 09:34:31 -0400
Message-Id: <1181223271.11979.4.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-06-07 at 20:22 +0800, Ken YANG wrote:
> hi all,
> 
> i studied the point from walsh about non-root X login,
> see details in following thread:
> 
> http://marc.info/?l=selinux&m=118050940823692&w=2
> 
> when i login with normal user(user_u), i have some questions:
> (i'm in fc7 with strict-mcs policy at svn version 2301)
> 
> 1
> when i login as user_u, i find i can not switch to staff_u through su,
> but i notice that there is corresponding line in "default_contexts" file:

The su / pam_selinux integration was reverted a while ago, so su no
longer changes contexts at all, just like in the original SELinux.  
Thus, the SELinux user identity is once again stable for the entire
session, and you have to use newrole to switch roles.  And user_r isn't
generally allowed to switch to staff_r; you need to map your Linux user
identity to staff_u via semanage.

> 
> user_r:user_su_t:s0     staff_r:staff_t:s0 user_r:user_t:s0
> sysadm_r:sysadm_t:s0
> 
> and in the policy, i found the condition of su domain transition have
> satisfied, including su_exec_t entrypoint and type_transition rules,
> furthermore, i also meet the constrain conditon in
> su_per_role_template(), e.g. domain_role_change_exemption($1_su_t),
> domain_subj_id_change_exemption($1_su_t),
> domain_obj_id_change_exemption($1_su_t), and etc.

Hmm...seems like those should be removed from policy (unless some distro
tunable is set for older fedora or rhel4), as su should no longer be
making such transitions.

> 
> but i still can not switch staff_r:staff_t through su:
> 
> su -l staffuser
> 
> staffuser is another user, i associate it with staff_u:
> 
> Login Name                SELinux User              MLS/MCS Range
> 
> 
> __default__               user_u                    s0
> 
> root                      root                      s0-s0:c0.c1023
> 
> staffuser                 staff_u                   s0
> 
> system_u                  system_u                  s0-s0:c0.c1023
> 
> can anyone give me some hint? thanks
> 
> 
> 2
> as mentioned above, if i use staffuser to login, i can newrole
> to syadm_r, but this way is same with root login, i think this
> is meaningless.
> 
> so how can i login with normal user(user_u), and can switch to
> syadm role when performing admin tasks?
> 
> 3
> i declared a user in policy:
> 
> gen_user(ken, user, user_r, s0, s0)
> 
> "ken" is my linux login user, i think if login program find the
> same SELinux user and linux user identity, it will use the "ken"
> in the context for the initial shell process, but after i login
> through tty2, and execute "id -Z", i found my user in context
> was still user_u, i.e. user_u:user_r:user_t:s0, why?
> 
> thanks in advance
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
