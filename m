Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v7N8uHjE022183
 for <selinux@tycho.nsa.gov>; Wed, 23 Aug 2017 04:56:17 -0400
Date: Wed, 23 Aug 2017 04:55:57 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-audit@redhat.com, SElinux list <selinux@tycho.nsa.gov>
Message-ID: <20170823085557.GR29957@madcap2.tricolour.ca>
References: <ce5219eaed412cc02caef75934b8c3b40087db83.1501158372.git.rgb@redhat.com>
 <CAHC9VhSDkVQAw50bunnmUFzx39eL0H7uoUTpA3XgGO4ywspBmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHC9VhSDkVQAw50bunnmUFzx39eL0H7uoUTpA3XgGO4ywspBmQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: remove AVC init audit log message
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 2017-07-28 18:47, Paul Moore wrote:
> On Fri, Jul 28, 2017 at 3:23 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> > In the process of normalizing audit log messages, it was noticed that the AVC
> > initialization code registered an audit log KERNEL record that didn't fit the
> > standard format.  In the process of attempting to normalize it it was
> > determined that this record was not even necessary.  Remove it.
> >
> > Ref: http://marc.info/?l=selinux&m=149614868525826&w=2
> > See: https://github.com/linux-audit/audit-kernel/issues/48
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  security/selinux/avc.c |    2 --
> >  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> Merged, thanks.

Where has this been merged?  I'm not able to find it in linux-2.6,
selinux/next or pcmoore-audit/next

> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
