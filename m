Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j87HLgOb000840
	for <selinux@tycho.nsa.gov>; Wed, 7 Sep 2005 13:21:43 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j87HINfE027442
	for <selinux@tycho.nsa.gov>; Wed, 7 Sep 2005 17:18:23 GMT
Subject: ANN: Reference Policy Release
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Wed, 07 Sep 2005 13:22:16 -0400
Message-Id: <1126113736.13223.18.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A new release of the SELinux Reference Policy is now available on
Sourceforge from http://serefpolicy.sourceforge.net.  This release
focused on the addition of policies.  The change log follows at the
bottom of the email.

Again, for those that are interesting in contributing, right now the
best help would be to convert existing policies over to reference
policy; there is a list of modules on the status page on Sourceforge.
We are using the NSA example policy 1.23.2 as a baseline for the
policies (also available on the download page), and we ask that these
policies are used when converting modules.  After all of the policies
are converted over, then we will update reference policy to the current
NSA CVS policy.

- Fix errors uncovered by sediff.
- Doc tool will explicitly say a module does not have interfaces
  or templates on the module page.
- Added policies:
        comsat
        dbus
        dhcp
        dictd
        hal
        inn
        ntp
        squid

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
