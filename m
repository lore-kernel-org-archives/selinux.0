Subject: Re: [RFC] SENFS: MAC labeling support for NFSv4
From: Stephen Smalley <sds@tycho.nsa.gov>
To: casey@schaufler-ca.com
Cc: "David P. Quigley" <dpquigl@tycho.nsa.gov>, selinux@tycho.nsa.gov
In-Reply-To: <912088.21089.qm@web36608.mail.mud.yahoo.com>
References: <912088.21089.qm@web36608.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Thu, 02 Aug 2007 11:43:42 -0400
Message-Id: <1186069422.2434.51.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 08:26 -0700, Casey Schaufler wrote:
> --- Stephen Smalley <sds@tycho.nsa.gov> wrote:
>  
> > > In the spirit of LSM I suggest that blobs are more appropriate
> > > units of data than u32s. I understand that the SELinux design
> > > philosophy is well served by secids. My design philosophy, which
> > > is pretty much the opposite, has no need for secids and is
> > > negatively impacted by interfaces that require them.
> > 
> > Blobs require full lifecycle management.
> 
> Yup.
> 
> > secids are lighter weight,
> 
> They are lighter weight than big labels. They are heavier than
> small labels. They require translation, while certain designs of
> small labels don't even require translation to print.

I think you'd still lose on the lifecycle management overhead.

> > secids are already entrenched in the LSM interface for labeled
> > networking
> 
> The xfrm interfaces that require secids are seriously SELinux components.
> Netlabel only uses secids for audit. 

labeled xfrm isn't limited to SELinux; it could be used by any user of
labeled networking.

> > and are already entrenched in the audit-selinux interface
> > (even if converted to using LSM hooks).
> 
> So I've found. It is annoying that the audit system passes around sids
> when it never uses them except to get the associated strings, which
> Smack uses natively and can provide trivially.

...with corresponding lifecycle management overhead.  You'd have to
allocate and copy at time of audit collection even though the string
might never be used, versus only allocating and copying upon audit
record generation.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
