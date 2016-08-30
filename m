Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7ULFtOe018213
 for <selinux@tycho.nsa.gov>; Tue, 30 Aug 2016 17:15:56 -0400
Received: by mail-oi0-f42.google.com with SMTP id f189so44330755oig.3
 for <selinux@tycho.nsa.gov>; Tue, 30 Aug 2016 14:15:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <147259160184.15526.16504125805093739705.stgit@localhost>
References: <147259160184.15526.16504125805093739705.stgit@localhost>
From: Paul Moore <pmoore@redhat.com>
Date: Tue, 30 Aug 2016 17:15:51 -0400
Message-ID: <CAGH-KgtOQx6XLStD++n8kBMKNky1t8or7KC2UyYxdaRXjQMhbA@mail.gmail.com>
Subject: Re: [PATCH] audit: consistently record PIDs with task_tgid_nr()
To: Jeff Vander Stoep <jeffv@google.com>, linux-audit@redhat.com
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Aug 30, 2016 at 5:13 PM, Paul Moore <pmoore@redhat.com> wrote:
> From: Paul Moore <paul@paul-moore.com>
>
> Unfortunately we record PIDs in audit records using a variety of
> methods despite the correct way being the use of task_tgid_nr().
> This patch converts all of these callers, except for the case of
> AUDIT_SET in audit_receive_msg() (see the comment in the code).
>
> Reported-by: Jeff Vander Stoep <jeffv@google.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  kernel/audit.c       |    8 +++++++-
>  kernel/auditsc.c     |   12 ++++++------
>  security/lsm_audit.c |    4 ++--
>  3 files changed, 15 insertions(+), 9 deletions(-)

I forgot to tag this with "RFC".  This patch compiles but I haven't
had a chance to test it yet so it isn't going into audit#next just
yet; if you have any concerns, now is the time to voice them.

-- 
paul moore
security @ redhat
