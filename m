Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nARI3Ulr020422
	for <selinux@tycho.nsa.gov>; Fri, 27 Nov 2009 13:03:31 -0500
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id nARI5eMU027479
	for <selinux@tycho.nsa.gov>; Fri, 27 Nov 2009 18:05:41 GMT
Message-ID: <4B10146E.1040805@manicmethod.com>
Date: Fri, 27 Nov 2009 13:03:26 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Small fixes for chcat in policycoreutils
References: <4AF04CB6.6020806@redhat.com>
In-Reply-To: <4AF04CB6.6020806@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> chcat can generate oserror exception so need to catch and add chcat to the Makefile.

Merged in policycoreutils 2.0.78

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
