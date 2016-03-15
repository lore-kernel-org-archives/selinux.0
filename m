Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u2FDjnOn022981
 for <selinux@tycho.nsa.gov>; Tue, 15 Mar 2016 09:45:49 -0400
Received: by mail-ob0-f171.google.com with SMTP id m7so17230247obh.3
 for <selinux@tycho.nsa.gov>; Tue, 15 Mar 2016 06:45:47 -0700 (PDT)
Date: Tue, 15 Mar 2016 08:45:45 -0500
From: Seth Forshee <seth.forshee@canonical.com>
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: Andy Lutomirski <luto@amacapital.net>,
 "Eric W. Biederman" <ebiederm@xmission.com>, devel@openvz.org,
 Serge Hallyn <serge.hallyn@canonical.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 linux-security-module@vger.kernel.org, linux-mtd@lists.infradead.org,
 selinux@tycho.nsa.gov, linux-fsdevel@vger.kernel.org,
 Konstantin Khorenko <khorenko@virtuozzo.com>,
 Pavel Emelyanov <xemul@virtuozzo.com>
Subject: Re: [PATCH] fs: remove excess check for in_userns
Message-ID: <20160315134545.GB27754@ubuntu-xps13>
References: <1451930639-94331-4-git-send-email-seth.forshee@canonical.com>
 <1458043740-14229-1-git-send-email-ptikhomirov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1458043740-14229-1-git-send-email-ptikhomirov@virtuozzo.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Mar 15, 2016 at 03:09:00PM +0300, Pavel Tikhomirov wrote:
> If in_userns returns false mnt_may_suid also returns false, and we
> will reach second(removed) if-check only in case it does not trigger,
> so remove it.

We had a somewhat lengthy discussion previously where one of the
conclusions was that we'd have that check in both places even though
it's redundant. Iirc the reason was that though they're doing the same
test they're doing so to answer different questions, so we should have
the test in both places (or something along those lines).

Thanks,
Seth
