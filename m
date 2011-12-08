MIME-Version: 1.0
In-Reply-To: <1323352081.13613.14.camel@moss-pluto>
References: <CA+3zgmsKe+qGsxXksLQtySPuLACEXUAW8qp2NBO_51U3HPH=_g@mail.gmail.com>
	<1323352081.13613.14.camel@moss-pluto>
Date: Thu, 8 Dec 2011 10:02:05 -0500
Message-ID: <CACLa4pvKsGLCnJ2GsB9-84ok3Ad_ZKcc7rDpAFAOAXM8sdyYSQ@mail.gmail.com>
Subject: Re: pp2te
From: Eric Paris <eparis@parisplace.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Tim <elatllat@gmail.com>, SELinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Dec 8, 2011 at 8:48 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Wed, 2011-12-07 at 14:13 -0500, Tim wrote:
>> Is there any way to convert targeted policy .pp files to .te files?
>
> Closest approximation would be to use semodule_unpackage to extract the
> binary .mod file from the .pp file, and then to use dismod to
> disassemble the binary .mod file.  semodule_unpackage.c attached if you
> don't have it and dismod is in the checkpolicy source tree (but not
> built as part of the Fedora package).

semodule_unpackage is provided in fedora in policycoreutils
dismod is provided in fedora in checkpolicy, although we rename it to sedismod

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
