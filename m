Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA19645
	for <selinux@tycho.nsa.gov>; Mon, 22 Apr 2002 07:49:14 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA23001
	for <selinux@tycho.nsa.gov>; Mon, 22 Apr 2002 11:47:28 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id LAA22997
	for <selinux@tycho.nsa.gov>; Mon, 22 Apr 2002 11:47:28 GMT
Date: Mon, 22 Apr 2002 07:48:31 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: boot loader
In-Reply-To: <20020420123709.465F819143@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0204220745090.24621-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sat, 20 Apr 2002, Russell Coker wrote:

> I am creating a policy for lilo.
>
> I have defined it's type as follows:
> type lilo_t, domain, privlog, privmem, boot_loader;
>
> privmem is because lilo needs to read from /dev/mem to get BIOS data about
> boot devices.  I have defined "boot_loader" as a type attribute for anything
> that needs to write to raw hard drive devices to install a boot loader (grub
> etc would need that too).  Then I added boot_loader in assert.te as being
> allowed to write to fixed_disk_device_t.
>
> What do you think?

This sounds fine.  Once lilo has been moved into its own domain, you might
try removing direct access to fixed_disk_device_t from sysadm_t
(the admin_domain macro).

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
