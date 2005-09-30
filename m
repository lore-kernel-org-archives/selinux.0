Message-Id: <200509301446.j8UEjwYs008567@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>
Cc: "'George Wilson'" <ltcgcw@us.ibm.com>, "'SELinux'" <SELinux@tycho.nsa.gov>,
   "'Emily Ratliff'" <ratliff@austin.ibm.com>
Subject: RE: seinfo and binary policy endianness
Date: Fri, 30 Sep 2005 10:45:58 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1128090457.12459.123.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Friday, September 30, 2005 10:28 AM
> To: Karl MacMillan
> Cc: 'George Wilson'; 'SELinux'; 'Emily Ratliff'
> Subject: RE: seinfo and binary policy endianness
> 
> On Fri, 2005-09-30 at 10:21 -0400, Karl MacMillan wrote:
> > This approach was discussed when we initially did this work. Again, the
> main
> > drawback is the possibility that libsepol would drop backwards
> compatibility
> > - which I think is a good idea for libsepol. There is no reason to
> maintain
> > the ability to read very old file formats in libsepol, but there is in
> > libapol.
> 
> I'd be surprised if we dropped support for old formats from libsepol.

My concern is that I would be surprised when you did drop that support :)

> We have talked about dropping the backward compatibility code from the
> kernel, but that requires a much tighter binding between policies and
> kernels than currently exists.
> 
> > Other than that, using libsepol may have been easier. At this point,
> though,
> > maintaining our binary parser is a fairly low amount of effort and
> switching
> > would be a large effort.
> 
> You'll come around to our way of thinking eventually ;)
> 

Especially when I get a patch from someone other than us making the change .
. .

------
Karl MacMillan
Tresys Technology
http://www.tresys.com
> --
> Stephen Smalley
> National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
