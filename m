Message-ID: <1495208719.2209.12.camel@tycho.nsa.gov>
Subject: Re: [PATCH] selinux: Mark array 'labeling_behaviors' as __maybe_unused
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul@paul-moore.com>, Matthias Kaehlcke <mka@chromium.org>
Cc: James Morris <james.l.morris@oracle.com>, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Date: Fri, 19 May 2017 11:45:19 -0400
In-Reply-To: <CAHC9VhSFrXLE349atrmFDYjCWuda_O4TtJgEUwnK-DDZUx00bw@mail.gmail.com>
References: <20170518190759.28560-1-mka@chromium.org>
 <CAHC9VhSFrXLE349atrmFDYjCWuda_O4TtJgEUwnK-DDZUx00bw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2017-05-19 at 11:09 -0400, Paul Moore wrote:
> On Thu, May 18, 2017 at 3:07 PM, Matthias Kaehlcke <mka@chromium.org>
> wrote:
> > The array is only referenced in an ARRAY_SIZE() statement. Adding
> > the
> > attribute fixes the following warning when building with clang:
> > 
> > security/selinux/hooks.c:338:20: error: variable
> > 'labeling_behaviors'
> >     is not needed and will not be emitted
> >     [-Werror,-Wunneeded-internal-declaration]
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  security/selinux/hooks.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> The fact that we only reference labeling_behaviors in one spot, and
> even then we only use it as a parameter to ARRAY_SIZE(), makes me
> believe we may be able to get rid of labeling_behaviors and use
> SECURITY_FS_USE_MAX in its place.
> 
> Anyone working on any patches which make use of labeling_behaviors?

I think you could just remove both the array and the code that
referenced it; it only made sense before commit
2088d60e3b2f53d0c9590a0202eeff85b288b1eb.  We already check that the
policy doesn't contain any behavior > SECURITY_FS_USE_MAX during policy
load, so this cannot occur (modulo memory corruption), and it was only
there to make sure we didn't try to dereference off the end of the
array prior to the aforementioned commit.

> 
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index e67a526d1f30..450ff9f3161c 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -400,7 +400,7 @@ static void superblock_free_security(struct
> > super_block *sb)
> > 
> >  /* The file system's label must be initialized prior to use. */
> > 
> > -static const char *labeling_behaviors[7] = {
> > +static const char * __maybe_unused labeling_behaviors[7] = {
> >         "uses xattr",
> >         "uses transition SIDs",
> >         "uses task SIDs",
> > --
> > 2.13.0.303.g4ebf302169-goog
> 
> 
