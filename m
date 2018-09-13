Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8D2Rxh6025486
 for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2018 22:28:00 -0400
Received: by mail-lf1-f66.google.com with SMTP id g6-v6so3420285lfb.11
 for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2018 19:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180907165635.8469-1-kent.overstreet@gmail.com>
 <20180907165635.8469-4-kent.overstreet@gmail.com>
 <89c167ff-91d3-7a27-78c6-82710bb11771@I-love.SAKURA.ne.jp>
 <20180907175014.GA29485@kmo-pixel>
In-Reply-To: <20180907175014.GA29485@kmo-pixel>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 12 Sep 2018 22:27:40 -0400
Message-ID: <CAHC9VhS=CaEd4quGRv97Dn_2gm7=jMq+nHJvSOnuBtoA=DZvDQ@mail.gmail.com>
To: kent.overstreet@gmail.com, selinux@tycho.nsa.gov
Cc: penguin-kernel@i-love.sakura.ne.jp, linux-kernel@vger.kernel.org,
 dave.hansen@intel.com, willy@infradead.org,
 linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 3/6] selinux: convert to kvmalloc
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Sep 7, 2018 at 1:50 PM Kent Overstreet
<kent.overstreet@gmail.com> wrote:
> On Sat, Sep 08, 2018 at 02:08:03AM +0900, Tetsuo Handa wrote:
> > On 2018/09/08 1:56, Kent Overstreet wrote:
> > > @@ -329,8 +328,7 @@ int avtab_alloc(struct avtab *h, u32 nrules)
> > >             nslot = MAX_AVTAB_HASH_BUCKETS;
> > >     mask = nslot - 1;
> > >
> > > -   h->htable = flex_array_alloc(sizeof(struct avtab_node *), nslot,
> > > -                                GFP_KERNEL | __GFP_ZERO);
> > > +   h->htable = kvmalloc_array(nslot, sizeof(void *), GFP_KERNEL);
> > >     if (!h->htable)
> > >             return -ENOMEM;
> > >
> >
> > kvmalloc_array() does not imply __GFP_ZERO.
>
> Thanks, fixed

When you resubmit this patch, please make sure you submit it to the
SELinux list (added to the To line above) so that it can be properly
reviewed and merged.

Thanks.

-- 
paul moore
www.paul-moore.com
