Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4ELpasO012752
 for <selinux@tycho.nsa.gov>; Mon, 14 May 2018 17:51:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC12.oob.disa.mil (Postfix) with SMTP id 40lDtG55hSz1pF1L
 for <selinux@tycho.nsa.gov>; Mon, 14 May 2018 21:51:34 +0000 (UTC)
Received: from UPDC3CPA07_EEMSG_MP23.eemsg.mil (unknown [192.168.18.18])
 by UPDCF3IC12.oob.disa.mil (Postfix) with ESMTP id 40lDtF3ztpz1pF1G
 for <selinux@tycho.nsa.gov>; Mon, 14 May 2018 21:51:33 +0000 (UTC)
Received: by mail-lf0-f68.google.com with SMTP id m17-v6so15108551lfj.8
 for <selinux@tycho.nsa.gov>; Mon, 14 May 2018 14:51:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <567735cef55507a38120e30bea178980bb146313.1526173613.git.rgb@redhat.com>
References: <cover.1526173613.git.rgb@redhat.com>
 <567735cef55507a38120e30bea178980bb146313.1526173613.git.rgb@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 14 May 2018 17:51:31 -0400
Message-ID: <CAHC9VhT+9xV-EdChmB4b7pFtNWz2BrEsqWEzqfNSdKg8yj08Jg@mail.gmail.com>
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
Subject: Re: [PATCH ghak81 RFC V2 4/5] audit: use inline function to
 set audit context
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, May 12, 2018 at 9:58 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
> Recognizing that the audit context is an internal audit value, use an
> access function to set the audit context pointer for the task
> rather than reaching directly into the task struct to set it.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  include/linux/audit.h | 6 ++++++
>  kernel/auditsc.c      | 7 +++----
>  kernel/fork.c         | 2 +-
>  3 files changed, 10 insertions(+), 5 deletions(-)

Merged with some minor fuzz.

-- 
paul moore
www.paul-moore.com
