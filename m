Subject: Re: three problems about normal user login in strict policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Ken YANG <spng.yang@gmail.com>, SELinux List <selinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1182253877.15064.13.camel@moss-spartans.epoch.ncsc.mil>
References: <4667F878.9030805@gmail.com>
	 <1181223271.11979.4.camel@moss-spartans.epoch.ncsc.mil>
	 <1181224077.6578.92.camel@sgc.columbia.tresys.com>
	 <1181224459.11979.7.camel@moss-spartans.epoch.ncsc.mil>
	 <1181242131.6578.96.camel@sgc.columbia.tresys.com>
	 <46778C6B.50307@gmail.com>
	 <1182253877.15064.13.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 19 Jun 2007 12:09:41 +0000
Message-Id: <1182254981.4077.74.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-06-19 at 07:51 -0400, Stephen Smalley wrote:
> On Tue, 2007-06-19 at 15:57 +0800, Ken YANG wrote:
> > Christopher J. PeBenito wrote:
> > > On Thu, 2007-06-07 at 09:54 -0400, Stephen Smalley wrote:
> > >> On Thu, 2007-06-07 at 13:47 +0000, Christopher J. PeBenito wrote:
> > >>> On Thu, 2007-06-07 at 09:34 -0400, Stephen Smalley wrote:
> > >>>> On Thu, 2007-06-07 at 20:22 +0800, Ken YANG wrote:
> > >>>>> i studied the point from walsh about non-root X login,
> > >>>>> see details in following thread:
> > >>>>>
> > >>>>> http://marc.info/?l=selinux&m=118050940823692&w=2
> > >>>>>
> > >>>>> when i login with normal user(user_u), i have some questions:
> > >>>>> (i'm in fc7 with strict-mcs policy at svn version 2301)
> > >>>>>
> > >>>>> 1
> > >>>>> when i login as user_u, i find i can not switch to staff_u through su,
> > >>>>> but i notice that there is corresponding line in "default_contexts" file:
> > >>>> The su / pam_selinux integration was reverted a while ago, so su no
> > >>>> longer changes contexts at all, just like in the original SELinux.  
> > >>>> Thus, the SELinux user identity is once again stable for the entire
> > >>>> session, and you have to use newrole to switch roles.  And user_r isn't
> > >>>> generally allowed to switch to staff_r; you need to map your Linux user
> > >>>> identity to staff_u via semanage.
> > 
> > sorry for reply so late, i just covered walsh's blog, and
> > reviewed some points about selinux user, but i still had 2
> > questions:
> > 
> > now that su/pam_selinux will not change selinux user id,
> > and user_r cannt switch to staff_r, what is the function
> > of "user_r:user_su_t:s0 staff_r:staff_t:s0..." line in
> > "default_context", and where is it used?
> 
> They are obsolete and can be removed, unless they are just being left
> for compatibility in case someone wants to re-insert pam_selinux
> into /etc/pam.d/su.

They remain for RHEL4 support.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
