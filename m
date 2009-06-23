Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n5NH7vxn011744
	for <selinux@tycho.nsa.gov>; Tue, 23 Jun 2009 13:07:57 -0400
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n5NH8RCG008227
	for <selinux@tycho.nsa.gov>; Tue, 23 Jun 2009 17:08:28 GMT
Message-ID: <4A410BEA.4000900@manicmethod.com>
Date: Tue, 23 Jun 2009 13:07:54 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: setfiles will only put out a "*" if > 1000 files are fixed.
References: <4A1438FE.2000207@redhat.com>
In-Reply-To: <4A1438FE.2000207@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> setfiles was always putting out a \n, even when not many files were
> being fixed. yum transactions were being desturbed by this.

Merged in policycoreutils 2.0.64

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
