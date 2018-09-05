Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w85MH7um012961
 for <selinux@tycho.nsa.gov>; Wed, 5 Sep 2018 18:17:07 -0400
Received: by mail-lf1-f65.google.com with SMTP id v77-v6so7340322lfa.6
 for <selinux@tycho.nsa.gov>; Wed, 05 Sep 2018 15:16:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180806211932.198488-1-jannh@google.com>
 <CAHC9VhR5S6jGsHVwrGXemGobB1O=tADHBHWZMRP5BuRMGqDrOQ@mail.gmail.com>
 <CAG48ez1VMp=NXWb2eSEZsnszs-g5NVUhCVLXrjnMcHZYBJus8w@mail.gmail.com>
In-Reply-To: <CAG48ez1VMp=NXWb2eSEZsnszs-g5NVUhCVLXrjnMcHZYBJus8w@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 5 Sep 2018 18:16:46 -0400
Message-ID: <CAHC9VhRrSYxsqQ==8anCKT+BEjBgD3wppMyeyGec_DMbowq=Tg@mail.gmail.com>
To: jannh@google.com
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
 Serge Hallyn <serge@hallyn.com>, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] selinux: refactor mls_context_to_sid() and make
 it stricter
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Aug 31, 2018 at 11:47 AM Jann Horn <jannh@google.com> wrote:
> On Thu, Aug 9, 2018 at 3:56 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Mon, Aug 6, 2018 at 5:19 PM Jann Horn <jannh@google.com> wrote:

...

> > In the case where we have a MLS policy loaded (pol->mls_enabled != 0)
> > and scontext is empty (scontext[0] = '\0'), we could end up returning
> > 0 couldn't we?  It seems like we might want a quick check for this
> > before we parse the low/high portions of the field into the rangep
> > array.
>
> I don't think so. In the first loop iteration, `sensitivity` will be
> an empty string, and so the hashtab_search() should return NULL,
> leading to -EINVAL. Am I missing something?

Looking at this again, no, I think you've got it right.  My guess is
that I just mistook the NULL sensitivity check at the top of the loop
as getting triggered in this case, which isn't the case here.  Sorry
for the noise.

> > As an aside, I believe my other comments on this patch still stand.
> > It's a nice improvement but I think there are some other small things
> > that need to be addressed.
>
> Is there anything I need to fix apart from the overly verbose comment
> and the unnecessary curly braces?

Nope.  I wouldn't even bother with that brace/comment changes, those
were minor nits and only worth changing if you needed to respin the
patch for some other reason.

Consider the patch merged, thanks!

--
paul moore
www.paul-moore.com
