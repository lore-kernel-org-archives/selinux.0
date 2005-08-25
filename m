Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7PF9dOb016521
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2005 11:09:39 -0400 (EDT)
Subject: RE: libselinux category patch
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chad Hanson <chanson@TrustedCS.com>
Cc: SELinux-dev@tresys.com, Darrel Goeddel <DGoeddel@TrustedCS.com>,
   "'Daniel J Walsh '" <dwalsh@redhat.com>,
   "'SE Linux '" <selinux@tycho.nsa.gov>
In-Reply-To: <36282A1733C57546BE392885C06185920572F6@chaos.tcs.tcs-sec.com>
References: <36282A1733C57546BE392885C06185920572F6@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Date: Thu, 25 Aug 2005 10:56:54 -0400
Message-Id: <1124981814.3873.71.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-08-24 at 16:18 -0400, Chad Hanson wrote:
> We definitely need to allow whitespace in the translated context.

Hmm...translated context is beginning to sound like it has a different
format than the raw context, which means that it needs to be handled via
different manipulation functions than the raw context.  Differences that
seem to be getting proposed include:
- Dan wants to strip the sensitivity entirely from the translated
context in the MCS libsetrans because MCS only uses categories,
- Dan would ideally like to strip object_r from the translated context
since it takes up display space and seemingly provides no useful
information,
- You would like the MLS field to include whitespace in the translated
context.

Do we need a separate set of context* functions for raw vs. translated?
Do we need a separate data type?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
