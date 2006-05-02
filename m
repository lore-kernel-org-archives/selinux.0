Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k42L4vNM012508
	for <selinux@tycho.nsa.gov>; Tue, 2 May 2006 17:04:57 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k42L4u4f024505
	for <selinux@tycho.nsa.gov>; Tue, 2 May 2006 21:04:56 GMT
Subject: ANN: SELinux Policy IDE (SLIDE)
From: Dave Sugar <dsugar@tresys.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Tue, 02 May 2006 17:04:56 -0400
Message-Id: <1146603896.3323.14.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


The second release of the SELinux Policy IDE (SLIDE) from Tresys is now
available for download from the Tresys website and SourceForge.  The
SourceForge website contains documentation and project history.

http://www.tresys.com/selinux
then click on 'SELinux Open Source Technology'
then click on 'SELinux Policy IDE (SLIDE)'

or

http://selinux-ide.sourceforge.net

The tool is an eclipse plug-in the integrates with reference policy and
is useful for policy developers.  

New features since the last release include:
* Search feature to search for specific occurrences of text in policy
source.
*  Filter added to interfaces list to help locate needed interface
easily.
* Simple refactoring including adding and removing ifdef, optional and
tunable blocks.
* Generation of policy based on user selection.

Bugs fixed since the last release include:
* Problem found when copying binary files consumes large amount of hard
disk space.
* Problem creating new modules if no project selected.


Dave Sugar
Tresys Technology
410.290.1411 x138


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
