Message-ID: <1493046171.6574.1.camel@btinternet.com>
Subject: Re: [RFC PATCH 0/1] libselinux: Add support for
 selinux_check_access_flags
From: Richard Haines <richard_c_haines@btinternet.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Date: Mon, 24 Apr 2017 16:02:51 +0100
In-Reply-To: <1493042781.13274.12.camel@tycho.nsa.gov>
References: <20170424130919.5286-1-richard_c_haines@btinternet.com>
 <1493042781.13274.12.camel@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2017-04-24 at 10:06 -0400, Stephen Smalley wrote:
> On Mon, 2017-04-24 at 14:09 +0100, Richard Haines wrote:
> > Only wanted the avd flags to check whether the domain was
> > permissive
> > or not using an selinux_check_access() type call.
> 
> Why?  What's the intended user?
I was writing patches to update racoon and pluto to use
selinux_check_access in place of avc_open etc. As these programs also
log useful info I thought I would log the SELinux status (permissive
mode etc. etc. for debugging). The only thing missing was if they were
running in a permissive domain so I thought I would see if I could
retrieve this as well. With this patch I can check if permission
granted or not and also if permissive domain (provided of course the
call returned the avd flags).

The other way I thought of was add another entry to selinuxfs and pass
the context to kernel and get whether permissive domain or not.

Is there an easier way to detect a permissive domain without reading
the policy ?


> 
> > 
> > As a consequence of implementing selinux_check_access_flags,
> > additional
> > calls have been added to avc.c: avc_has_perm_flags() and
> > avc_has_perm_noaudit_flags(). Added man page entries for them but
> > not
> > sure
> > if they should be hidden.
> > 
> > Richard Haines (1):
> >   libselinux: Add support for selinux_check_access_flags
> > 
> >  libselinux/include/selinux/avc.h                 |  68 +++++++
> >  libselinux/include/selinux/selinux.h             |  32 +++
> >  libselinux/man/man3/avc_has_perm.3               |  37 +++-
> >  libselinux/man/man3/security_compute_av.3        |  21 +-
> >  libselinux/man/man3/selinux_check_access_flags.3 |   1 +
> >  libselinux/src/avc.c                             |  44 ++++-
> >  libselinux/src/avc_internal.h                    |   1 +
> >  libselinux/src/checkAccess.c                     |  63 +++---
> >  libselinux/utils/.gitignore                      |   2 +
> >  libselinux/utils/avc_has_perm.c                  | 235
> > +++++++++++++++++++++++
> >  libselinux/utils/selinux_check_access.c          | 189
> > ++++++++++++++++++
> >  11 files changed, 660 insertions(+), 33 deletions(-)
> >  create mode 100644
> > libselinux/man/man3/selinux_check_access_flags.3
> >  create mode 100644 libselinux/utils/avc_has_perm.c
> >  create mode 100644 libselinux/utils/selinux_check_access.c
> > 
