Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l77HilJ8012177
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2007 13:44:47 -0400
Received: from web36608.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l77HikI4000278
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2007 17:44:46 GMT
Date: Tue, 7 Aug 2007 10:44:30 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH][RFC] V2 Remove SELinux dependencies from linux-audit via LSM
To: Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com
Cc: LSM List <linux-security-module@vger.kernel.org>,
        SELinux List <selinux@tycho.nsa.gov>,
        Audit List <linux-audit@redhat.com>
In-Reply-To: <1186498030.26457.68.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <973639.58905.qm@web36608.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Sun, 2007-08-05 at 17:03 -0700, Casey Schaufler wrote:
> > From: Casey Schaufler <casey@schaufler-ca.com>
> > 
> > This patch interposes LSM interfaces between the audit system
> > and SELinux. This helps make SELinux a cleaner LSM and clarifies
> > the interfaces provided by the audit system. The audit system
> > no longer requires SELinux functions or data structures, making
> > it available for use by other LSMs.
> > 
> > The audit system interfaces should now be useful to any LSM that
> > can provide secids and text string representations that match them.
> > The audit system uses secids only to map to those strings and
> > treats them as opaque data otherwise. Audit rule information that
> > is specific to an LSM is maintained through a void *. 
> > 
> > The SELinux code uses LSM interfaces to access the audit system,
> > with the exception of audit_rule_update_callout(), which is
> > intended to be called at the descretion of an LSM to update the
> > LSM specific rules.
> > 
> > The LSM interface includes six new entries, four for audit and two
> > that supply secids from the LSM to networking and audit subsystems.
> > Also, there were several cases where SELinux code was being called
> > where LSM interfaces were more appropriate. These uses have been
> > repaired and the SELinux interfaces are no longer exported.
> > 
> > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> 
> Looks sane, but the patch is malformed again, so I can't apply it.

I have to change my posting infrastructure. Stoopid 21st century software.

> There are still a few places where you appear to be making
> sparse-induced cleanups of other code unrelated to this change, so make
> those separate patches (and be sure you aren't duplicating what is
> already upstream).

I'll just have to live with the warnings, I guess. Thank you.

> You've tested the resulting kernel?  Built with a variety of configs?

Testing has been minimal (hence the [RFC]) because I don't want to
invest too much time in something that might not go anywhere. I will
work on an applyable patch posting and begin serious testing now that
someone who knows sanity when they see it (never one of my strong
points) has identified it as such. I have built it SELinux, Smack,
and neither, but only spent any serious run time with Smack.

Thank you.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
