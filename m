Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r72LXv2i026332
	for <selinux@tycho.nsa.gov>; Fri, 2 Aug 2013 17:35:55 -0400
From: Paul Moore <pmoore@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: selinux@tycho.nsa.gov, stable@vger.kernel.org
Subject: Re: [PATCH] selinux: correct locking in selinux_netlbl_socket_connect)
Date: Fri, 02 Aug 2013 17:33:25 -0400
Message-ID: <4014494.qk18HMBsnN@sifl>
In-Reply-To: <20130802211929.GE10306@kroah.com>
References: <20130802180807.19794.24371.stgit@localhost> <20130802211929.GE10306@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday, August 03, 2013 05:19:29 AM Greg KH wrote:
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
> for how to do this properly.
> 
> </formletter>

My apologies, I even know better, I just spaced and did a direct CC.

-- 
paul moore
security and virtualization @ redhat


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
