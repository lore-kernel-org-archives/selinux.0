Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5CKfqFw021467
 for <selinux@tycho.nsa.gov>; Fri, 12 Jun 2015 16:41:52 -0400
Received: by oigz2 with SMTP id z2so28357074oig.1
 for <selinux@tycho.nsa.gov>; Fri, 12 Jun 2015 13:41:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1434124902-12427-1-git-send-email-jeffv@google.com>
References: <1434124902-12427-1-git-send-email-jeffv@google.com>
Date: Fri, 12 Jun 2015 16:41:50 -0400
Message-ID: <CAHC9VhTr-5zOvriAcMoM24ArseA5cqqo7SQ-Vg_jn6KWHmSspw@mail.gmail.com>
Subject: Re: [PATCH 1/2] security: lsm_audit: add ioctl specific auditing
From: Paul Moore <paul@paul-moore.com>
To: Jeff Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset=UTF-8
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 James Morris <james.l.morris@oracle.com>, Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Jun 12, 2015 at 12:01 PM, Jeff Vander Stoep <jeffv@google.com> wrote:
> Add information about ioctl calls to the LSM audit data. Log the
> file path and command number.
>
> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
> ---
>  include/linux/lsm_audit.h |  7 +++++++
>  security/lsm_audit.c      | 15 +++++++++++++++
>  2 files changed, 22 insertions(+)

Applied to the SELinux next-queue, thanks.

-- 
paul moore
www.paul-moore.com
