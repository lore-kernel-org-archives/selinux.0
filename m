Subject: Re: three problems about normal user login in strict policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Ken YANG <spng.yang@gmail.com>, SELinux List <selinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1181223271.11979.4.camel@moss-spartans.epoch.ncsc.mil>
References: <4667F878.9030805@gmail.com>
	 <1181223271.11979.4.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 07 Jun 2007 13:47:57 +0000
Message-Id: <1181224077.6578.92.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-06-07 at 09:34 -0400, Stephen Smalley wrote:
> On Thu, 2007-06-07 at 20:22 +0800, Ken YANG wrote:
> > 
> > i studied the point from walsh about non-root X login,
> > see details in following thread:
> > 
> > http://marc.info/?l=selinux&m=118050940823692&w=2
> > 
> > when i login with normal user(user_u), i have some questions:
> > (i'm in fc7 with strict-mcs policy at svn version 2301)
> > 
> > 1
> > when i login as user_u, i find i can not switch to staff_u through su,
> > but i notice that there is corresponding line in "default_contexts" file:
> 
> The su / pam_selinux integration was reverted a while ago, so su no
> longer changes contexts at all, just like in the original SELinux.  
> Thus, the SELinux user identity is once again stable for the entire
> session, and you have to use newrole to switch roles.  And user_r isn't
> generally allowed to switch to staff_r; you need to map your Linux user
> identity to staff_u via semanage.
> 
> > 
> > user_r:user_su_t:s0     staff_r:staff_t:s0 user_r:user_t:s0
> > sysadm_r:sysadm_t:s0
> > 
> > and in the policy, i found the condition of su domain transition have
> > satisfied, including su_exec_t entrypoint and type_transition rules,
> > furthermore, i also meet the constrain conditon in
> > su_per_role_template(), e.g. domain_role_change_exemption($1_su_t),
> > domain_subj_id_change_exemption($1_su_t),
> > domain_obj_id_change_exemption($1_su_t), and etc.
> 
> Hmm...seems like those should be removed from policy (unless some distro
> tunable is set for older fedora or rhel4), as su should no longer be
> making such transitions.

Its in a rhel4 build option.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
