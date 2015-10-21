Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t9LEl5at014553
 for <selinux@tycho.nsa.gov>; Wed, 21 Oct 2015 10:47:05 -0400
Date: Wed, 21 Oct 2015 14:43:13 +0000 (UTC)
From: Richard Haines <richard_c_haines@btinternet.com>
Reply-To: Richard Haines <richard_c_haines@btinternet.com>
To: Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 William Roberts <bill.c.roberts@gmail.com>
Message-ID: <794034857.1436125.1445438594096.JavaMail.yahoo@mail.yahoo.com>
In-Reply-To: <CAFftDdpub5p8h5S4cbi=sgWk8GB3DM48X33WYX6B054eQcKgDw@mail.gmail.com>
References: <CAFftDdpub5p8h5S4cbi=sgWk8GB3DM48X33WYX6B054eQcKgDw@mail.gmail.com>
Subject: Re: did libselinux grow a new build dependency? (openssl-devel:
 openssl.h)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

FYI 

The implementation at www.ghostscript.com/doc/jbig2dec/sha1.c
and CryptLib are both from the same original author
Steve Reid <sreid@sea-to-sky.net>

I've now tested and timed both implementations along with the
Android version + openssl.

openssl and Steve's implementations are about twice as fast
as the Android version.

I'll submit a patch based on the sha1 files extracted from CryptLib
as that is the latest one to be updated.
