Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u34MVH8G011601
 for <selinux@tycho.nsa.gov>; Mon, 4 Apr 2016 18:31:18 -0400
Received: by mail-oi0-f44.google.com with SMTP id p188so186000522oih.2
 for <selinux@tycho.nsa.gov>; Mon, 04 Apr 2016 15:31:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CABXk95C2HoE2iGmxemeyHB5NSJuNx7_91xaGSp4bQdK44D7wRQ@mail.gmail.com>
References: <1459550439-29408-1-git-send-email-jeffv@google.com>
 <CAHC9VhTQUTAUByVGrrFLxm_w8xzx8cvvrKYscnkRzs7b4fVDsg@mail.gmail.com>
 <CAFftDdrefc7BP=bbbh-+-3k3hmYGu0pK6jtoDTcu2Rh9qbLOMg@mail.gmail.com>
 <CABXk95C2HoE2iGmxemeyHB5NSJuNx7_91xaGSp4bQdK44D7wRQ@mail.gmail.com>
Date: Mon, 4 Apr 2016 18:31:15 -0400
Message-ID: <CAHC9VhTm0en=_attHg2WmoAwNuVRfiO5OmzX3g2YEujsN5YNPg@mail.gmail.com>
Subject: Re: [PATCH] selinux: restrict kernel module loading
From: Paul Moore <paul@paul-moore.com>
To: Jeffrey Vander Stoep <jeffv@google.com>
Cc: William Roberts <bill.c.roberts@gmail.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Apr 4, 2016 at 6:03 PM, Jeffrey Vander Stoep <jeffv@google.com> wrote:
>> IMHO, the target would be the kernel since its what is being affected by a
>> module sourced from foo.
>
> This was my thought as well. What I like about Paul's idea is that it
> creates consistency between finit_module and init_module. In either
> case the target of the operation is the kernel, but we're using target
> context to refer to the origin of the module, not the target of the
> operation. For finit_module the origin is a file, for init_module the
> origin is a process.

Close enough ;)

> Patch v2 is up.

Yep, I've been distracted with some other things today, but I'll take
a look tomorrow.

-- 
paul moore
www.paul-moore.com
