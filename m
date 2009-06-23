Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n5NI8cie021889
	for <selinux@tycho.nsa.gov>; Tue, 23 Jun 2009 14:08:39 -0400
Received: from ladon.golden-gryphon.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n5NI99CG026104
	for <selinux@tycho.nsa.gov>; Tue, 23 Jun 2009 18:09:09 GMT
Received: from anzu.internal.golden-gryphon.com (tiamat.golden-gryphon.com [204.117.95.118])
	(authenticated bits=128)
	by ladon.golden-gryphon.com (8.14.3/8.14.3/Debian-5) with ESMTP id n5NI2CiH022282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Tue, 23 Jun 2009 13:02:13 -0500
Received: from anzu.internal.golden-gryphon.com.internal.golden-gryphon.com (localhost [127.0.0.1])
	by anzu.internal.golden-gryphon.com (8.14.3/8.14.3/Debian-9) with ESMTP id n5NHqB0O025419
	for <selinux@tycho.nsa.gov>; Tue, 23 Jun 2009 12:52:11 -0500
From: Manoj Srivastava <srivasta@golden-gryphon.com>
To: selinux@tycho.nsa.gov
Subject: Failure to build policycoreutils from git
Date: Tue, 23 Jun 2009 12:52:11 -0500
Message-ID: <87zlbyrg6s.fsf@anzu.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

__> tar zvvfx /usr/local/src/selinux-dev-release/policycoreutils-2.0.64.tar.gz
__> cd policycoreutils-2.0.64
__> make
make[1]: Entering directory `/tmp/policycoreutils-2.0.64/setfiles'
cc -Werror -Wall -W -D_FILE_OFFSET_BITS=64 -I/usr/include   -c -o setfiles.o setfiles.c
cc   setfiles.o  -lselinux -lsepol -L/usr/lib -o setfiles

  …

cc   setsebool.o  -lsepol -lselinux -lsemanage -L/usr/lib -o setsebool
make[1]: Leaving directory `/tmp/policycoreutils-2.0.64/setsebool'
make[1]: Entering directory `/tmp/policycoreutils-2.0.64/po'
make[1]: *** No rule to make target `../gui/booleansPage.py', needed by `policycoreutils.pot'.  Stop.
make[1]: Leaving directory `/tmp/policycoreutils-2.0.64/po'
make: *** [all] Error 1


        Indeed, there is no policycoreutils-2.0.64/gui directory at
 all. I think the pot file needs to be redone, without any extraneos
 directories, or a means for generating the gui dir should be given.

        Thanks,

        manoj
-- 
Manoj Srivastava <srivasta@acm.org> <http://www.golden-gryphon.com/>  
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
