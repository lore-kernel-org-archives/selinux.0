Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>
From: Taras Kondratiuk <takondra@cisco.com>
In-Reply-To: <a185b384-5ef1-5e53-2cc1-066391424dcb@tycho.nsa.gov>
Cc: linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
 xe-linux-external@cisco.com
References: <20180919165248.53090-1-takondra@cisco.com>
 <153741130781.7326.1773144725860636439@takondra-t460s>
 <9a944aea-f35e-5a49-841d-6bfca8f17b9d@tycho.nsa.gov>
 <153748436388.5590.1406237328277739821@takondra-t460s>
 <66ec16b0-a335-d9ef-deb3-ef391cdd66e0@tycho.nsa.gov>
 <CAHC9VhRorkfqRTsssx_eGMy+fJQtoJew7f5i24UBkZ6tGJ5CUw@mail.gmail.com>
 <153785433233.5039.17960184426345262866@takondra-t460s>
 <a23ad753-8fd4-e9c3-cdbf-391ee154794b@tycho.nsa.gov>
 <CAHC9VhRRArA7_ON5P2JfrKxExwzm5Wznj150pfgijBoR+JxYBA@mail.gmail.com>
 <a185b384-5ef1-5e53-2cc1-066391424dcb@tycho.nsa.gov>
Message-ID: <153790265614.6091.7582646556934797699@takondra-t460s>
Date: Tue, 25 Sep 2018 12:10:56 -0700
Subject: Re: [RFC PATCH] selinux: add a fallback to defcontext for
 native labeling
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Quoting Stephen Smalley (2018-09-25 09:39:55)
> On 09/25/2018 12:03 PM, Paul Moore wrote:
> > On Tue, Sep 25, 2018 at 9:58 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:

<snip>

> >> I'm inclined to just change the behavior for defcontext= unconditionally
> >> and have it apply to both native and xattr labeling.  If that's a no-go,
> >> then the simplest solution is to just leave defcontext= behavior
> >> unchanged for xattr labeling and only implement the new semantics for
> >> native labeling.  That's just a matter of adding a flag to
> >> security_context_to_sid_default() and only setting it when calling from
> >> selinux_inode_notifysecctx().
> > 
> > Neither option is very appealing to me, but that doesn't mean I'm saying "no".
> > 
> >  From a sanity and consistency point of view I think option #1 (change
> > the defcontext behavior) is a better choice, and I tend to favor this
> > consistency even with the understanding that it could result in some
> > unexpected behavior for users.  However, if we get complaints, I'm
> > going to revert this without a second thought.
> 
> In that case, I'd suggest splitting it into two patches; first one only 
> enables the new behavior for native labeling filesystems (as per the 
> above, via a flag to security_context_to_sid_default), and the second 
> patch drops the flag and does it unconditionally.  Then you can always 
> revert the latter without affecting the former.
> 
> > 
> > So to answer your question Taras, go ahead and prepare a patch so we
> > can take a look.  A bit of fair warning that it might get delayed
> > until after the upcoming merge window since we are already at -rc5; I
> > want this to have plenty of time in -next.
> > 
> > Thanks guys.

Thanks. I'll prepare patches is a few days.
