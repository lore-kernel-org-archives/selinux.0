Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v7EL12hL003088
 for <selinux@tycho.nsa.gov>; Mon, 14 Aug 2017 17:01:02 -0400
Received: by mail-lf0-f65.google.com with SMTP id o85so7317877lff.1
 for <selinux@tycho.nsa.gov>; Mon, 14 Aug 2017 14:00:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e9f47cc9-fda7-dc54-bca9-cae6488914e0@users.sourceforge.net>
References: <e9f47cc9-fda7-dc54-bca9-cae6488914e0@users.sourceforge.net>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 14 Aug 2017 16:59:55 -0400
Message-ID: <CAHC9VhQOVyA8bu5qWz7=KtGQ_kEVQmso539-VHpd+gGb7L7rig@mail.gmail.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Alexey Dobriyan <adobriyan@gmail.com>,
 Daniel Jurgens <danielj@mellanox.com>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 Junil Lee <junil0814.lee@lge.com>, "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 William Roberts <william.c.roberts@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 0/4] SELinux: Fine-tuning for some function implementations
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sun, Aug 13, 2017 at 10:43 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 13 Aug 2017 16:25:43 +0200
>
> A few update suggestions were taken into account
> from static source code analysis.
>
> Markus Elfring (4):
>   Delete eight unnecessary variable assignments
>   Adjust jump targets in ebitmap_read()
>   Delete an unnecessary return statement in ebitmap_destroy()
>   Adjust five checks for null pointers

Hi Markus,

I merged many of your patches in the past because I wanted to help
encourage your involvement, but you will remember I mentioned at the
time that I generally dislike merging these trivial, and often
style-only, patches.  I believe I even pointed you in the direction of
our SELinux kernel issue tracker for a list of areas where you could
help contribute in a meaningful way (link below).  My earlier comments
still apply; if you want to continue to contribute to SELinux in the
kernel, please focus your attention on more meaningful changes.  I am
not going to merge any of these patches.

* https://github.com/SELinuxProject/selinux-kernel/issues

-- 
paul moore
www.paul-moore.com
