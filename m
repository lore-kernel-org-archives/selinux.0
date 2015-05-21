Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4L4HiTN006603
 for <selinux@tycho.nsa.gov>; Thu, 21 May 2015 00:17:44 -0400
Received: by obbea2 with SMTP id ea2so17454107obb.3
 for <selinux@tycho.nsa.gov>; Wed, 20 May 2015 21:17:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <555D3E20.7050907@quarksecurity.com>
References: <1428616130-14570-1-git-send-email-jeffv@google.com>
 <1684020.b5Ioztp7mc@sifl>
 <CAFftDdqfcMGht2JWHzPcBUauD-7RTXio=aTHHNMUKcJPPNLeRg@mail.gmail.com>
 <555D3E20.7050907@quarksecurity.com>
Date: Wed, 20 May 2015 21:17:38 -0700
Message-ID: <CABXk95CESxmfTbmpTyx0_jkj3TXs6EEYeZwo_Jpri0nAVtUCDg@mail.gmail.com>
Subject: Re: [PATCH 0/2] selinux: add targeted whitelisting of ioctl commands.
From: Jeffrey Vander Stoep <jeffv@google.com>
To: Joshua Brindle <brindle@quarksecurity.com>
Content-Type: text/plain; charset=UTF-8
Cc: linux-security-module@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 James Morris <james.l.morris@oracle.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Thanks for all the feedback and suggestions. Agreed that raw numerical
values are confusing. I will fix up the commit message to set a better
precedent for intended use. I included them more to illustrate what is
happening under the hood. I like the idea of a qualifier for clarity.
The qualifier seems necessary for the suggested non-ioctl-specific
approach.

Individual ioctl labels are only marginally better than raw numbers.
E.g. { TCSETSF TIOCGWINSZ TCGETA TCSETA TCSETAW TCSETAF TCSBRK TCXONC
TIOCMBIS }. More helpful...but not much.

My plan was to group commonly used ioctl sets into macros.

e.g. common_socket_ioc, priv_socket_ioc, tty_ioc, gpu_ioc, etc

After monitoring ioctl use across five different devices I think this
is a good approach as just 10-20 macros would be adequate for a
targeted policy and would provide a clearer explanation of the
permissions given.
