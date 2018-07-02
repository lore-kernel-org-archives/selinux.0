Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w62Ie547024182
 for <selinux@tycho.nsa.gov>; Mon, 2 Jul 2018 14:40:07 -0400
Received: from mail-oi0-f45.google.com (mail-oi0-f45.google.com
 [209.85.218.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 2A2705647CF
 for <selinux@tycho.nsa.gov>; Mon,  2 Jul 2018 20:38:40 +0200 (CEST)
Received: by mail-oi0-f45.google.com with SMTP id 13-v6so5827936ois.1
 for <selinux@tycho.nsa.gov>; Mon, 02 Jul 2018 11:38:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFftDdohqWAb7o7aa=eWjN4m9WnJESaxQn56R8StYHEb-3bL5A@mail.gmail.com>
References: <20180701145739.23309-1-nicolas.iooss@m4x.org>
 <CAFftDdohqWAb7o7aa=eWjN4m9WnJESaxQn56R8StYHEb-3bL5A@mail.gmail.com>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Mon, 2 Jul 2018 20:38:38 +0200
Message-ID: <CAJfZ7=k9pVgmMoQJV6zvyEd4qRKyN_QqutBAU5Pyh7+XNMSsmQ@mail.gmail.com>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 1/1] mcstrans: fix memory leaks reported by
 clang's static analyzer
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sun, Jul 1, 2018 at 10:51 PM, William Roberts
<bill.c.roberts@gmail.com> wrote:
> I see lots of repeating blocks, would it make more sense to goto an
> error label and free them then return -1?

Both trans_context() and untrans_context() currently define "char
*ltrans = NULL, *utrans = NULL;" and "char *lrange = NULL, *urange =
NULL;" in the body of a for loop. Introducing an error label at the
end of these functions requires moving these definition outside of the
loop (which could introduce side effects) and introducing the label at
the end of the loop makes the code less readable, IMHO. I guess this
could explain why the current code does not use a "goto error" or
"goto clean" approach and leaks memory where an error occurs.

Anyway, if you are fine with moving the definitions of some variables
(ltrans and utrans for trans_context(), lrange and urange for
untrans_context()), I can write, test and send a new patch with a
"goto error" instead of several free().

Thanks for your review,
Nicolas
