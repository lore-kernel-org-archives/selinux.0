Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j67JRrgA015116
	for <selinux@tycho.nsa.gov>; Thu, 7 Jul 2005 15:27:53 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j67JPb3a008881
	for <selinux@tycho.nsa.gov>; Thu, 7 Jul 2005 19:25:37 GMT
Subject: ANN: New SELinux Reference Policy Release
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 07 Jul 2005 15:25:45 -0400
Message-Id: <1120764345.6145.17.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A new release of the SELinux Reference Policy is now available on
Sourceforge from http://serefpolicy.sourceforge.net.  The change log
follows at the bottom of the email.  In particular, we've cut back the
verbosity of the inline documentation by shortening the tags and
inferring the interface, layer, and module tags.  Also, most of the
support for targeted policy has been added (transition booleans being
the notable missing part), but it is untested.

For those that are interesting in contributing, right now the best help
would be to convert existing policies over to reference policy; there is
a list of modules on the status page on Sourceforge.  We are using the
NSA example policy 1.23.2 as a baseline for the policies (also available
on the download page), and we ask that these policies are used when
converting modules.  After all of the policies are converted over, then
we will update reference policy to the current NSA CVS policy.

20050707 (7 Jul 2005)
        * Changed xml to have modules encapsulated by layer tags, rather
          than putting layer="foo" in the module tags.  Also in the future
          we can put a summary and description for each layer.
        * Added tool to infer interface, module, and layer tags.  This will
          now list all interfaces, even if they are missing xml docs.
        * Shortened xml tag names.
        * Added macros to declare interfaces and templates.
        * Added interface call trace.
        * Updated all xml documentation for shorter and inferred tags.
        * Doc tool now displays templates in the web pages.
        * Doc tool retains the user's settings in modules.conf and
          tunables.conf if the files already exist.
        * Modules.conf behavior has been changed to be a list of all
          available modules, and the user can toggle the module on or
          off to include the module or not.
        * Added policies:
                fstools (fsck, mkfs, swapon, etc. tools)
                logrotate
                inetd
                kerberos
                nis (ypbind and ypserv)
                ssh (server, client, and agent)
                unconfined
        * Added infrastructure for targeted policy support, only missing
          transition boolean support.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
