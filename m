Subject: Re: [RFC] SENFS: MAC labeling support for NFSv4
From: Stephen Smalley <sds@tycho.nsa.gov>
To: casey@schaufler-ca.com
Cc: "David P. Quigley" <dpquigl@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        labeled-nfs@linux-nfs.org
In-Reply-To: <31809.62508.qm@web36611.mail.mud.yahoo.com>
References: <31809.62508.qm@web36611.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Wed, 01 Aug 2007 17:30:07 -0400
Message-Id: <1186003807.15215.401.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-08-01 at 13:55 -0700, Casey Schaufler wrote:
> --- "David P. Quigley" <dpquigl@tycho.nsa.gov> wrote:
> 
> > This is the first set of patches attempting to provide a generic framework
> > for
> > MAC labeling in NFSv4.
> 
> I've read through the patches and I have one very important issue.
> If you are going to provide a "generic" framework you need to support
> label representations other than u32. If you only want to support
> SELinux, and I understand that that is your initial target, a u32
> is fine, but if you want a generic framework you need to allow for
> the kinds of labels that have been used elsewhere. Smack (under
> review now) uses an 8byte label. Trusted Irix uses a 510byte label,
> and although I wouldn't expect that implementation to actually get
> ported any time soon it provides an existence proof for large labels.
> If you're talking about NFS you need to seriously consider what
> TrustedSolaris requires, if just out of courtesy to those who brought
> you NFS in the first place.

The label representation over the wire isn't a u32 (or inherently
limited in size); the u32 secid is just a handle to the label.  As long
as the code invokes a secid_to_secctx hook to obtain the actual label to
be conveyed over the wire, there is no harm, and it is more efficient to
handle them as secids than full labels internally.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
