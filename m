Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4HN0uDf015633
 for <selinux@tycho.nsa.gov>; Thu, 17 May 2018 19:00:57 -0400
Received: by mail-lf0-f66.google.com with SMTP id r25-v6so11168162lfd.1
 for <selinux@tycho.nsa.gov>; Thu, 17 May 2018 16:00:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <12a849e41468d761e0782c733e58db47d83b0d16.1526430313.git.rgb@redhat.com>
References: <cover.1526430313.git.rgb@redhat.com>
 <12a849e41468d761e0782c733e58db47d83b0d16.1526430313.git.rgb@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 17 May 2018 19:00:46 -0400
Message-ID: <CAHC9VhR0Y6ZO80XrRF45QD30Gi1TK49-JTSTY0wThWZ1nrGarA@mail.gmail.com>
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux NetDev Upstream Mailing List <netdev@vger.kernel.org>,
 Netfilter Devel List <netfilter-devel@vger.kernel.org>,
 Linux Security Module list <linux-security-module@vger.kernel.org>,
 Integrity Measurement Architecture <linux-integrity@vger.kernel.org>,
 SElinux list <selinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
 Steve Grubb <sgrubb@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH ghak81 V3 1/3] audit: use new audit_context
 access funciton for seccomp_actions_logged
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, May 16, 2018 at 7:55 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> On the rebase of the following commit on the new seccomp actions_logged
> function, one audit_context access was missed.
>
> commit cdfb6b341f0f2409aba24b84f3b4b2bba50be5c5
> ("audit: use inline function to get audit context")
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/auditsc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into audit/next, thanks for the follow-up.

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index cbab0da..f3d3dc6 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2497,7 +2497,7 @@ void audit_seccomp_actions_logged(const char *names, const char *old_names,
>         if (!audit_enabled)
>                 return;
>
> -       ab = audit_log_start(current->audit_context, GFP_KERNEL,
> +       ab = audit_log_start(audit_context(), GFP_KERNEL,
>                              AUDIT_CONFIG_CHANGE);
>         if (unlikely(!ab))
>                 return;
> --
> 1.8.3.1

-- 
paul moore
www.paul-moore.com
