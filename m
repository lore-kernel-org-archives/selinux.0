Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA27584
	for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 07:33:20 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id LAA09227
	for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 11:31:40 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id LAA09223 for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 11:31:39 GMT
Date: Mon, 26 Aug 2002 07:32:29 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: devfs_t vs device_t
In-Reply-To: <20020826003626.7F8021665@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0208260729030.10972-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 26 Aug 2002, Russell Coker wrote:

> I have created a new test policy tree with no devfs_t and which uses device_t
> for /dev in both devfs and non-devfs.  I have it working on three machines
> without any problems (apart from the need to change to permissive mode before
> the install of the new policy and reboot afterwards).
>
> Steve, please let me know what you think of this idea.

I'm in favor of such a change.

> As an aside, for future upgrade paths I have been considering a mechanism for
> a policy snippet to be inserted in the running policydb but not in the
> policydb that is loaded from disk at boot time, so therefore you can have
> some temporary rules for running programs that will disappear at reboot time.
> Of course it would be a bad idea to run for weeks or months in such a state,
> but it could be very handy if you want to install a new policy now and then
> schedule a reboot at 8PM to take care of any left-over processes.

Yes, this would likely be useful.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
