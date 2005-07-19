Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6JJo5gA010126
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2005 15:50:05 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6JJj1Zb017463
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2005 19:45:02 GMT
Message-Id: <200507191945.j6JJjVvx014794@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Ulrich Drepper'" <drepper@redhat.com>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>
Cc: <gyurdiev@redhat.com>, <selinux@tycho.nsa.gov>
Subject: RE: SElinux nss/nscd service
Date: Tue, 19 Jul 2005 15:45:31 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
In-reply-to: <42DD4972.5040204@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Ulrich Drepper [mailto:drepper@redhat.com]
> Sent: Tuesday, July 19, 2005 2:42 PM
> To: Daniel J Walsh
> Cc: Karl MacMillan; gyurdiev@redhat.com; selinux@tycho.nsa.gov
> Subject: Re: SElinux nss/nscd service
> 
> Daniel J Walsh wrote:
> > So you want the pam_selinux module to implement all the potential
> > backends?  What happens if an app does not use pam but needs this info?
> 
> What "all the potential backends"?  Just define the backend is LDAP and
> be done with it.  And NIS/NIS+ backend needs specific code to be written
> to access the data which is not going to be added to glibc either unless
> there is *real* need shown.  Plus, NIS is completely unsafe and for NIS+
> there is no server implementation available.  The only other backends in
> use are some database backed ones but those are highly suspicious and I
> doubt they work reliably.
> 

? Potential means that they might not exist yet.

> Just implement it somewhere for now.  In a couple of months/a year we
> can revisit the decision.
> 

Which means changing every caller. If we want to just hack something, fine, let's just call it a hack though.

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134

> --
> ➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
