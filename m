Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4SGqELY009414
 for <selinux@tycho.nsa.gov>; Thu, 28 May 2015 12:52:14 -0400
Received: by wifw1 with SMTP id w1so70000238wif.0
 for <selinux@tycho.nsa.gov>; Thu, 28 May 2015 09:52:10 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 28 May 2015 11:52:08 -0500
Message-ID: <CAFPpqQH8nFm0YRM-sgQ_8ijmEy6AFiBaU9-71MWRUJ_w0y6L3Q@mail.gmail.com>
Subject: postgresql policy
From: Ted Toth <txtoth@gmail.com>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The ref policy contains a number of sepgsql_ types that are specific
to the sepgsql postgresql module. The sepgsql module was written to
support a postgresql security patch that was never accepted by the
upstream. Now postgresql has gone in a different direction security
wise adding row level security (RLS). I've been working on developing
RLS policy to label rows on insert and update and to check access
perms on select. I've tried using the sepgsql module in the RLS policy
but have come to the conclusion that because it was not designed for
this purpose it is not usable. So I'd like to suggest that these types
be moved out of the postgresql policy possibly into their own module
although I personally think they have little if any use.

Ted
