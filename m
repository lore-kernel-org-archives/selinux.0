Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9481MsJ014938
	for <selinux@tycho.nsa.gov>; Sat, 4 Oct 2003 04:01:22 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h947xWZt014218
	for <selinux@tycho.nsa.gov>; Sat, 4 Oct 2003 07:59:32 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id h947xLM3014215
	for <selinux@tycho.nsa.gov>; Sat, 4 Oct 2003 07:59:23 GMT
Date: Sat, 4 Oct 2003 18:01:03 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: serial devices
Message-ID: <20031004080103.GC1080@snoopy.apana.org.au>
References: <200310041420.21903.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200310041420.21903.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Oct 04, 2003 at 02:20:21PM +1000, Russell Coker wrote:
> Currently we have serial ports labeled at tty_device_t by default.
> 
> The problem is that serial ports are used for modems, printers, and many other 
> things than terminals.  Currently the sample policy does not permit such 
> access.  So cups and lpd are not granted access, and if you want to run 
> minicom you have to change the context of the device (and add new policy) or 
> run minicom as sysadm_t.
> 
> I have been thinking of creating a new type for non-login serial devices and 
> granting pppd, cups and lpd full access to it, then the administrator would 
> have the option of granting users access to it for running minicom without 
> allowing them to spoof logins.

What would happen on smaller systems like my desktop machine where I
want to use modems for dial-in and dial-out?

> Another possibility is to have different types for the device as used by cups, 
> pppd, and minicom.  Then change the contexts of serial devices to indicate 
> which service they are for, but this could be painful to administer.

This would be my preference. If I have a modem connected to the serial
port, I don't want somebody compromising cups, and then use that as a
stepping stone to make expense telephone calls at my expense...

Not that I consider this is very likely.

If its going to be difficult to aminister, I wonder if there is anything
that could be done to simplify the task?
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
