Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5CF90cL026533
	for <selinux@tycho.nsa.gov>; Tue, 12 Jun 2007 11:09:00 -0400
Received: from web36607.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l5CF8xgo027331
	for <selinux@tycho.nsa.gov>; Tue, 12 Jun 2007 15:08:59 GMT
Date: Tue, 12 Jun 2007 08:08:58 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [RFC][PATCH] selinux:  enable authoritative granting of capabilities
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serue@us.ibm.com>
In-Reply-To: <1181652652.17547.82.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <749740.73121.qm@web36607.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Mon, 2007-06-11 at 15:55 -0400, Stephen Smalley wrote:
> > Extend SELinux to allow capabilities to be granted authoritatively.
> > Introduces a new cap_override access vector to indicate when the
> > secondary module (i.e. capability or dummy) check should be skipped.
> > Handle the new class gracefully even if the policy does not yet have
> > it defined.
> 
> I was asked privately to explain what motivated this patch.  As the
> answer is likely of general interest, here is a summary of (and
> expansion upon) my reply.  I'll likely fold some of this text into the
> description that goes with the final form of this patch.

Thank you for taking the time to provide this.

> The idea of using SELinux RBAC/TE to completely manage Linux
> capabilities has always been desirable from our point of view, and was
> described in the earliest discussions on selinux list (see archives).  A
> similar approach to superuser privilege overrides was even implemented
> in a predecessor of SELinux, the DTOS system.  We had held off on it
> originally in SELinux because of the potential danger in weakening the
> base system restrictions, but it has always remained a goal, deferred
> until SELinux was more fully integrated and policy was more mature.
> 
> The motivation for creating this patch now has been the flurry of
> interest/activity in file capabilities (currently a patch in -mm), which
> provide an alternative (and in our view inferior) way to achieve the
> same end - being able to grant capabilities to programs without them
> needing to be suid root.  But the file capabilities approach lacks a
> centralized and analyzable policy, the flexibility and control of domain
> transitions for changes in capability state (vs. the hardcoded
> capability evolution logic), and the ability to protect and confine the
> processes that are given these capabilities.

The file capabilty mechanism has been through two CC evaluations
for which I have the certificates, so I think that you may have
trouble substantiating your claim that it lacks an analyzable policy. 

> This patch as implemented makes the distinction very clear:
> allow ping_t self:capability net_raw; still means what it used to
> mean, and SELinux will only authoritatively grant the capability if you
> add a new cap_override rule to the policy, e.g.
> allow ping_t self:cap_override new_raw;
> 
> Thus, by default (in the absence of new policy), nothing changes, and
> anyone can easily audit their policy to see whether and where they are
> granting capabilities authoritatively.
> 
> Further, as the code uses the _noaudit interface to apply the
> cap_override check, these permissions will only be allowed by explicit
> choice of the administrator, not by automated policy generation tools
> like audit2allow.  The use of the _noaudit interface was also motivated
> by the fact that this check must occur before the base capability check
> and would otherwise need to be pervasively dontaudit'd to avoid noise in
> the audit logs.
> 
> At present, the patch clones the capability permissions into the
> cap_override class; I would have moved them to a common definition and
> inherited them into both but that would have prevented policy reload on
> existing kernels.

Well, I don't like it, but I do appreciate the fact that the
disintegration is explicit.

Do y'all plan to let the rest of the world know what you're up
to, or do you plan to present this as a feit accompli?


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
