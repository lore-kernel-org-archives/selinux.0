Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i94GjarT019395
	for <selinux@tycho.nsa.gov>; Mon, 4 Oct 2004 12:45:36 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i94GjZs6018279
	for <selinux@tycho.nsa.gov>; Mon, 4 Oct 2004 16:45:35 GMT
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id 4FE8BBFA4
	for <selinux@tycho.nsa.gov>; Mon,  4 Oct 2004 17:45:31 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1CEW8i-0005wj-RE
	for selinux@tycho.nsa.gov; Mon, 04 Oct 2004 17:56:44 +0100
Date: Mon, 4 Oct 2004 17:56:44 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: bug in 2.6.8.1 scsi_block.c for CDROM "get configuration" ioctl
Message-ID: <20041004165644.GN20930@lkcl.net>
References: <20041004142712.GF20930@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20041004142712.GF20930@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

uh, actually there's a few more than just this one.

debian's latest 2.6.8-1 kernel patches has this fixed properly.
there are two reasons why i mention it here:

1) selinux has its own kernel tree, which was last updated to 2.6.8.1

2) anyone else who uses an unpatched latest cvs tree from sf.net may run
into difficulties [missing expected features] like i have.

l.

On Mon, Oct 04, 2004 at 03:27:12PM +0100, Luke Kenneth Casson Leighton wrote:
> the following patch needs to be added in order for k3b to operate
> correctly as a non-root user (there's a linux capability check in
> scsi_ioctl.c's verify_command() function)
> 
> apparently this is fixed for 2.6.9-rcsomething.

> +		safe_for_read(GPCMD_GET_CONFIGURATION),

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
