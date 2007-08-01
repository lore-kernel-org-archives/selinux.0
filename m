Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l71Lx3wa002289
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2007 17:59:03 -0400
Received: from web36609.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l71Lx2dm020780
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2007 21:59:02 GMT
Date: Wed, 1 Aug 2007 14:59:02 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [RFC] SENFS: MAC labeling support for NFSv4
To: Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com
Cc: "David P. Quigley" <dpquigl@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        labeled-nfs@linux-nfs.org
In-Reply-To: <1186003807.15215.401.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <127128.61452.qm@web36609.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Wed, 2007-08-01 at 13:55 -0700, Casey Schaufler wrote:
> > --- "David P. Quigley" <dpquigl@tycho.nsa.gov> wrote:
> > 
> > > This is the first set of patches attempting to provide a generic
> framework
> > > for
> > > MAC labeling in NFSv4.
> > 
> > I've read through the patches and I have one very important issue.
> > If you are going to provide a "generic" framework you need to support
> > label representations other than u32. If you only want to support
> > SELinux, and I understand that that is your initial target, a u32
> > is fine, but if you want a generic framework you need to allow for
> > the kinds of labels that have been used elsewhere. Smack (under
> > review now) uses an 8byte label. Trusted Irix uses a 510byte label,
> > and although I wouldn't expect that implementation to actually get
> > ported any time soon it provides an existence proof for large labels.
> > If you're talking about NFS you need to seriously consider what
> > TrustedSolaris requires, if just out of courtesy to those who brought
> > you NFS in the first place.
> 
> The label representation over the wire isn't a u32 (or inherently
> limited in size); the u32 secid is just a handle to the label.  As long
> as the code invokes a secid_to_secctx hook to obtain the actual label to
> be conveyed over the wire, there is no harm, and it is more efficient to
> handle them as secids than full labels internally.

This is true for SELinux, where the secid is a map to a sophisticated
label. On Smack the label is completely unsophisticated and
translating back and forth to secids adds unnecessary overhead.

In the spirit of LSM I suggest that blobs are more appropriate
units of data than u32s. I understand that the SELinux design
philosophy is well served by secids. My design philosophy, which
is pretty much the opposite, has no need for secids and is
negatively impacted by interfaces that require them.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
