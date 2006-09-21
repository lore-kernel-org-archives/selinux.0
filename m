Subject: Re: How to configure and reload selinux policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: "Jin, Yihua" <yihua.jin@intel.com>, SELinux@tycho.nsa.gov
In-Reply-To: <1158844909.3920.21.camel@sgc.columbia.tresys.com>
References: 
	 <117E3EB5059E4E48ADFF2822933287A40176C48B@pdsmsx404.ccr.corp.intel.com>
	 <1158844909.3920.21.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 21 Sep 2006 10:38:36 -0400
Message-Id: <1158849516.7748.54.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-09-21 at 09:21 -0400, Christopher J. PeBenito wrote:
> On Thu, 2006-09-21 at 16:59 +0800, Jin, Yihua wrote:
> > I used targeted policy 1.17 in RHEL4U4 
> > 
> > Modify the domain/unconfined_t, added:
> > 
> > Bool allow_execmem false;
> > 
> > If ( allow_execmem ) {
> > 
> >          Allow domain self :process execmem;
> > 
> > }
> > 
> > Than I type make reload to load this modified policy, but I find exec
> > memory is still allowed by system.
> > 
> > That is, I check avc_has_perm and it allowed this operation.
> 
> Booleans are runtime options.  The value above is just the initial
> value.  When you reload the policy on the running system, the boolean
> states are preserved, so if allow_execmem was true before, then it would
> stay true until you `setsebool allow_execmem 0`.  In addition, you don't
> need to rebuild the policy to alter the initial value of the booleans,
> you can edit the /etc/selinux/targeted/booleans file.  The values in
> this file will be set when the policy is loaded the first time by init.
> 
> On a side note, I don't think the RHEL4 kernels have execmem checking,
> so this rule has no effect.

One other observation: allow rules are additive, so if any other allow
rule exists that grants the domain in question (unconfined_t?) execmem
permission, then it will get that permission.  For example, the
unconfined_domain() macro includes the rule:
	allow $1 domain:process ~transition;
which would also grant execmem implicitly.  You could alter that to say:
	allow $1 domain:process ~{ transition execmem };

But as Chris notes, the RHEL4 kernel didn't include execmem checking as
far as I know.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
