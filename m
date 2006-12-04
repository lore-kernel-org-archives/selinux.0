Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kB4Dn091017588
	for <selinux@tycho.nsa.gov>; Mon, 4 Dec 2006 08:49:00 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kB4DmJV8025358
	for <selinux@tycho.nsa.gov>; Mon, 4 Dec 2006 13:48:20 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id kB4DnO49009812
	for <selinux@tycho.nsa.gov>; Mon, 4 Dec 2006 08:49:24 -0500
Message-ID: <45742770.50001@mentalrootkit.com>
Date: Mon, 04 Dec 2006 08:49:36 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: "David O'Brien" <david.obrien@redhat.com>
CC: James Antill <jantill@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: User home directory creation with useradd (rhbz#217441)
References: <1165003691.18588.103.camel@code.and.org> <45708F0B.6080405@mentalrootkit.com> <200612041239.21597.david.obrien@redhat.com>
In-Reply-To: <200612041239.21597.david.obrien@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

David O'Brien wrote:
> On Saturday 02 December 2006 06:22, Karl MacMillan wrote:
>>> 4. Document that you need to call the list of programs in #3.
>> Nobody reads documentation - this isn't viable.  <--------  !!
> 
> Karl... be nice. Tech writers are sensitive beings  ;-)
> 

Sorry! What I really should have said is, people don't normally find 
features through documentation. Rather, they resort to docs once what 
they have found doesn't work correctly. So in this case, if the features 
aren't part of useradd it is unlikely they will find semanage or any 
other SELinux feature.

Karl



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
