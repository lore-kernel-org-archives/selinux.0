Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA18548
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 15:56:03 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA14605
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 19:54:17 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id TAA14599 for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 19:54:16 GMT
Date: Wed, 28 Aug 2002 15:55:52 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: ipsec access to { sysadm_tty_device_t sysadm_devpts_t }
In-Reply-To: <20020827213114.CD4302F61@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0208281554310.25057-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 27 Aug 2002, Russell Coker wrote:

> I have been having some discussions with Steve about access to {
> sysadm_tty_device_t sysadm_devpts_t }.  We agree that giving all daemons
> access to the administrator terminal is a bad idea in concept.
>
> However some programs seem to require it.  The PCMCIA cardmgr program does
> not seem to start correctly unless it has such access.
>
> Now I'm working on ipsec which seems to require { read write ioctl getattr }
> access to those device types for correct functioning.  As I am just learning
> about IPSec I'm not in a good position to analyse this in detail, could
> someone who knows it better please have a look and see if there's something
> that can be done about it or whether it really needs such access.

I would expect that the IKE daemon would not need such access, so that if
we put it into a separate domain from the IPSEC utilities, we could
refrain from granting such access to that domain.  But I haven't tried
this yet.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
