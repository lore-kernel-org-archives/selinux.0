Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s0AEnlSE005557
 for <selinux@tycho.nsa.gov>; Fri, 10 Jan 2014 09:49:47 -0500
Received: by mail-qc0-f181.google.com with SMTP id e9so3768179qcy.26
 for <selinux@tycho.nsa.gov>; Fri, 10 Jan 2014 06:49:30 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Changing unlabeled_t on files to invalid_label_t.
Date: Fri, 10 Jan 2014 09:49:28 -0500
Message-ID: <2516775.9uuOuGk0G5@sifl>
In-Reply-To: <52D006E2.5030906@tycho.nsa.gov>
References: <52CF1A53.9080501@redhat.com>
 <CACLa4pvs_qwHn3sf-y0bMZ5wSPs6C39nFZGsptDqo=kje2E5tg@mail.gmail.com>
 <52D006E2.5030906@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: SE-Linux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Friday, January 10, 2014 09:42:42 AM Stephen Smalley wrote:
> On 01/09/2014 06:07 PM, Eric Paris wrote:
> > I believe we need a new initial sid.  SECINITSID_INVALID_LABEL....
> 
> Difficult (impossible?) to do in a fully backward compatible manner (to
> include the case of loading new policy on old kernel, whether initially
> or update/reload on an already running kernel with an older policy).

Do we really need to worry about being able to load new policy into a old 
kernel?  In general I thought the backward compatible issue was that newer 
kernels needed to support older userspace, not the other way around.

-- 
paul moore
www.paul-moore.com
