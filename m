Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4QG5FNR008929
 for <selinux@tycho.nsa.gov>; Fri, 26 May 2017 12:05:15 -0400
Received: by mail-lf0-f54.google.com with SMTP id h4so8378550lfj.3
 for <selinux@tycho.nsa.gov>; Fri, 26 May 2017 09:05:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <149581433492.13821.14132385005185399089.stgit@sifl>
References: <149581433492.13821.14132385005185399089.stgit@sifl>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 26 May 2017 12:05:11 -0400
Message-ID: <CAHC9VhSKK-D0MWpnaOpF00RkaXVkWk9yzbnuM-22upq=v=nHdA@mail.gmail.com>
Subject: Re: [RFC PATCH] tools: add perltidy to the syntax checker/fixer
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, May 26, 2017 at 11:58 AM, Paul Moore <pmoore@redhat.com> wrote:
> From: Paul Moore <paul@paul-moore.com>
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  tools/check-syntax |   86 ++++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 66 insertions(+), 20 deletions(-)

As previously mentioned this patch is an RFC because I think we should
have some discussion about what Perl style we want to adopt for the
tests.  I'm not much of a Perl coder so I'm happy to defer to others
who may have a strong opinion.

At present the script runs perltidy without any options, according to
the manpage this should format the Perl code according to the
perlstyle(1) manpage; if no one has a strong opinion, this may be the
"right" style to use.

-- 
paul moore
www.paul-moore.com
