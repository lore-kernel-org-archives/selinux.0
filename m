Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6JJW2gA009876
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2005 15:32:02 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6JJRf3G022824
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2005 19:27:41 GMT
Subject: RE: SElinux nss/nscd service
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Daniel J Walsh'" <dwalsh@redhat.com>,
   "'Ulrich Drepper'" <drepper@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <200507191909.j6JJ9Evx014257@gotham.columbia.tresys.com>
References: <200507191909.j6JJ9Evx014257@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Tue, 19 Jul 2005 15:25:22 -0400
Message-Id: <1121801122.7252.15.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> This is different - managing the users as an admin is going to be backend
> specific. Everything that you list is local files specific, right?

Just because passwords are done that way doesn't necessary mean we want 
the selinux map to work that way. I don't see why it has to be backend
specific (but then again, I'm sure there's probably a reason,
or glibc would provide a backend independent write interface for pwd). 

In any case, backend specific or not, I don't plan to reimplement the
read/write code in 10 places, so it should go in a library, not in pam.





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
