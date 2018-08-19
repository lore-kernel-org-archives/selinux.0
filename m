Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w7J8sJUS007063
 for <selinux@tycho.nsa.gov>; Sun, 19 Aug 2018 04:54:23 -0400
Received: from mail-oi0-f53.google.com (mail-oi0-f53.google.com
 [209.85.218.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 199A5561263
 for <selinux@tycho.nsa.gov>; Sun, 19 Aug 2018 10:54:10 +0200 (CEST)
Received: by mail-oi0-f53.google.com with SMTP id k12-v6so20936910oiw.8
 for <selinux@tycho.nsa.gov>; Sun, 19 Aug 2018 01:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180818175033.13100-1-nicolas.iooss@m4x.org>
 <20180818175033.13100-2-nicolas.iooss@m4x.org>
 <CAFftDdr5ZFUUXQZhVDDUTjVRJb6b_zZ4MxHRxTN2d2t5yXXOZA@mail.gmail.com>
In-Reply-To: <CAFftDdr5ZFUUXQZhVDDUTjVRJb6b_zZ4MxHRxTN2d2t5yXXOZA@mail.gmail.com>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Sun, 19 Aug 2018 10:53:57 +0200
Message-ID: <CAJfZ7=nsH+79FzdmFvkG3iC7hBkQEVWicZym5d_KD0+MwJyB6g@mail.gmail.com>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 2/2] libsemanage: make pywrap-test.py compatible
 with Python 3
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, Aug 18, 2018 at 8:43 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> Im assuming with your attention on the python side of the house we're going to see a lot of
> formatting change patches heading the mailing list. I don't have any problems with them.
>
> Are you using some formatter for these, if so which one is it? Is it flake8 still?

I did not use a "formatter" here (I do not consider 2to3 to be a
formatter). I only looked at pep8 and pylint warnings and modified the
code with search-and-replace commands on the file (using regular
expressions). I usually do not like large changes which reindent a
file or add spaces, because it increases the amount of work needed to
backport a later bugfix to released versions, for package maintainers.
Nevertheless when the modified file is not used "in production" (only
when debugging issues or when testing things), as is the case here, I
prefer cleaning up the code.

> We should probably document that patches should be sent formatted, ie if a patch introduces a delta
> after applying the patch and running <formatter>, it's an issue.

I upstreamed scripts/run-flake8 with this in mind ;) (and this is why
I added it to Travis-CI tests too). And one of the reasons that led me
to disable many warnings was to preserve some flexibility in order not
to make submitting patches too hard for new contributors.

In the next days, I plan to send some more patches to fix some
formatting issues I consider important (for example removing
semicolons at the end of Python statements), but I will not send
patches which modify the spaces around operators in files where there
could be bugs which would need to be backported.

As always, thanks for your review!
Nicolas

PS: I am also playing with clang's static analyzer and I am currently
testing a CircleCI configuration which runs it on every push (using
scripts/run-scan-build) and publishes the results as HTML build
artifacts. I will submit a proper patch for this once it is stable
enough and once all the most important issues reported by the analyzer
are fixed.
