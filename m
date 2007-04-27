Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3R2KRu6015465
	for <selinux@tycho.nsa.gov>; Thu, 26 Apr 2007 22:20:27 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3R2KPi0023560
	for <selinux@tycho.nsa.gov>; Fri, 27 Apr 2007 02:20:25 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l3R2KPkU013009
	for <selinux@tycho.nsa.gov>; Thu, 26 Apr 2007 22:20:25 -0400
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l3R2KP3u018373
	for <selinux@tycho.nsa.gov>; Thu, 26 Apr 2007 22:20:25 -0400
Received: from [10.11.14.16] (vpn-14-16.rdu.redhat.com [10.11.14.16])
	by pobox-2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l3R2KOiI023315
	for <selinux@tycho.nsa.gov>; Thu, 26 Apr 2007 22:20:25 -0400
Subject: Re: [POLICYREP PATCH] Add objset to libsepol
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: selinux@tycho.nsa.gov
In-Reply-To: <20070425215822.16055.18880.stgit@localhost.localdomain>
References: <20070425215822.16055.18880.stgit@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 26 Apr 2007 22:13:27 -0400
Message-Id: <1177640007.6287.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-04-25 at 17:58 -0400, Karl MacMillan wrote:
> Add the objset data structure to libsepol. Object sets behave similarly to
> Python sets.
> 

After many revisions this has been merged into the policyrep branch.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
