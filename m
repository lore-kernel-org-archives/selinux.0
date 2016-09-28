MIME-Version: 1.0
From: William Roberts <bill.c.roberts@gmail.com>
Date: Wed, 28 Sep 2016 10:39:35 -0400
Message-ID: <CAFftDdo3rRxW=qEzcLJbAABxJ09XmEK6_=x_6TiiZ5avxM9opQ@mail.gmail.com>
Subject: DISABLE_AVC=y
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Does anyone actualy use this, this currently doesn't build:

compute_av.c: In function ‘security_compute_av_flags_raw’:
compute_av.c:65:28: error: suggest braces around empty body in an ‘if’
statement [-Werror=empty-body]
   map_decision(tclass, avd);
                            ^
cc1: all warnings being treated as errors
make[1]: *** [compute_av.o] Error 1

clude -D_GNU_SOURCE -DDISABLE_AVC   -c -o compute_av.o compute_av.c
compute_av.c: In function ‘security_compute_av_flags_raw’:
compute_av.c:65:28: error: expected expression before ‘;’ token
   map_decision(tclass, avd);
                            ^
make[1]: *** [compute_av.o] Error 1
make[1]: Leaving directory `/home/wc

Should we fix it or kill it off?

-- 
Respectfully,

William C Roberts
