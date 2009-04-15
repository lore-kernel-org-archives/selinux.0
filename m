Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3FCFQS3000960
	for <selinux@tycho.nsa.gov>; Wed, 15 Apr 2009 08:15:26 -0400
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3FCFPNK018757
	for <selinux@tycho.nsa.gov>; Wed, 15 Apr 2009 12:15:25 GMT
Message-ID: <49E5CFD8.6060903@redhat.com>
Date: Wed, 15 Apr 2009 08:15:20 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Colin Walters <walters@verbum.org>
CC: selinux@tycho.nsa.gov
Subject: Re: libselinux behavior in permissive mode wrt invalid domains
References: <faa16b610904141142v1d1e92ddxd78d5e1a0fbb0be7@mail.gmail.com>
In-Reply-To: <faa16b610904141142v1d1e92ddxd78d5e1a0fbb0be7@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 04/14/2009 02:42 PM, Colin Walters wrote:
> Hi,
>
> I'd like broader input on:
> http://bugs.freedesktop.org/show_bug.cgi?id=21072
>
> Is this something we can do inside libselinux itself?  Or are we
> planning similar patches around avc_has_perm calls for the X server,
> libvirt and other userspace programs?
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

So the question is whether the API should return allowed when in 
permissive mode rather then denied and make every App server code up 
permissive mode check.


We have had several bugs where tools have not checked whether the 
machine is in permissive mode when doing an access check.  One 
possibility would be to generate the AVC in the check code when in 
permissive mode or always generat the AVC, there an return allowed.

If you look at the calling apps point of view it is asking if the user 
should be allowed the access and in permissive mode he should be allowed 
the access.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
