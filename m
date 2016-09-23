Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8NK9VnC002806
 for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2016 16:09:31 -0400
Received: by mail-qt0-f172.google.com with SMTP id 93so57728006qtg.2
 for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2016 13:09:15 -0700 (PDT)
Message-ID: <57E58BE9.9030401@quarksecurity.com>
Date: Fri, 23 Sep 2016 16:09:13 -0400
From: Joshua Brindle <brindle@quarksecurity.com>
MIME-Version: 1.0
To: William Roberts <bill.c.roberts@gmail.com>
CC: seandroid-list@tycho.nsa.gov, selinux@tycho.nsa.gov,
 Jeff Vander Stoep <jeffv@google.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Daniel Cashman <dcashman@android.com>
Subject: Re: Killing The Android libselinux Fork (available)
References: <CAFftDdqDxr6jqC7t1imRrQ7dMJEsZh--L0CrWOCzgYUfwNeZyA@mail.gmail.com>
 <CAFftDdoXEo9Q7bRrr-AeHFX7eauKGeWzqRW-m_Z=hfXUT_JFUA@mail.gmail.com>
 <CABXk95BAor2Y7nvOZkkwEsc=8xgoa63x89WQtCbXDvzu_Pch_A@mail.gmail.com>
 <CAFftDdqr_DXtkaTkUApdsp7Nq5bm3FrUEq2xRDkc6b7Omx5RxQ@mail.gmail.com>
 <57E534DE.9070500@quarksecurity.com>
 <CAFftDdqs21PprRVRYfMjHXH2Qe7x3eYz8cR2M-bLbTso9HdnoQ@mail.gmail.com>
 <57E58A06.90103@quarksecurity.com>
 <CAFftDdoE+9Q+kWg2SjNWXQzSjYx5MxahoYydNVo45h+4n5O8aw@mail.gmail.com>
In-Reply-To: <CAFftDdoE+9Q+kWg2SjNWXQzSjYx5MxahoYydNVo45h+4n5O8aw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

William Roberts wrote:
<snip>
>
> Thanks Josh, I'll look at these and prep patches. Weird Android builds with
> clang,
> I wonder why it's not catching some of these.
>

Not sure, for reference the version installed here is :

Apple LLVM version 8.0.0 (clang-800.0.38)
