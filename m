Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v8CL7uYS020636
 for <selinux@tycho.nsa.gov>; Tue, 12 Sep 2017 17:07:56 -0400
Received: by mail-wm0-f51.google.com with SMTP id f199so2931747wme.0
 for <selinux@tycho.nsa.gov>; Tue, 12 Sep 2017 12:49:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAB9W1A1s20MMUyA5cgJteNA+r4V1Wo1VvWvaDj5M-ZSyR=o-8Q@mail.gmail.com>
References: <20170911104141.2629-1-cgzones@googlemail.com>
 <CAB9W1A1s20MMUyA5cgJteNA+r4V1Wo1VvWvaDj5M-ZSyR=o-8Q@mail.gmail.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Tue, 12 Sep 2017 21:49:46 +0200
Message-ID: <CAJ2a_DdP-PNB9pC7Cf-X36w=6-GchpVx8QumRrzznBA6ZqTGew@mail.gmail.com>
To: Stephen Smalley <stephen.smalley@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] libselinux: log no default label warning in verbose mode
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

> This seems to revert what was an intentional change to avoid noise in
> fixfiles check output. See the mailing list discussions that preceded and
> followed the patch.


In my opinion, it's a helpful noise, which is triggered by an intended
file context `<<none>>`.
Is there any hack to get the old behavior back other than `find /run
-exec restorecon -n {} \;`?
