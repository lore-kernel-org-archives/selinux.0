Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA25457
	for <selinux@tycho.nsa.gov>; Fri, 3 May 2002 08:25:15 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA08329
	for <selinux@tycho.nsa.gov>; Fri, 3 May 2002 12:23:23 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id MAA08325
	for <selinux@tycho.nsa.gov>; Fri, 3 May 2002 12:23:23 GMT
Date: Fri, 3 May 2002 08:24:25 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: why is this needed?
In-Reply-To: <20020503030531.6A58C49@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0205030822540.16931-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 3 May 2002, Russell Coker wrote:

> This is in the sample policy, why is it needed?
>
> allow initrc_t framebuf_device_t:lnk_file read;
> allow initrc_t framebuf_device_t:devfile_class_set setattr;

They show up as denials on a boot of RH7.[12] when setting device
ownerships/modes.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
