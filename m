Subject: Re: pp2te
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Tim <elatllat@gmail.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1323352081.13613.14.camel@moss-pluto>
References: 
	 <CA+3zgmsKe+qGsxXksLQtySPuLACEXUAW8qp2NBO_51U3HPH=_g@mail.gmail.com>
	 <1323352081.13613.14.camel@moss-pluto>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 08 Dec 2011 09:14:52 -0500
Message-ID: <1323353692.13613.15.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-12-08 at 08:48 -0500, Stephen Smalley wrote:
> On Wed, 2011-12-07 at 14:13 -0500, Tim wrote:
> > Is there any way to convert targeted policy .pp files to .te files?
> 
> Closest approximation would be to use semodule_unpackage to extract the
> binary .mod file from the .pp file, and then to use dismod to
> disassemble the binary .mod file.  semodule_unpackage.c attached if you
> don't have it and dismod is in the checkpolicy source tree (but not
> built as part of the Fedora package).
> 
> $ gcc -lsepol -o semodule_unpackage semodule_unpackage.c
> $ bunzip2 -c /usr/share/selinux/targeted/apache.pp.bz2 > apache.pp
> $ ./semodule_unpackage apache.pp apache.mod apache.fc
> $ checkpolicy/test/dismod apache.mod

Ah, looks like the Fedora checkpolicy package renames dismod to sedismod
to avoid naming conflicts.  So you can just run sedismod on Fedora.  And
semodule_unpackage has been added to recent versions of policycoreutils,
so you might have it depending on what version you are using.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
