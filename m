Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72GaBBm003803
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 12:36:11 -0400
Received: from web36604.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l72GaAOD020296
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:36:10 GMT
Date: Thu, 2 Aug 2007 09:36:04 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [RFC] SENFS: MAC labeling support for NFSv4
To: Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com
Cc: "David P. Quigley" <dpquigl@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        labeled-nfs@linux-nfs.org
In-Reply-To: <1186069422.2434.51.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <553058.9089.qm@web36604.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Thu, 2007-08-02 at 08:26 -0700, Casey Schaufler wrote:
> > --- Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >  
> > > > In the spirit of LSM I suggest that blobs are more appropriate
> > > > units of data than u32s. I understand that the SELinux design
> > > > philosophy is well served by secids. My design philosophy, which
> > > > is pretty much the opposite, has no need for secids and is
> > > > negatively impacted by interfaces that require them.
> > > 
> > > Blobs require full lifecycle management.
> > 
> > Yup.
> > 
> > > secids are lighter weight,
> > 
> > They are lighter weight than big labels. They are heavier than
> > small labels. They require translation, while certain designs of
> > small labels don't even require translation to print.
> 
> I think you'd still lose on the lifecycle management overhead.

Aw, 'cmon. I'm having to add a layer of lifecycle management to
keep secid mappings just so that I can pass them out so that others
can call be back to ask for the original label value. 

I would like to understand why you think I would lose on overhead.
I know you've looked at the Smack code.
 
> > > secids are already entrenched in the LSM interface for labeled
> > > networking
> > 
> > The xfrm interfaces that require secids are seriously SELinux components.
> > Netlabel only uses secids for audit. 
> 
> labeled xfrm isn't limited to SELinux; it could be used by any user of
> labeled networking.

But it isn't, and the xfrm code explictly identifes the messages types
as SELinux specific. If I were adding xfrm to Smack I would not reuse
those types because they strongly identify with SELinux behavior.

> > > and are already entrenched in the audit-selinux interface
> > > (even if converted to using LSM hooks).
> > 
> > So I've found. It is annoying that the audit system passes around sids
> > when it never uses them except to get the associated strings, which
> > Smack uses natively and can provide trivially.
> 
> ...with corresponding lifecycle management overhead.  You'd have to
> allocate and copy at time of audit collection even though the string
> might never be used, versus only allocating and copying upon audit
> record generation.

These copies can be easily avoided using well established
methods. Maybe I'll suggest them for Casey's Audit Update,
phase II.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
