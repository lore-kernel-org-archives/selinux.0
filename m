Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3RLWGxn022067
 for <selinux@tycho.nsa.gov>; Sun, 27 Apr 2014 17:32:16 -0400
Received: by mail-ee0-f43.google.com with SMTP id e53so4316897eek.30
 for <selinux@tycho.nsa.gov>; Sun, 27 Apr 2014 14:32:16 -0700 (PDT)
Received: from [192.168.1.100] ([84.245.1.4])
 by mx.google.com with ESMTPSA id x46sm44716148een.17.2014.04.27.14.32.14
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=RC4-SHA bits=128/128);
 Sun, 27 Apr 2014 14:32:15 -0700 (PDT)
Message-ID: <1398634334.25918.4.camel@x220.localdomain>
Subject: fpp/cilpolicy potential bug
From: Dominick Grift <dominick.grift@gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Date: Sun, 27 Apr 2014 23:32:14 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I have not double checked this but i suspect that ffp parses the context
specs with keywords the wrong way around

i think for example it does "/bla/bla" "HOME_DIR" where it should be
"HOME_DIR" "/bla/bla"

I noticed when i grepped the generated file_contexts that the fc specs
with keywords were the wrong way around.

This is just a quick note. I might be wrong.
