Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7K4s7rT001532
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 00:54:07 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7K4s6Q4017044
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 04:54:07 GMT
Date: Fri, 20 Aug 2004 00:54:02 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: tmpfs xattrs and stuff
In-Reply-To: <20040811222033.GI30160@lkcl.net>
Message-ID: <Xine.LNX.4.44.0408200051030.20379-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 11 Aug 2004, Luke Kenneth Casson Leighton wrote:

> ... anyone had a chance to play with the tmpfs xattrs, mess with
> udev, that sort of random and hairy stuff?

Yes, I'm integrating your patch to tmpfs as part of a consolidation of
xattr handling for the upstream kernel.  (Let me know if you want 
copyright lines added to the files you significantly modified).


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
