Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA10051
	for <selinux@tycho.nsa.gov>; Mon, 11 Feb 2002 15:13:36 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA19614
	for <selinux@tycho.nsa.gov>; Mon, 11 Feb 2002 20:12:42 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id UAA19610
	for <selinux@tycho.nsa.gov>; Mon, 11 Feb 2002 20:12:41 GMT
Date: Mon, 11 Feb 2002 15:12:56 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <selinux@tycho.nsa.gov>, <bhards@bigpond.net.au>
Subject: Re: USB device labelling
In-Reply-To: <20020209030840.31A273A6AA0@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0202111459540.19123-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sat, 9 Feb 2002, Russell Coker wrote:

> The ./devices and ./drivers files always exist and should probably be of
> system_u:object_r:sysctl_t.

If these files are merely exporting system information that should be
generally readable, then we might want to use the system_u:object_r:proc_t
security context.

> The directory ./001 represents the USB controller hardware in my computer,
> the file ./001/001 is a USB device attached to the USB controller (which
> happens to be a USB hub).  When I plug a USB device (EG a mouse) into this
> hub then a new file ./001/002 will be created.

Is there any reason to restrict access to the directory, or should it be
generally readable/searchable?  Are the files in this directory actually
device special files that permit read/write access to the device, or are
they something else?  How do they differ from entries in /dev or devfs?

> One way of doing this would make all files default to restrictive permissions
> and then allow /sbin/hotplug to change them back to more usable permissions.
> /sbin/hotplug is run every time a device node is installed anyway, giving it
> permission to relabel files from usb_unlabeled_t to something else and
> changing it's code so it knows how to do so.

The kernel support for this approach would be very straightforward.  We
would simply define an initial SID for this purpose and specify a context
for it in the initial_sid_contexts file.  Every usbdevfs device node could
then be assigned this SID, and we can grant the appropriate permissions to
kmod_t for hotplug to relabel from this SID.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
