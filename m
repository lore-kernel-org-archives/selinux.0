Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA06070
	for <selinux@tycho.nsa.gov>; Fri, 22 Mar 2002 08:56:26 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA23701
	for <selinux@tycho.nsa.gov>; Fri, 22 Mar 2002 13:55:22 GMT
Received: from angusbay.vnl.com ([194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id NAA23697 for <selinux@tycho.nsa.gov>; Fri, 22 Mar 2002 13:55:21 GMT
Date: Fri, 22 Mar 2002 14:08:33 +0000
From: Dale Amon <amon@vnl.com>
To: Stephen Smalley <sds@tislabs.com>
Cc: Russell Coker <russell@coker.com.au>, selinux <selinux@tycho.nsa.gov>
Subject: Re: package configuration (for dpkg - rpm will have the same issues)
Message-ID: <20020322140833.GD2123@vnl.com>
References: <20020320171217.2BF8A3CF33@lyta.coker.com.au> <Pine.GSO.4.33.0203201230580.11981-100000@raven>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.33.0203201230580.11981-100000@raven>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Mar 20, 2002 at 12:48:40PM -0500, Stephen Smalley wrote:
> When a new package is installed on a system running SELinux, I expected
> chcon or the modified file utilities to be used to set the security
> context appropriately for its files in a similar manner to the use
> of chown/chmod or the existing file utilities for setting the Unix
> attributes.  But it also seems necessary to update the setfiles
> configuration for future installations, resets, or major policy changes.
> So perhaps a hacked setfiles is a good idea.

Perhaps a 'setfiles --dump > file_contexts' capability is in order?


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
