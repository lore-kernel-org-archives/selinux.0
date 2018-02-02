Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w12KKeKd019232
 for <selinux@tycho.nsa.gov>; Fri, 2 Feb 2018 15:20:41 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC13.oob.disa.mil (Postfix) with SMTP id 3zY7dy2vScz2FxrM
 for <selinux@tycho.nsa.gov>; Fri,  2 Feb 2018 20:20:38 +0000 (UTC)
Received: from UPDC3CPA02.eemsg.mil (unknown [192.168.18.9])
 by UPDCF3IC13.oob.disa.mil (Postfix) with ESMTP id 3zY7dy1Tjyz2FxrT
 for <selinux@tycho.nsa.gov>; Fri,  2 Feb 2018 20:20:38 +0000 (UTC)
Received: by mail-lf0-f48.google.com with SMTP id q17so33240747lfa.9
 for <selinux@tycho.nsa.gov>; Fri, 02 Feb 2018 12:20:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <52754014-7f0f-bd9a-483f-b12fb90cb044@sony.com>
References: <20180202080554.9689-1-peter.enderborg@sony.com>
 <1517580659.28460.9.camel@tycho.nsa.gov>
 <52754014-7f0f-bd9a-483f-b12fb90cb044@sony.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 2 Feb 2018 15:19:36 -0500
Message-ID: <CAHC9VhT=HcWyej=e-Ji1nEoz_q=Hwm-e332RemwfpW4s-dE60w@mail.gmail.com>
To: peter enderborg <peter.enderborg@sony.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH-selinuxns] selinux: Annotate lockdep for
 services locks
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Feb 2, 2018 at 9:40 AM, peter enderborg
<peter.enderborg@sony.com> wrote:
> I will send the patches to pauls next tree. Im abit confused on when that is
> appropriate. Obviously there will be collisions with the namespace, but
> the patches also solves few of my prerequisite topics.

In an effort to clear up any confusion, here is the tentative plan ...
While I generally try to avoid rebasing the selinux/next branch, there
are a few things that we probably want to pull in from Linus' tree, so
after the merge window closes (I expect that to happen next weekend)
I'll rebase selinux/next to v4.16-rc1.  I always send a note to the
list when I rebase the selinux/next branch.

>From there, it's a matter of sorting out the merging logistics; I
suspect Stephen will probably just rebase his own selinuxns patches
(and presumably incorporate any feedback), but I tend to be a bit more
forgiving about manual fixups when merging patches after a rebase.
After Stephen's patches are merged we can merge the other bits that
rely on them.

Does that make sense?

-- 
paul moore
www.paul-moore.com
