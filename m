Subject: RE: seinfo and binary policy endianness
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'George Wilson'" <ltcgcw@us.ibm.com>, "'SELinux'" <SELinux@tycho.nsa.gov>,
   "'Emily Ratliff'" <ratliff@austin.ibm.com>
In-Reply-To: <200509301422.j8UELvYs008023@gotham.columbia.tresys.com>
References: <200509301422.j8UELvYs008023@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 30 Sep 2005 10:27:37 -0400
Message-Id: <1128090457.12459.123.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-09-30 at 10:21 -0400, Karl MacMillan wrote:
> This approach was discussed when we initially did this work. Again, the main
> drawback is the possibility that libsepol would drop backwards compatibility
> - which I think is a good idea for libsepol. There is no reason to maintain
> the ability to read very old file formats in libsepol, but there is in
> libapol.

I'd be surprised if we dropped support for old formats from libsepol.
We have talked about dropping the backward compatibility code from the
kernel, but that requires a much tighter binding between policies and
kernels than currently exists.

> Other than that, using libsepol may have been easier. At this point, though,
> maintaining our binary parser is a fairly low amount of effort and switching
> would be a large effort.

You'll come around to our way of thinking eventually ;)

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
