Subject: Re: libselinux behavior in permissive mode wrt invalid domains
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Colin Walters <walters@verbum.org>, selinux@tycho.nsa.gov
In-Reply-To: <49E5CFD8.6060903@redhat.com>
References: <faa16b610904141142v1d1e92ddxd78d5e1a0fbb0be7@mail.gmail.com>
	 <49E5CFD8.6060903@redhat.com>
Content-Type: text/plain
Date: Wed, 15 Apr 2009 09:03:47 -0400
Message-Id: <1239800627.27560.34.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-04-15 at 08:15 -0400, Daniel J Walsh wrote:
> On 04/14/2009 02:42 PM, Colin Walters wrote:
> > Hi,
> >
> > I'd like broader input on:
> > http://bugs.freedesktop.org/show_bug.cgi?id=21072
> >
> > Is this something we can do inside libselinux itself?  Or are we
> > planning similar patches around avc_has_perm calls for the X server,
> > libvirt and other userspace programs?
> >
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> > the words "unsubscribe selinux" without quotes as the message.
> 
> So the question is whether the API should return allowed when in 
> permissive mode rather then denied and make every App server code up 
> permissive mode check.
> 
> 
> We have had several bugs where tools have not checked whether the 
> machine is in permissive mode when doing an access check.  One 
> possibility would be to generate the AVC in the check code when in 
> permissive mode or always generat the AVC, there an return allowed.
> 
> If you look at the calling apps point of view it is asking if the user 
> should be allowed the access and in permissive mode he should be allowed 
> the access.

avc_has_perm() already checks for permissive mode internally, unlike
security_compute_av().  However, in this case, the problem is not that
permission was denied but rather that one of the security contexts is no
longer valid.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
