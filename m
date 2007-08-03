Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l73GXKkg030881
	for <selinux@tycho.nsa.gov>; Fri, 3 Aug 2007 12:33:20 -0400
Received: from web36606.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l73GXJRA024639
	for <selinux@tycho.nsa.gov>; Fri, 3 Aug 2007 16:33:20 GMT
Date: Fri, 3 Aug 2007 09:33:19 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH][RFC] V1 Remove SELinux dependencies from linux-audit via LSM
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: LSM List <linux-security-module@vger.kernel.org>,
        SELinux List <selinux@tycho.nsa.gov>,
        Audit List <linux-audit@redhat.com>
In-Reply-To: <922084.93856.qm@web36605.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <457110.86749.qm@web36606.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Casey Schaufler <casey@schaufler-ca.com> wrote:

> > > diff -uprN -X linux-2.6.22-base/Documentation/dontdiff
> > > linux-2.6.22-base/include/linux/security.h
> > > linux-2.6.22-audit/include/linux/security.h
> > > --- linux-2.6.22-base/include/linux/security.h	2007-07-08
> > 16:32:17.000000000
> > > -0700
> > > +++ linux-2.6.22-audit/include/linux/security.h	2007-08-01
> > 20:14:18.000000000
> > > -0700
> > > @@ -35,6 +35,8 @@
> > >  #include <net/flow.h>
> > >  
> > >  struct ctl_table;
> > > +struct audit_krule;
> > > +struct selinux_audit_rule;
> > 
> > selinux_audit_rule in LSM interface?
> 
> The structure needs a new name. Any objections to audit_rule_lsm?
> I'd suggest security_audit_rule, but that doesn't say anything about
> where to look to see how it gets used.

Actually, it's worse than that because an selinux_audit_rule really
is SELinux specific. Any problem with making the security_audit_rule
interfaces use a void * ? The audit code appears to be accomodating.



Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
