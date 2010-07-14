Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o6E2IGBH006922
	for <selinux@tycho.nsa.gov>; Tue, 13 Jul 2010 22:18:16 -0400
Received: from exprod8og112.obsmtp.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id o6E2JwZT025494
	for <selinux@tycho.nsa.gov>; Wed, 14 Jul 2010 02:19:58 GMT
Received: by pxi14 with SMTP id 14so2528660pxi.19
        for <selinux@tycho.nsa.gov>; Tue, 13 Jul 2010 19:18:01 -0700 (PDT)
MIME-Version: 1.0
From: Jason Axelson <jaxelson@referentia.com>
Date: Tue, 13 Jul 2010 16:17:41 -1000
Message-ID: <AANLkTilEZmTTTYxSXlFY343Le2EyvSGD_zWAr8K4ZDVI@mail.gmail.com>
Subject: Using checkmodule to build "old module versions"
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I may be misunderstanding things but I think that a "new" version of
checkmodule is able to create policy versions other than "latest". I
know that checkpolicy accepts the -c option to create binary policies
of older versions. Is there any equivalent for checkmodule?

My version of checkmodule (2.0.21 I believe) when run with -V reports
that it supports "Module versions 4-10", however I do not see any
flags to change the compiled module policy version.

When I then try to load the compiled module on CentOS 5.4 with
"semodule -i A.pp" it responds with:

libsepol.policydb_read: policydb module version 10 does not match my
version range 4-6
libsepol.sepol_module_package_read: invalid module in module package
(at section 0)
libsemanage.semanage_load_module: Error while reading from module file
/etc/selinux/clip/modules/tmp/modules/A.pp.
semodule:  Failed!

So it looks like checkmodule should be able to build policy version 6
which is supported by semodule on the CentOS 5.4 side.

Am I misunderstanding something?

My setup is using Arch Linux as the development machine so I know it
isn't really "supported" per se.

Thanks,
Jason

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
