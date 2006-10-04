Subject: Re: [redhat-lspp] Re: RHEL5 Kernel with labeled networking
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Klaus Weidner <klaus@atsec.com>
Cc: Linda Knippers <linda.knippers@hp.com>, Joshua Brindle <method@gentoo.org>,
        Joy Latten <latten@austin.ibm.com>, redhat-lspp@redhat.com,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>, jmorris@namei.org,
        Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov,
        eparis@parisplace.org, Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <20061004174149.GD10195@w-m-p.com>
References: <1159902988.29928.2.camel@faith.austin.ibm.com>
	 <4522CAB7.6090109@hp.com> <4522D554.7080708@gentoo.org>
	 <4522D5C2.8060702@hp.com> <4522D667.5030401@mentalrootkit.com>
	 <4522DA79.6080708@hp.com> <4522E6F7.1040207@gentoo.org>
	 <4522EB42.9070502@hp.com>
	 <1159973836.19176.89.camel@moss-spartans.epoch.ncsc.mil>
	 <4523D140.5030103@hp.com>  <20061004174149.GD10195@w-m-p.com>
Content-Type: text/plain
Date: Wed, 04 Oct 2006 13:56:49 -0400
Message-Id: <1159984609.19176.145.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-10-04 at 12:41 -0500, Klaus Weidner wrote:
> On Wed, Oct 04, 2006 at 11:20:32AM -0400, Linda Knippers wrote:
> > Thanks for the reminder about that thread.
> > https://www.redhat.com/archives/redhat-lspp/2006-August/msg00008.html
> > 
> > I didn't really see a conclusion though.  Dan was waiting to hear from
> > Steve.  Steve didn't like it for the reasons I mentioned above.  Were
> > the auditallows added to the MLS policy?  Did anyone create a module?
> 
> Yes, it's part of the "lspp_policy" module included in the kickstart
> config RPM I posted yesterday.
> 
> This reminds me - can we assume that the setsocketcreate and
> setipccreate attributes will remain unimplemented for RHEL5? If they get
> added at the last minute the people who write the tests would get very
> unhappy.

sockcreate was added in 2.6.18, and thus should be present in the RHEL5
kernel.  ipccreate was not upstreamed due to lack of a user so far.

The actual permission is setsockcreate.  But no one submitted a policy
patch to define it.  Eric?

> 
> -Klaus
> 
> policy_module(lspp_policy,1.0)
> 
> gen_require(`
>         attribute domain;
> ')
> 
> # Audit setting of security relevant process attributes
> # These settings are OPTIONAL
> auditallow domain self:process setcurrent;
> auditallow domain self:process setexec;
> auditallow domain self:process setfscreate;
> #auditallow domain self:process setsocketcreate; # FIXME
> #auditallow domain self:process setipccreate; # FIXME
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
