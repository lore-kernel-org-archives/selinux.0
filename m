Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u2MNKYZf024089
 for <selinux@tycho.nsa.gov>; Tue, 22 Mar 2016 19:20:34 -0400
Date: Wed, 23 Mar 2016 10:19:47 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: Seth Forshee <seth.forshee@canonical.com>
cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Andy Lutomirski <luto@amacapital.net>,
 "Eric W. Biederman" <ebiederm@xmission.com>, devel@openvz.org,
 Serge Hallyn <serge.hallyn@canonical.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 linux-security-module@vger.kernel.org, linux-mtd@lists.infradead.org,
 selinux@tycho.nsa.gov, linux-fsdevel@vger.kernel.org,
 Konstantin Khorenko <khorenko@virtuozzo.com>,
 Pavel Emelyanov <xemul@virtuozzo.com>
Subject: Re: [PATCH] fs: remove excess check for in_userns
In-Reply-To: <20160315134545.GB27754@ubuntu-xps13>
Message-ID: <alpine.LRH.2.20.1603231019350.24906@namei.org>
References: <1451930639-94331-4-git-send-email-seth.forshee@canonical.com>
 <1458043740-14229-1-git-send-email-ptikhomirov@virtuozzo.com>
 <20160315134545.GB27754@ubuntu-xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 15 Mar 2016, Seth Forshee wrote:

> On Tue, Mar 15, 2016 at 03:09:00PM +0300, Pavel Tikhomirov wrote:
> > If in_userns returns false mnt_may_suid also returns false, and we
> > will reach second(removed) if-check only in case it does not trigger,
> > so remove it.
> 
> We had a somewhat lengthy discussion previously where one of the
> conclusions was that we'd have that check in both places even though
> it's redundant. Iirc the reason was that though they're doing the same
> test they're doing so to answer different questions, so we should have
> the test in both places (or something along those lines).

A comment in the code might be useful here.

-- 
James Morris
<jmorris@namei.org>
