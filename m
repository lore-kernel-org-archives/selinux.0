Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAC2TNEj008379
 for <selinux@tycho.nsa.gov>; Fri, 11 Nov 2016 21:29:23 -0500
Received: by mail-ua0-f194.google.com with SMTP id 20so2139484uak.0
 for <selinux@tycho.nsa.gov>; Fri, 11 Nov 2016 18:29:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1478854120-25311-1-git-send-email-shailendra.v@samsung.com>
References: <1478854120-25311-1-git-send-email-shailendra.v@samsung.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 11 Nov 2016 21:29:21 -0500
Message-ID: <CAHC9VhRsDdFohpmDkD2JGCnz5v3Tg7NHQDF7g8gCOj7_6D6jfg@mail.gmail.com>
Subject: Re: [PATCH] Security: selinux - Improvement in code readability when
To: Shailendra Verma <shailendra.v@samsung.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shailendra Verma <shailendra.capricorn@gmail.com>, vidushi.koul@samsung.com
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Nov 11, 2016 at 3:48 AM, Shailendra Verma
<shailendra.v@samsung.com> wrote:
> From: "Shailendra Verma" <shailendra.v@samsung.com>
>
> There is no need to call kfree() if memdup_user() fails, as no memory
> was allocated and the error in the error-valued pointer should be returned.
>
> Signed-off-by: Shailendra Verma <shailendra.v@samsung.com>
> ---
>  security/selinux/selinuxfs.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Hello Shailendra,

Thank you for your patch, but I prefer the readability of the code as
it currently stands.

-- 
paul moore
www.paul-moore.com
