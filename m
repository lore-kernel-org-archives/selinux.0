Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u34M414c005568
 for <selinux@tycho.nsa.gov>; Mon, 4 Apr 2016 18:04:02 -0400
Received: by mail-oi0-f48.google.com with SMTP id p188so185223767oih.2
 for <selinux@tycho.nsa.gov>; Mon, 04 Apr 2016 15:04:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFftDdrefc7BP=bbbh-+-3k3hmYGu0pK6jtoDTcu2Rh9qbLOMg@mail.gmail.com>
References: <1459550439-29408-1-git-send-email-jeffv@google.com>
 <CAHC9VhTQUTAUByVGrrFLxm_w8xzx8cvvrKYscnkRzs7b4fVDsg@mail.gmail.com>
 <CAFftDdrefc7BP=bbbh-+-3k3hmYGu0pK6jtoDTcu2Rh9qbLOMg@mail.gmail.com>
Date: Mon, 4 Apr 2016 15:03:59 -0700
Message-ID: <CABXk95C2HoE2iGmxemeyHB5NSJuNx7_91xaGSp4bQdK44D7wRQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: restrict kernel module loading
From: Jeffrey Vander Stoep <jeffv@google.com>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

> IMHO, the target would be the kernel since its what is being affected by a
> module sourced from foo.

This was my thought as well. What I like about Paul's idea is that it
creates consistency between finit_module and init_module. In either
case the target of the operation is the kernel, but we're using target
context to refer to the origin of the module, not the target of the
operation. For finit_module the origin is a file, for init_module the
origin is a process.

Patch v2 is up.
