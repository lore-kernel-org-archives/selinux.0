Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2T2s1Re009006
	for <selinux@tycho.nsa.gov>; Wed, 28 Mar 2007 22:54:01 -0400
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2T2s05u015500
	for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2007 02:54:00 GMT
Received: by py-out-1112.google.com with SMTP id a78so24832pyh
        for <selinux@tycho.nsa.gov>; Wed, 28 Mar 2007 19:53:58 -0700 (PDT)
Message-ID: <460B2925.1080403@gmail.com>
Date: Thu, 29 Mar 2007 10:49:09 +0800
From: Ken YANG <spng.yang@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: "HASHTAB_OVERFLOW" undeclared
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



i want to use findcon to find a type "tmpfs_t".
but in FC, there is setools* package contaning findcon.
i find that secmds(findcon) is in setools-console subpackage
why fc has not this subpackage?

i down a setools-3.1-1.src.rpm from tresys site, and encounter
a build error:

policy_extend.c: In function 'qpol_policy_build_attrs_from_map':
policy_extend.c:170: error: 'HASHTAB_OVERFLOW' undeclared (first use in 
this function)
policy_extend.c:170: error: (Each undeclared identifier is reported only 
once
policy_extend.c:170: error: for each function it appears in.)
policy_extend.c: In function 'qpol_policy_fill_attr_holes':
policy_extend.c:246: error: 'HASHTAB_OVERFLOW' undeclared (first use in 
this function)
make[4]: *** [policy_extend.o] Error 1
make[4]: Leaving directory 
`/workbench/rpmbuild/BUILD/setools-3.1/libqpol/src'


i have not find "HASHTAB_OVERFLOW" in selinux trunk, especially in
libsepol. where is this symbol defined?

by the way, i want checkout setools and try again, but tresys "open
source project" site can not access, maybe is temporary :-)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
