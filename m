Message-ID: <011401c12464$842d10c0$020144c0@windows>
From: "Eric Peters" <eric@peters.org>
To: <SELinux@tycho.nsa.gov>
Cc: "Stephen Smalley" <sds@tislabs.com>
Subject: SE Linux II?
Date: Mon, 13 Aug 2001 18:57:42 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Recently you (Stephen Smalley) wrote:

To date, development on the LSM-based SELinux prototype (or SELinux II,
if you prefer) has focused on providing the same functionality present
in the original SELinux prototype (i.e. fine-grained and flexible
nondiscretionary access controls) as a loadable kernel module that
uses the LSM hooks rather than our own custom kernel patch.
Currently, SELinux II seems to be stable enough for release, and
does provide most of the functionality of the original prototype
(we're still working on the network access controls).  It should
be released soon on the NSA web site.

We are currently working off of the LSM kernel patch
(lsm-2001_08_07 against 2.4.7) from lsm.immunix.org, so you
could investigate integrating that into your FOLK patch if
you want to support SELinux II.

-------

Is there really any ETA on this release?

I'm just looking at maybe a rough date of perhaps a week/two etc? So that I
can do some planning for testin/moving some system over to it (so it would
hopefully at that point be more "upgradeable" without excessive kernel
recompiles correct?)

Thanks,

Eric


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
