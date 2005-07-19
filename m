Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6JJDdgA009711
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2005 15:13:39 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6JJ8aZb011416
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2005 19:08:36 GMT
Message-Id: <200507191909.j6JJ9Evx014257@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <gyurdiev@redhat.com>
Cc: "'Daniel J Walsh'" <dwalsh@redhat.com>,
   "'Ulrich Drepper'" <drepper@redhat.com>, <selinux@tycho.nsa.gov>
Subject: RE: SElinux nss/nscd service
Date: Tue, 19 Jul 2005 15:09:14 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1121799132.7252.6.camel@celtics.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Ivan Gyurdiev [mailto:gyurdiev@redhat.com]
> Sent: Tuesday, July 19, 2005 2:52 PM
> To: Karl MacMillan
> Cc: 'Daniel J Walsh'; 'Ulrich Drepper'; selinux@tycho.nsa.gov
> Subject: RE: SElinux nss/nscd service
> 
> 
> > No - I want pam_ldap to be able to provide arbitrary data (the SELinux user
> > mapping) to pam_selinux which uses it to obtain the login context. Again,
> don't
> > know if this is possible, but it seems like it should be. An app that
> doesn't
> > want to use pam can directly obtain the data from ldap or whatever - is this
> a
> > big worry? There should be a single authentication method for a system -
> there's
> > a reason no one uses slackware :)
> 
> This is not possible, because this information is necessary for things
> other than login programs:
> 
> - displaying information (system-config-users?)
> - modifying the mapping (usermod? useradd? libuser? userdel?)
> - obtaining the the mapping data for other purposes (genhomedircon)
> 
> So, there are plenty of reasons why the admin requires access to
> other users' mapping data, so this code should be placed in a library.
> By Ulrich's arguments it would seem glibc is not that library...

This is different - managing the users as an admin is going to be backend
specific. Everything that you list is local files specific, right? If an ldap
backend is used the SELinux information should be stored in ldap - nothing else
is remotely manageable. So the pam_* code is only for authentication. Again, the
reason not to put this in a single library is that library will always fail to
work for arbitrary backends - this is the same reason that pam has modules.

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
