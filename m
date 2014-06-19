Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s5JIx3ZR010135
 for <selinux@tycho.nsa.gov>; Thu, 19 Jun 2014 14:59:06 -0400
Received: by mail-qc0-f181.google.com with SMTP id x13so2545470qcv.26
 for <selinux@tycho.nsa.gov>; Thu, 19 Jun 2014 11:59:07 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 1/2] selinux: simple cleanup for cond_read_node()
Date: Thu, 19 Jun 2014 14:59:04 -0400
Message-ID: <18713609.X6uzY7R5jD@sifl>
In-Reply-To: <CAM9d7cj07=ERVUnEhpCu6g72HsXCFSFmha8U6BZL6BbYBxckEg@mail.gmail.com>
References: <1402762742-2808-1-git-send-email-namhyung@kernel.org>
 <1719649.5PAcuqR8Pm@sifl>
 <CAM9d7cj07=ERVUnEhpCu6g72HsXCFSFmha8U6BZL6BbYBxckEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Stephen Smalley <sds@tycho.nsa.gov>, LKML <linux-kernel@vger.kernel.org>,
 selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thursday, June 19, 2014 08:58:31 AM Namhyung Kim wrote:
> Hi Paul,
> 
> On Thu, Jun 19, 2014 at 4:36 AM, Paul Moore <paul@paul-moore.com> wrote:
> > > @@ -402,19 +402,14 @@ static int cond_read_node(struct policydb *p,
> > > struct
> >> 
> >> cond_node *node, void *fp) int rc;
> >> 
> >>       struct cond_expr *expr = NULL, *last = NULL;
> >> 
> >> -     rc = next_entry(buf, fp, sizeof(u32));
> >> +     rc = next_entry(buf, fp, sizeof(buf));
> > 
> > This is a bit nit-picky, but how about using "sizeof(u32) * 2"?  It is
> > more
> > consistent with the rest of the function and helps underscore that we are
> > reading two 32-bit values.
> > 
> > Assuming you're okay with the change I can fix it up when I apply the
> > patch.
>
> I'm okay with it. :)

Great, both patches are applied.

-- 
paul moore
www.paul-moore.com
