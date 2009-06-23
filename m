Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n5NH7BSa011663
	for <selinux@tycho.nsa.gov>; Tue, 23 Jun 2009 13:07:11 -0400
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n5NH6srs007008
	for <selinux@tycho.nsa.gov>; Tue, 23 Jun 2009 17:06:56 GMT
Message-ID: <4A410BBA.5060605@manicmethod.com>
Date: Tue, 23 Jun 2009 13:07:06 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Add btrfs to fixfiles.
References: <4A1453C9.6040506@redhat.com>
In-Reply-To: <4A1453C9.6040506@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> Hopefully the last time we will ever need to update.  Once patch gets
> out with kernel support to tell me which file systems support xattr, we
> can remove this hack.

Merged in policycoreutils 2.0.64

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
