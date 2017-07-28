Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6SMlCgr014254
 for <selinux@tycho.nsa.gov>; Fri, 28 Jul 2017 18:47:13 -0400
Received: by mail-lf0-f66.google.com with SMTP id t128so10804953lff.3
 for <selinux@tycho.nsa.gov>; Fri, 28 Jul 2017 15:47:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ce5219eaed412cc02caef75934b8c3b40087db83.1501158372.git.rgb@redhat.com>
References: <ce5219eaed412cc02caef75934b8c3b40087db83.1501158372.git.rgb@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 28 Jul 2017 18:47:07 -0400
Message-ID: <CAHC9VhSDkVQAw50bunnmUFzx39eL0H7uoUTpA3XgGO4ywspBmQ@mail.gmail.com>
To: Richard Guy Briggs <rgb@redhat.com>
Cc: SElinux list <selinux@tycho.nsa.gov>, linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] selinux: remove AVC init audit log message
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Jul 28, 2017 at 3:23 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> In the process of normalizing audit log messages, it was noticed that the AVC
> initialization code registered an audit log KERNEL record that didn't fit the
> standard format.  In the process of attempting to normalize it it was
> determined that this record was not even necessary.  Remove it.
>
> Ref: http://marc.info/?l=selinux&m=149614868525826&w=2
> See: https://github.com/linux-audit/audit-kernel/issues/48
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  security/selinux/avc.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)

Merged, thanks.

-- 
paul moore
www.paul-moore.com
