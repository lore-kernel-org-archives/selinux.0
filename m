Subject: Re: [PATCH][RFC] V1 Remove SELinux dependencies from linux-audit
	via LSM
From: Stephen Smalley <sds@tycho.nsa.gov>
To: casey@schaufler-ca.com
Cc: LSM List <linux-security-module@vger.kernel.org>,
        SELinux List <selinux@tycho.nsa.gov>,
        Audit List <linux-audit@redhat.com>
In-Reply-To: <457110.86749.qm@web36606.mail.mud.yahoo.com>
References: <457110.86749.qm@web36606.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Fri, 03 Aug 2007 14:43:19 -0400
Message-Id: <1186166599.2434.295.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-08-03 at 09:33 -0700, Casey Schaufler wrote:
> --- Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> > > > diff -uprN -X linux-2.6.22-base/Documentation/dontdiff
> > > > linux-2.6.22-base/include/linux/security.h
> > > > linux-2.6.22-audit/include/linux/security.h
> > > > --- linux-2.6.22-base/include/linux/security.h	2007-07-08
> > > 16:32:17.000000000
> > > > -0700
> > > > +++ linux-2.6.22-audit/include/linux/security.h	2007-08-01
> > > 20:14:18.000000000
> > > > -0700
> > > > @@ -35,6 +35,8 @@
> > > >  #include <net/flow.h>
> > > >  
> > > >  struct ctl_table;
> > > > +struct audit_krule;
> > > > +struct selinux_audit_rule;
> > > 
> > > selinux_audit_rule in LSM interface?
> > 
> > The structure needs a new name. Any objections to audit_rule_lsm?
> > I'd suggest security_audit_rule, but that doesn't say anything about
> > where to look to see how it gets used.
> 
> Actually, it's worse than that because an selinux_audit_rule really
> is SELinux specific. Any problem with making the security_audit_rule
> interfaces use a void * ? The audit code appears to be accomodating.

The struct is already opaque outside of the security module, so you can
just rename it and implement your own version of the struct in your
module.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
