Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tA6Ke9eD008758
 for <selinux@tycho.nsa.gov>; Fri, 6 Nov 2015 15:40:09 -0500
Received: by oiww189 with SMTP id w189so48504447oiw.3
 for <selinux@tycho.nsa.gov>; Fri, 06 Nov 2015 12:40:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20151106181102.GB10239@x250>
References: <1852496.Nbh2u1K4Uk@sifl> <20151106162635.GA10239@x250>
 <CABXk95Ae+pBH0LaQ+93N5mD7GDfPaAJNEQR4qo3VxX+SnFC07g@mail.gmail.com>
 <20151106181102.GB10239@x250>
Date: Fri, 6 Nov 2015 12:40:06 -0800
Message-ID: <CABXk95CJF_LHJndUaoG7mYC-Q7MZuTA2sKRRFTRmkzSa-QwpXA@mail.gmail.com>
Subject: Re: New SELinux userspace release supporting extended ioctl
 permissions?
From: Jeffrey Vander Stoep <jeffv@google.com>
To: Jeffrey Vander Stoep <jeffv@google.com>, Paul Moore <pmoore@redhat.com>,
 SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

> Thanks. that prompted me to see what happened to the seandroid
> repository on bitbucket because it has been stale for a while now.
>
> found
> https://android.googlesource.com/platform/external/sepolicy/+/master/ioctl_macros
>
> That should be easy to implement on GNU/Linux indeed. Will try that soon

It's currently more of a blacklist - just disallow a few operations.
It would be nice to whittle it down to an actual whitelist.
