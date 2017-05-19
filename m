Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4JGr89u005074
 for <selinux@tycho.nsa.gov>; Fri, 19 May 2017 12:53:08 -0400
Received: by mail-pf0-f179.google.com with SMTP id m17so42412641pfg.3
 for <selinux@tycho.nsa.gov>; Fri, 19 May 2017 09:53:05 -0700 (PDT)
Date: Fri, 19 May 2017 09:52:59 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <james.l.morris@oracle.com>,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov
Subject: Re: [PATCH] selinux: Mark array 'labeling_behaviors' as __maybe_unused
Message-ID: <20170519165259.GJ141096@google.com>
References: <20170518190759.28560-1-mka@chromium.org>
 <CAHC9VhSFrXLE349atrmFDYjCWuda_O4TtJgEUwnK-DDZUx00bw@mail.gmail.com>
 <1495208719.2209.12.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1495208719.2209.12.camel@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

El Fri, May 19, 2017 at 11:45:19AM -0400 Stephen Smalley ha dit:

> On Fri, 2017-05-19 at 11:09 -0400, Paul Moore wrote:
> > On Thu, May 18, 2017 at 3:07 PM, Matthias Kaehlcke <mka@chromium.org>
> > wrote:
> > > The array is only referenced in an ARRAY_SIZE() statement. Adding
> > > the
> > > attribute fixes the following warning when building with clang:
> > > 
> > > security/selinux/hooks.c:338:20: error: variable
> > > 'labeling_behaviors'
> > >     is not needed and will not be emitted
> > >     [-Werror,-Wunneeded-internal-declaration]
> > > 
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> > >  security/selinux/hooks.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > The fact that we only reference labeling_behaviors in one spot, and
> > even then we only use it as a parameter to ARRAY_SIZE(), makes me
> > believe we may be able to get rid of labeling_behaviors and use
> > SECURITY_FS_USE_MAX in its place.
> > 
> > Anyone working on any patches which make use of labeling_behaviors?
> 
> I think you could just remove both the array and the code that
> referenced it; it only made sense before commit
> 2088d60e3b2f53d0c9590a0202eeff85b288b1eb.  We already check that the
> policy doesn't contain any behavior > SECURITY_FS_USE_MAX during policy
> load, so this cannot occur (modulo memory corruption), and it was only
> there to make sure we didn't try to dereference off the end of the
> array prior to the aforementioned commit.

Thanks for your comments.

I will send out a patch that removes the array shortly.

Matthias
