Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q9UMdEfv006808
	for <selinux@tycho.nsa.gov>; Tue, 30 Oct 2012 18:39:14 -0400
Received: by mail-vb0-f53.google.com with SMTP id fc21so1015149vbb.12
        for <selinux@tycho.nsa.gov>; Tue, 30 Oct 2012 15:39:08 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: "Moyer, Thomas - 0668 - MITLL" <thomas.moyer@ll.mit.edu>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: Question about SELinux capability
Date: Tue, 30 Oct 2012 18:39:05 -0400
Message-ID: <1474763.F3dYxdXi7b@sifl>
In-Reply-To: <CCB065EF.236E%thomas.moyer@ll.mit.edu>
References: <CCB065EF.236E%thomas.moyer@ll.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday, October 26, 2012 04:08:15 PM Moyer, Thomas - 0668 - MITLL wrote:
> I am working with a piece of embedded hardware that uses raw ethernet frames
> to communicate with another (standard PC). Is it possible to apply SELinux
> labels to those ethernet frames like you can with IP packets using iptables
> and SECMARK?

The secmark/iptables labels never leave the local system, they are maintained 
only within the kernel and do not travel out over the wire.  If you are 
interested in communicating security label over the network your only options 
at present require an IP header at the very least.

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
