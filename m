Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v9CKdGV5001896
 for <selinux@tycho.nsa.gov>; Thu, 12 Oct 2017 16:39:16 -0400
Received: by mail-io0-f181.google.com with SMTP id j17so6462595iod.5
 for <selinux@tycho.nsa.gov>; Thu, 12 Oct 2017 11:29:14 -0700 (PDT)
MIME-Version: 1.0
From: William Roberts <bill.c.roberts@gmail.com>
Date: Thu, 12 Oct 2017 11:29:10 -0700
Message-ID: <CAFftDdoa-iO3E62FSefdnARHGVzLE4znzaFfSd2Q=9bhdG3=eQ@mail.gmail.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: travis CI
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I see a travis.yml file, recently modified by Nicolas, but I failed to
find the Travis CI instance on travis.org, where is it?

We should likely have it running on commits to the repo and PRs so we
can have some independent way of verifying that our run of the tests
was compromised by some env variation or mistake.

Thoughts?

Bill
