Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i87NnZrT000274
	for <selinux@tycho.nsa.gov>; Tue, 7 Sep 2004 19:49:35 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i87Nmgxo005830
	for <selinux@tycho.nsa.gov>; Tue, 7 Sep 2004 23:48:42 GMT
Date: Wed, 8 Sep 2004 01:00:37 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Patch to make udev/tmpfs work and changes from colin  walters for dbus.
Message-ID: <20040908000037.GD6506@lkcl.net>
References: <413E1DE0.9050905@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <413E1DE0.9050905@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Sep 07, 2004 at 04:45:20PM -0400, Daniel J Walsh wrote:
> Adding
> 
> restorecon /dev /dev/null
> restorecon /dev/*

 yes, it does, doesn't it!

 that's why i wrote a little script called /sbin/restoredevicefiles
 and call it from at least two places in /etc/init.d scripts!!

 if you find that you don't need also to do restorecon /dev/*/*
 please let me know.

 also i notice from the policy patch that you haven't gotten
 around to using any of the tools listed in fsadm.te.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
