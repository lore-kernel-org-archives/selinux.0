Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3IKiN6G007491
	for <selinux@tycho.nsa.gov>; Wed, 18 Apr 2007 16:44:23 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3IKiLOP023778
	for <selinux@tycho.nsa.gov>; Wed, 18 Apr 2007 20:44:21 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l3IKiLZU013602
	for <selinux@tycho.nsa.gov>; Wed, 18 Apr 2007 16:44:21 -0400
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l3IKiLtf028330
	for <selinux@tycho.nsa.gov>; Wed, 18 Apr 2007 16:44:21 -0400
Received: from [10.11.14.21] (vpn-14-21.rdu.redhat.com [10.11.14.21])
	by pobox-2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l3IKiKsk024078
	for <selinux@tycho.nsa.gov>; Wed, 18 Apr 2007 16:44:20 -0400
Subject: [ANN] New policy representation branch
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: SELinux List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Wed, 18 Apr 2007 16:40:58 -0400
Message-Id: <1176928858.11469.36.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

After some discussion among the SELinux maintainers it was decided that
we would create a new branch to continue the policy representation work
that I started at
http://www.nsa.gov/selinux/list-archive/0702/19105.cfm. Work on the
policy representation will happen in this branch and if the development
is satisfactory trunk will be replaced with this branch at the
appropriate time.

This _does not_ mean that the new policy representation is a foregone
conclusion. This is just an effort to facilitate joint development.

The branch is named policyrep. It can be checked out with:

svn co https://selinux.svn.sourceforge.net/svnroot/selinux selinux/branches/policyrep

And viewed at http://selinux.svn.sourceforge.net/viewvc/selinux/branches/policyrep/.

It is currently identical to trunk, but patches will start appearing
soon. If you want to contribute please send patches to the list for
review.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
