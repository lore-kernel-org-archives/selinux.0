Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9IERxrT021343
	for <selinux@tycho.nsa.gov>; Mon, 18 Oct 2004 10:27:59 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9IEQjG3001135
	for <selinux@tycho.nsa.gov>; Mon, 18 Oct 2004 14:26:45 GMT
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id 181FDBF25
	for <selinux@tycho.nsa.gov>; Mon, 18 Oct 2004 15:27:38 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1CJYeo-0000Wi-ND
	for selinux@tycho.nsa.gov; Mon, 18 Oct 2004 15:38:42 +0100
Date: Mon, 18 Oct 2004 15:38:42 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: cdrecord deadlocks linux 2.6.8.1 (problem in setscheduler)
Message-ID: <20041018143842.GP19398@lkcl.net>
References: <20041018124332.GA5193@hydrogenium.cip.ifi.lmu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20041018124332.GA5193@hydrogenium.cip.ifi.lmu.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

ah ha!  thomas, thank you v. much: i [badly] hacked up something
for k3b to use some time ago.

On Mon, Oct 18, 2004 at 02:43:32PM +0200, Thomas Bleher wrote:

> I have just written selinux policy for cdrecord. While writing this 
> policy cdrecord constantly locked up the computer (even in permissive
> mode). When booting with selinux=0 the problem went away.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
