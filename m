Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA3HRXXZ016475
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 12:27:33 -0500 (EST)
Received: from glaurung.internal.golden-gryphon.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA3HRWJZ005757
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 17:27:33 GMT
Received: from glaurung.internal.golden-gryphon.com (srivasta@localhost [127.0.0.1])
	by glaurung.internal.golden-gryphon.com (8.13.1/8.13.1/Debian-16) with ESMTP id iA3HMsA7022973
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 11:22:54 -0600
To: selinux@tycho.nsa.gov
Subject: selinux-doc problems
From: Manoj Srivastava <manoj.srivastava@stdc.com>
Date: Wed, 03 Nov 2004 11:22:54 -0600
Message-ID: <87is8msv81.fsf@glaurung.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

	While trying to package selinux-doc 1.16 for Debian, I ran
 into a bunch of jade errors:

	Firstly, "_"  in ID's:
----------------------------------------------------------------------
jade:selinux-doc-1.14/module/changes.sgml:107:11:E: character "_" is not allowed in the value of attribute "ID"
jade:selinux-doc-1.14/module/changes.sgml:139:15:E: character "_" is not allowed in the value of attribute "LINKEND"
jade:selinux-doc-1.14/module/changes.sgml:140:9:E: character "_" is not allowed in the value of attribute "LINKEND"
jade:selinux-doc-1.14/module/changes.sgml:148:11:E: character "_" is not allowed in the value of attribute "ID"
----------------------------------------------------------------------

	And then there are the missing quotes on attribute values:
----------------------------------------------------------------------
jade:selinux-doc-1.14/module/task.sgml:29:13:E: an attribute value specification must be an attribute value literal unless SHORTTAG YES is specified
jade:selinux-doc-1.14/module/task.sgml:31:13:E: an attribute value specification must be an attribute value literal unless SHORTTAG YES is specified
jade:selinux-doc-1.14/module/task.sgml:31:21:E: an attribute value specification must be an attribute value literal unless SHORTTAG YES is specified
----------------------------------------------------------------------

        Is there an effort underway to update the selinux-doc package?
 If so, I'll hold off fixing up the SGML issues and wait for the new
 version (I lack the knowledge to actually update the contents).

	thanks

	manoj
-- 
All progress is based on a universal innate desire on the part of
every organism to live beyond its income.  -- Samuel Butler
Manoj Srivastava   <manoj.srivastava@stdc.com>    <srivasta@acm.org> 
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
