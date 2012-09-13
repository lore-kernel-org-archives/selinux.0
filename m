Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q8DKk1KG028117
	for <selinux@tycho.nsa.gov>; Thu, 13 Sep 2012 16:46:01 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q8DKjxfK013196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 13 Sep 2012 16:45:59 -0400
Received: from localhost (vpn-9-132.rdu.redhat.com [10.11.9.132])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q8DKjwdB003144
	for <selinux@tycho.nsa.gov>; Thu, 13 Sep 2012 16:45:59 -0400
Date: Thu, 13 Sep 2012 16:45:56 -0400
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Subject: system without libsepol
Message-ID: <20120913164556.00d45eb3@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Is it reasonable to expect a system without libsepol to be able to load
policy?  I know the code can do it right now, but does anyone do it?
I'd like to remove and try to rework some of that code so it is cleaner
and more obvious.  Anyone see a problem with requiring libspol be
installed if libselinux was build with shared library expectations?

-Eric

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
