Date: Wed, 6 Feb 2008 09:35:44 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Xavier Toth <txtoth@gmail.com>, Eamon Walsh <ewalsh@tycho.nsa.gov>,
        SELinux List <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] selinux: make mls_compute_sid always polyinstantiate
In-Reply-To: <1202244504.27371.105.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.64.0802060934570.10987@us.intercode.com.au>
References: <4798F57C.8090300@tycho.nsa.gov>
 <cadfc0e40802050952p519dae9co7ecec84bb67231dd@mail.gmail.com>
 <1202244504.27371.105.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 5 Feb 2008, Stephen Smalley wrote:

> 
> On Tue, 2008-02-05 at 11:52 -0600, Xavier Toth wrote:
> > Is this in rawhide, if not when will it be?
> 
> Not up to us, obviously.  The patch is in Linus' git tree, but looks
> like latest fedora devel kernel is frozen on 2.6.24 + specific
> individual patches, not feeding from Linus' git presently.  James could
> possibly ask the Fedora kernel maintainer about adding it - it is small,
> self-contained, and has no side effects on existing code (nothing prior
> to XSELinux uses the compute member support; pam_namespace usage was
> disabled since it didn't work right for multi-level dirs).

The rawhide kernel usually tracks Linus pretty closely -- perhaps wait a 
couple of days until people recover from LCA.

> 
> > 
> > On Thu, Jan 24, 2008 at 2:30 PM, Eamon Walsh <ewalsh@tycho.nsa.gov> wrote:
> > > This patch removes the requirement that the new and related object types
> > >  differ in order to polyinstantiate by MLS level.  This allows MLS
> > >  polyinstantiation to occur in the absence of explicit type_member rules
> > >  or when the type has not changed.
> > >
> > >  Potential users of this support include pam_namespace.so (directory
> > >  polyinstantiation) and the SELinux X support (property polyinstantiation).
> > >
> > >  Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
> > >  ---
> > >
> > >   mls.c |   11 ++---------
> > >   1 file changed, 2 insertions(+), 9 deletions(-)
> > >
> > >
> > >  diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
> > >  index fb5d70a..3bbcb53 100644
> > >  --- a/security/selinux/ss/mls.c
> > >  +++ b/security/selinux/ss/mls.c
> > >  @@ -537,15 +537,8 @@ int mls_compute_sid(struct context *scontext,
> > >                         /* Use the process effective MLS attributes. */
> > >                         return mls_context_cpy_low(newcontext, scontext);
> > >         case AVTAB_MEMBER:
> > >  -               /* Only polyinstantiate the MLS attributes if
> > >  -                  the type is being polyinstantiated */
> > >  -               if (newcontext->type != tcontext->type) {
> > >  -                       /* Use the process effective MLS attributes. */
> > >  -                       return mls_context_cpy_low(newcontext, scontext);
> > >  -               } else {
> > >  -                       /* Use the related object MLS attributes. */
> > >  -                       return mls_context_cpy(newcontext, tcontext);
> > >  -               }
> > >  +               /* Use the process effective MLS attributes. */
> > >  +               return mls_context_cpy_low(newcontext, scontext);
> > >         default:
> > >                 return -EINVAL;
> > >         }
> > >
> > >
> > >
> > >  --
> > >  Eamon Walsh <ewalsh@tycho.nsa.gov>
> > >  National Security Agency
> > >
> > >
> > >  --
> > >  This message was distributed to subscribers of the selinux mailing list.
> > >  If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> > >  the words "unsubscribe selinux" without quotes as the message.
> > >
> > 
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> > the words "unsubscribe selinux" without quotes as the message.
> 

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
