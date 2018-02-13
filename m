Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w1DHtJLK019709
 for <selinux@tycho.nsa.gov>; Tue, 13 Feb 2018 12:55:20 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC02.oob.disa.mil (Postfix) with SMTP id 3zgqv94wl9z2SlcD
 for <selinux@tycho.nsa.gov>; Tue, 13 Feb 2018 17:55:17 +0000 (UTC)
Received: from UPBD19PA05.eemsg.mil (unknown [192.168.18.6])
 by UPDCF3IC02.oob.disa.mil (Postfix) with ESMTP id 3zgqv946nSz2Slc8
 for <selinux@tycho.nsa.gov>; Tue, 13 Feb 2018 17:55:17 +0000 (UTC)
Received: by mail-lf0-f44.google.com with SMTP id t79so26217045lfe.3
 for <selinux@tycho.nsa.gov>; Tue, 13 Feb 2018 09:55:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1518538932.18249.14.camel@btinternet.com>
References: <CAHC9VhR22eO9ugfAaY=PM9_aaHVa1hD05LFffNT-pXjz2Zt3Rw@mail.gmail.com>
 <1518538932.18249.14.camel@btinternet.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 13 Feb 2018 12:55:15 -0500
Message-ID: <CAHC9VhSxN2qcMWCmwx8oTb9+-XzE=uqGv+yhmz1MLPbSx5utZA@mail.gmail.com>
To: Richard Haines <richard_c_haines@btinternet.com>
Cc: linux-sctp@vger.kernel.org, selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Subject: Re: FYI: selinux/next rebased to v4.16-rc1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Feb 13, 2018 at 11:22 AM, Richard Haines
<richard_c_haines@btinternet.com> wrote:
> On Mon, 2018-02-12 at 16:13 -0500, Paul Moore wrote:
>> A quick note to let you know that I've just rebased the selinux/next
>> branch to v4.16-rc1.  Over the next day or two I'm going to be
>> working
>> through the backlog of kernel patches, most notably the SCTP work.
>>
>
> I've just rebuilt the SCTP patch set on Fedora using:
>
> kernel-4.16.0-0.rc1.git0.1.fc28.src.rpm
>
> I found there were a number of changes required to get the SCTP
> specific patches (2/4 and 3/4) to build as there have been many updates
> since kernel 4.14.
>
> The 4-16 kernel build passes my SCTP SELinux Testsuite although I also
> added the "netlabel: If PF_INET6, check sk_buff ip header version" [1]
> patch as well.
>
> It's probably best I post these patches so the SCTP team can finally ok
> them (or not).

If you don't mind doing the rebase that would be helpful.  We'll have
to wait and see what the changes look like, but I don't expect there
to be a problem with the SCTP folks, Marcelo has been very helpful
thus far.

As far as the NetLabel patch is concerned, yes, go ahead and include
that in the patchset.

Thanks!

> [1] https://marc.info/?l=selinux&m=151061619115945&w=2



-- 
paul moore
www.paul-moore.com
