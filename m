Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9REXGXZ021193
	for <selinux@tycho.nsa.gov>; Wed, 27 Oct 2004 10:33:16 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9REX5Fj018426
	for <selinux@tycho.nsa.gov>; Wed, 27 Oct 2004 14:33:11 GMT
Date: Wed, 27 Oct 2004 10:33:05 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
cc: Darrel Goeddel <dgoeddel@TrustedCS.com>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Chad Hanson <chanson@TrustedCS.com>
Subject: Re: [PATCH] devpts xattr support
In-Reply-To: <1098886534.30470.112.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.44.0410271028050.9447-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 27 Oct 2004, Stephen Smalley wrote:

> On the other hand, adding a fake xattr handler to every filesystem that
> doesn't natively support them also seems difficult to accept; we've only
> done this to date on a demand basis; devpts needed the support for pty
> relabeling, tmpfs needed support for udev.

What other filesystems are likely to need xattr handlers?  It is (now 
especially) very simple to add them as needed.

I think we should stick with the xattr API, it is "the" way to manage
extra-inode data under Linux.  Perhaps what we should do instead is fix
the core xattr code so that it can do what we need it do to.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
