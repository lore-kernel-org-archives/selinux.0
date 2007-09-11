Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8BLQxRL029810
	for <selinux@tycho.nsa.gov>; Tue, 11 Sep 2007 17:26:59 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8BLQwbi012382
	for <selinux@tycho.nsa.gov>; Tue, 11 Sep 2007 21:26:58 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l8BLQvGe029109
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <selinux@tycho.nsa.gov>; Tue, 11 Sep 2007 17:26:58 -0400
Subject: Re: concept of a permissive domain
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <46E6FB25.5070507@redhat.com>
References: <1189537981.3407.51.camel@localhost.localdomain>
	 <46E6FB25.5070507@redhat.com>
Content-Type: text/plain
Date: Tue, 11 Sep 2007 17:26:27 -0400
Message-Id: <1189545987.4823.6.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-09-11 at 16:31 -0400, Daniel J Walsh wrote:
[...]
> One other feature/requirement would be to not override dontaudit rules.
> So if I have a domain in permissive mode and I have a dontaudit rule  on
> reading /etc/shadow.  The app should still be denied reading
> /etc/shadow.  (This is not a show stopper, but would allow us to force
> apps to take the code paths they will take in enforcing mode.)

This isn't specific to per-domain permissive, right? It would be useful
in general for permissive.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
