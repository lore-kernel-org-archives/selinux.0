Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t55KSoBK014024
 for <selinux@tycho.nsa.gov>; Fri, 5 Jun 2015 16:28:50 -0400
Received: by wgv5 with SMTP id 5so64841870wgv.1
 for <selinux@tycho.nsa.gov>; Fri, 05 Jun 2015 13:28:47 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 5 Jun 2015 15:28:47 -0500
Message-ID: <CAFPpqQEKBu2SsRN=GJj2SMvNLDW+Hj91MUTkU_L_-3DbKaW1Xg@mail.gmail.com>
Subject: refpolicywarn usage
From: Ted Toth <txtoth@gmail.com>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I tried to use "refpolicywarn(`$0($*) has been deprecated.')" in a
deprecated interface removing all of the previously defined policy.
However the interface is used in an 'optional' which then causes the
policy compilation to fail. What is the right way to handle this
situation?

Ted
