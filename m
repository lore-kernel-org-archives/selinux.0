Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA18810
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 15:56:31 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA00270
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 19:55:02 GMT
Received: from mail.tresys.com (mail.tresys.com [66.22.20.205])
        by jazzband.ncsc.mil  with ESMTP id TAA00266 for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 19:55:01 GMT
Reply-To: <dac@tresys.com>
From: "David Caplan" <dac@tresys.com>
To: "SE Linux" <selinux@tycho.nsa.gov>
Subject: RH util build bug?
Date: Thu, 11 Jul 2002 16:00:14 -0400
Message-ID: <NJEELFKFDFJAACDDMCHCGEFPEEAA.dac@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20020711075746.9521F429@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I was installing the latest version of SEL on a fresh RH7.2 machine and I
got an error when building the util's (see error message at bottom).  In the
past I've been building systems with RH7.1, so I checked and my other (7.1)
system had a different version of /usr/bin/msgfmt (0.10.35 in 7.1 vs.
0.10.38 in 7.2), which is used to build tar-1.13.19 for selinux.  When I put
the 0.10.35 version on the new 7.2 machine I could finish the util's build
without error.

I'm not sure if this is a bug in msgfmt or just some kind of
incompatibility, but I thought I'd let everyone know.

David

make[3]: Entering directory
`/usr/src/selinux-2002-07-08/selinux/utils/tar-1.13.19/po'
PATH=../src:$PATH /usr/bin/xgettext --default-domain=tar --directory=.. \
  --add-comments --keyword=_ --keyword=N_ \
  --files-from=./POTFILES.in \
&& test ! -f tar.po \
   || ( rm -f ./tar.pot \
        && mv tar.po ./tar.pot )
rm -f cat-id-tbl.tmp
sed -f ../intl/po2tbl.sed ./tar.pot \
| sed -e "s/@PACKAGE NAME@/tar/" > cat-id-tbl.tmp
if cmp -s cat-id-tbl.tmp ./cat-id-tbl.c; then \
  rm cat-id-tbl.tmp; \
else \
  echo cat-id-tbl.c changed; \
  rm -f ./cat-id-tbl.c; \
  mv cat-id-tbl.tmp ./cat-id-tbl.c; \
fi
cat-id-tbl.c changed
cd . && rm -f stamp-cat-id && echo timestamp > stamp-cat-id
file=./`echo ko | sed 's,.*/,,'`.gmo \
  && rm -f $file && PATH=../src:$PATH /usr/bin/msgfmt -o $file ko.po
ko.po:1431: invalid multibyte sequence
ko.po:1434: invalid multibyte sequence
found 2 fatal errors
make[3]: *** [ko.gmo] Error 1


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
