Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n6VDVxaC025787
	for <selinux@tycho.nsa.gov>; Fri, 31 Jul 2009 09:31:59 -0400
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n6VDWrnu026551
	for <selinux@tycho.nsa.gov>; Fri, 31 Jul 2009 13:32:53 GMT
Message-ID: <4A72F24C.4040706@manicmethod.com>
Date: Fri, 31 Jul 2009 09:31:56 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Fixfiles has a bug when looking at btrfs file systems.
References: <4A564DE2.30200@redhat.com> <4A574728.1080301@manicmethod.com>
In-Reply-To: <4A574728.1080301@manicmethod.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Daniel J Walsh wrote:
>
> I believe this was already merged in policycoreutils 2.0.64 (commit was
> 323a16ff372b3c76291ee47eda1a4491797878f6 )
>

This wasn't previously merged, I was looking at the wrong commit, this is merged 
in 2.0.69.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
