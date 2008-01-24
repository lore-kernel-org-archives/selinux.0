Subject: Re: [PATCH] selinux: make mls_compute_sid always polyinstantiate
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: Eamon Walsh <ewalsh@tycho.nsa.gov>, SELinux List <selinux@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>
In-Reply-To: <4798F91B.3030509@manicmethod.com>
References: <4798F57C.8090300@tycho.nsa.gov>
	 <4798F91B.3030509@manicmethod.com>
Content-Type: text/plain
Date: Thu, 24 Jan 2008 16:01:58 -0500
Message-Id: <1201208518.21288.162.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-01-24 at 15:46 -0500, Joshua Brindle wrote:
> Eamon Walsh wrote:
> > This patch removes the requirement that the new and related object 
> > types differ in order to polyinstantiate by MLS level.  This allows 
> > MLS polyinstantiation to occur in the absence of explicit type_member 
> > rules or when the type has not changed.
> >
> > Potential users of this support include pam_namespace.so (directory 
> > polyinstantiation) and the SELinux X support (property 
> > polyinstantiation).
> >
> > Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
> > ---
> >
> > mls.c |   11 ++---------
> > 1 file changed, 2 insertions(+), 9 deletions(-)
> >
> >
> > diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
> > index fb5d70a..3bbcb53 100644
> > --- a/security/selinux/ss/mls.c
> > +++ b/security/selinux/ss/mls.c
> > @@ -537,15 +537,8 @@ int mls_compute_sid(struct context *scontext,
> >             /* Use the process effective MLS attributes. */
> >             return mls_context_cpy_low(newcontext, scontext);
> >     case AVTAB_MEMBER:
> > -        /* Only polyinstantiate the MLS attributes if
> > -           the type is being polyinstantiated */
> > -        if (newcontext->type != tcontext->type) {
> > -            /* Use the process effective MLS attributes. */
> > -            return mls_context_cpy_low(newcontext, scontext);
> > -        } else {
> > -            /* Use the related object MLS attributes. */
> > -            return mls_context_cpy(newcontext, tcontext);
> > -        }
> > +        /* Use the process effective MLS attributes. */
> > +        return mls_context_cpy_low(newcontext, scontext);
> >     default:
> >         return -EINVAL;
> >     }
> 
> Should there be a patch to update mls.c in libsepol as well? I hope we 
> are keeping the kss and uss in sync.

Yes, we should likely mirror the change there.

We aren't however keeping them in sync in general; there are certainly
any number of recent changes that have only gone into the kernel ss
(e.g. policy validation code, boolean preservation, handle unknown
support, new ebitmap implementation, object class and permission
discovery, etc).  And keeping them in sync is hard; most changes have to
be manually ported since the kernel ss is specialized for Linux and the
original contributor has to agree on porting the code to libsepol since
it has a different license (GPL vs. LGPL).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
