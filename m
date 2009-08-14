Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7EFBZV4021638
	for <selinux@tycho.nsa.gov>; Fri, 14 Aug 2009 11:11:35 -0400
Received: from ladon.golden-gryphon.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n7EFCd5T018330
	for <selinux@tycho.nsa.gov>; Fri, 14 Aug 2009 15:12:39 GMT
Received: from anzu.internal.golden-gryphon.com (tiamat.golden-gryphon.com [204.117.95.118])
	(authenticated bits=128)
	by ladon.golden-gryphon.com (8.14.3/8.14.3/Debian-5) with ESMTP id n7EF6pRh001812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Fri, 14 Aug 2009 10:06:58 -0500
Received: from anzu.internal.golden-gryphon.com.internal.golden-gryphon.com (localhost [127.0.0.1])
	by anzu.internal.golden-gryphon.com (8.14.3/8.14.3/Debian-9) with ESMTP id n7EExkns030595
	for <selinux@tycho.nsa.gov>; Fri, 14 Aug 2009 09:59:47 -0500
From: Manoj Srivastava <srivasta@golden-gryphon.com>
To: selinux@tycho.nsa.gov
Subject: policycoreutils, sepolgen (sepolgen-ifgen) issues on Debian
Date: Fri, 14 Aug 2009 09:59:46 -0500
Message-ID: <87d46y1lwd.fsf@anzu.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

        I am running into an issue with sepolgen on Debian. Debian ships
 more than one  version of the refpolicy, a default one, and a
 MLS enabled one. So, the include files live in either
 /usr/share/selinux/{default,mls}/include

        sepolgen (in src/sepolgen/defaults.py) sets refpolicy_devel() to
 a single location -- and thus, only one version of the security policy
 may be supported. So, sepolgen-ifgen from policycoreutils can only work
 with one policy, which may not be the one installed on the target
 machine. Could this be made configurable, somehow? As far as I can
 see, sepolgen's python library does not offer any way to set the value.

        It would be nice if the location of the include directory could
 be looked for from a PATH like variable setting, to make it easier for
 distributions to ship more than one policy, or for end users to
 experiment with other policies without have to overwrite the single
 default. 

        manoj
-- 
Manoj Srivastava <srivasta@acm.org> <http://www.golden-gryphon.com/>  
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
