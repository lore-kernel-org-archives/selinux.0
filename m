Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6JKWUgA010646
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2005 16:32:31 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6JKSC3G002763
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2005 20:28:12 GMT
Subject: RE: SElinux nss/nscd service
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Daniel J Walsh'" <dwalsh@redhat.com>,
   "'Ulrich Drepper'" <drepper@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <200507191950.j6JJotvx014893@gotham.columbia.tresys.com>
References: <200507191950.j6JJotvx014893@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Tue, 19 Jul 2005 16:24:48 -0400
Message-Id: <1121804688.7252.29.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> It doesn't matter whether it is a library or not,

Only it does, because that determines whether the same code has
to be written everywhere, or only once.

>  it matters whether this is a
> public api upon which applications will start to depend. 

Well, there would have to be, unless you want each
caller to do its own thing, instead of using common code.

> Putting this in
> libselinux means that we are stuck with the api for _years_.

Putting this in glibc means the same thing.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
