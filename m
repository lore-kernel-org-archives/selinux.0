Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j65KRMgA026132
	for <selinux@tycho.nsa.gov>; Tue, 5 Jul 2005 16:27:23 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j65KOnSt006592
	for <selinux@tycho.nsa.gov>; Tue, 5 Jul 2005 20:24:49 GMT
Subject: RE: Groups in the alternative user solution
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Daniel J Walsh'" <dwalsh@redhat.com>,
   "'Colin Walters'" <walters@verbum.org>, selinux@tycho.nsa.gov
In-Reply-To: <200507052001.j65K1W7f018433@gotham.columbia.tresys.com>
References: <200507052001.j65K1W7f018433@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Tue, 05 Jul 2005 16:22:46 -0400
Message-Id: <1120594966.22231.19.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> The derived home directory types are there to separate contents by role - which
> seems important to me (at least today). I think that the primary reason for this
> is integrity (.bashrc), but there is no reason that it can't be used for
> confidentiality as well. What if that medical record viewing application can
> create files in the home directory? If the home directory data is separated by
> role then normal users still can't see the data from the records in the event
> the viewer app incorrectly saves data to the home directory.

I think rbac simply does not work today, because of those per role
directory types. Apps can't read .bashrc, can't read .bash_profile,
can't read .xauth files, and you end up with a nonfunctional system
if you try to manage multiple roles with the same user.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
