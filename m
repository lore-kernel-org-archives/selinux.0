Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v7NErKId012008
 for <selinux@tycho.nsa.gov>; Wed, 23 Aug 2017 10:53:20 -0400
Date: Wed, 23 Aug 2017 10:52:45 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-audit@redhat.com, SElinux list <selinux@tycho.nsa.gov>
Message-ID: <20170823145245.GT29957@madcap2.tricolour.ca>
References: <ce5219eaed412cc02caef75934b8c3b40087db83.1501158372.git.rgb@redhat.com>
 <CAHC9VhSDkVQAw50bunnmUFzx39eL0H7uoUTpA3XgGO4ywspBmQ@mail.gmail.com>
 <20170823085557.GR29957@madcap2.tricolour.ca>
 <CAHC9VhTLp49s2q9Y6H6H72eo-MswGer51ZtpYK0nDQFiLy7-bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHC9VhTLp49s2q9Y6H6H72eo-MswGer51ZtpYK0nDQFiLy7-bg@mail.gmail.com>
Subject: Re: [PATCH] selinux: remove AVC init audit log message
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 2017-08-23 08:41, Paul Moore wrote:
> On Wed, Aug 23, 2017 at 4:55 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> > On 2017-07-28 18:47, Paul Moore wrote:
> >> On Fri, Jul 28, 2017 at 3:23 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> >> > In the process of normalizing audit log messages, it was noticed that the AVC
> >> > initialization code registered an audit log KERNEL record that didn't fit the
> >> > standard format.  In the process of attempting to normalize it it was
> >> > determined that this record was not even necessary.  Remove it.
> >> >
> >> > Ref: http://marc.info/?l=selinux&m=149614868525826&w=2
> >> > See: https://github.com/linux-audit/audit-kernel/issues/48
> >> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> >> > ---
> >> >  security/selinux/avc.c |    2 --
> >> >  1 files changed, 0 insertions(+), 2 deletions(-)
> >>
> >> Merged, thanks.
> >
> > Where has this been merged?  I'm not able to find it in linux-2.6,
> > selinux/next or pcmoore-audit/next
> 
> I have no idea what you mean by pcmoore-audit/next, that isn't the
> official audit repository or a mirror, but it has been merged into the
> audit/next branch and is present in both the official audit repo on
> kernel.org as well as the https://github.com/linux-audit/audit-kernel
> mirror on GitHub.

My bad.  I forgot to update my git remote references from
infradead...pcmoore/audit to kernel.org...pcmoore/audit

I now see it is in pcmoore-audit/next and linux-next/master.

Sorry for the noise.

>  commit 739bde1f22292d76a179d4cbe29fc7bae86ef5e4
>  Author: Richard Guy Briggs <rgb@redhat.com>
>  Date:   Fri Jul 28 03:23:31 2017 -0400
> 
>    selinux: remove AVC init audit log message
> 
>    In the process of normalizing audit log messages, it was noticed that the AVC
>    initialization code registered an audit log KERNEL record that didn't fit the
>    standard format.  In the process of attempting to normalize it it was
>    determined that this record was not even necessary.  Remove it.
> 
>    Ref: http://marc.info/?l=selinux&m=149614868525826&w=2
>    See: https://github.com/linux-audit/audit-kernel/issues/48
>    Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
>    Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
>    Acked-by: Steve Grubb <sgrubb@redhat.com>
>    Signed-off-by: Paul Moore <paul@paul-moore.com>
> 
> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
