Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j65K3fgA025862
	for <selinux@tycho.nsa.gov>; Tue, 5 Jul 2005 16:03:41 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j65K18St004973
	for <selinux@tycho.nsa.gov>; Tue, 5 Jul 2005 20:01:08 GMT
Message-Id: <200507052001.j65K1W7f018433@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Daniel J Walsh'" <dwalsh@redhat.com>,
   "'Colin Walters'" <walters@verbum.org>
Cc: <selinux@tycho.nsa.gov>
Subject: RE: Groups in the alternative user solution
Date: Tue, 5 Jul 2005 16:01:32 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <42CAE220.9060802@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
> Behalf Of Daniel J Walsh
> Sent: Tuesday, July 05, 2005 3:40 PM
> To: Colin Walters
> Cc: selinux@tycho.nsa.gov
> Subject: Re: Groups in the alternative user solution
> 
> Colin Walters wrote:
> 
> >On Tue, 2005-07-05 at 15:15 -0400, Daniel J Walsh wrote:
> >
> >
> >
> >>This would potentially eliminate the 1000's of file contexts files problem,
> >>since almost all users would map to the default user_r and user_home_t...
> >>for his home dir file context.
> >>
> >>
> >
> >But isn't a large part of the point of this to ensure that e.g. grissom
> >can never access medical records stored in welby's home directory, even
> >if welby accidentally sets the DAC permissions to allow it?  Or is
> >something else in this scheme preventing that?
> >
> >
> >
> I would argue that medical records should never be stored in a users
> home directory.
> 
> The idea here is that the application to view medical records would not
> be able to be run
> by the ordinary user.
> 

The derived home directory types are there to separate contents by role - which
seems important to me (at least today). I think that the primary reason for this
is integrity (.bashrc), but there is no reason that it can't be used for
confidentiality as well. What if that medical record viewing application can
create files in the home directory? If the home directory data is separated by
role then normal users still can't see the data from the records in the event
the viewer app incorrectly saves data to the home directory.

Karl 

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134

> 
> --
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
