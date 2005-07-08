Message-Id: <200507081928.j68JSDvx005028@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Daniel J Walsh'" <dwalsh@redhat.com>, <gyurdiev@redhat.com>,
   "'Stephen Smalley'" <sds@tycho.nsa.gov>
Cc: "'SELinux'" <SELinux@tycho.nsa.gov>
Subject: RE: libsemod????
Date: Fri, 8 Jul 2005 15:28:13 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <42CEAE9E.5090902@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
> Behalf Of Daniel J Walsh
> Sent: Friday, July 08, 2005 12:50 PM
> To: gyurdiev@redhat.com; Stephen Smalley
> Cc: SELinux
> Subject: libsemod????
> 
> Why are we creating more libraries?  What benefit does the added
> complexity give us?  Why not just have one library for policy file
> management and one for selinux management?  A developer using these
> libraries in the future is not going to care about selinux/sepol/semod.
> He wants to build an selinux aware app he will probably want to link to
> libselinux.
> 
>  ls -l /lib/libse*
> -rwxr-xr-x  1 root root  77192 Jun 29 16:08 /lib/libselinux.so.1
> -rwxr-xr-x  1 root root 135140 Jul  7 07:15 /lib/libsepol.so.1
> 
> Are these libraries too large.  I do not want to add additional packages
> just for libraries.
> 
> --
> 

The three libraries accomplish 3 very different tasks:

1. Libsepol - policy manipulation.
2. Libselinux - access / labeling decisions and other runtime policy support.
3. Libsemod (which has been suggested off-list to become libsemanage) -
management of selinux policy including addition and removal of modules, selinux
user management, file context modification, etc.

I think that as things move forward the applications that link to multiple
versions will decrease. User-space object managers and trusted selinux aware
applications (e.g., dbus or login) will link to libselinux. Management tools
will link to libsemod (e.g., semodule, useradd). Libsepol is the backend for the
management tools - it could be made static I guess.

The alternative is that dbus will have code for adding policy modules including
over the network in the future (if libsemod is merged with libselinux) or that
checkpolicy will have the same code (if it is merged with libsepol). Doesn't
seem ideal to me. What is the downside? Extra packages?

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134

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
