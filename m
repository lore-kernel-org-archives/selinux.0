Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6JIwngA009472
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2005 14:58:49 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6JIsU3G018306
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2005 18:54:31 GMT
Subject: RE: SElinux nss/nscd service
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Daniel J Walsh'" <dwalsh@redhat.com>,
   "'Ulrich Drepper'" <drepper@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <200507191844.j6JIhwvx013861@gotham.columbia.tresys.com>
References: <200507191844.j6JIhwvx013861@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Tue, 19 Jul 2005 14:52:12 -0400
Message-Id: <1121799132.7252.6.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> No - I want pam_ldap to be able to provide arbitrary data (the SELinux user
> mapping) to pam_selinux which uses it to obtain the login context. Again, don't
> know if this is possible, but it seems like it should be. An app that doesn't
> want to use pam can directly obtain the data from ldap or whatever - is this a
> big worry? There should be a single authentication method for a system - there's
> a reason no one uses slackware :)

This is not possible, because this information is necessary for things
other than login programs:

- displaying information (system-config-users?)
- modifying the mapping (usermod? useradd? libuser? userdel?)
- obtaining the the mapping data for other purposes (genhomedircon)
 
So, there are plenty of reasons why the admin requires access to
other users' mapping data, so this code should be placed in a library.
By Ulrich's arguments it would seem glibc is not that library...



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
