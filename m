Message-ID: <40B4260E.5040208@snu.edu>
Date: Wed, 26 May 2004 00:07:26 -0500
From: Joshua Brindle <jbrindle@snu.edu>
MIME-Version: 1.0
To: Chris Babcock <cbabcock@luthresearch.com>
CC: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: 32bit / 64bit support
References: <1600.172.16.17.10.1085534896.squirrel@mxlx1.surveysavvy.com>
In-Reply-To: <1600.172.16.17.10.1085534896.squirrel@mxlx1.surveysavvy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Chris Babcock wrote:

> Is anybody still working on making selinux work on sparc64?
> 
The new SELinux API is totally arch independant. I've run SELinux on 
sparc64 (a blade 2000) on and off since the new API was introduced with 
no problems. It shouldn't be any different to get it running on sparc64 
than any other arch.

> Is x86_64 any better off than sparc64 for running selinux?
 >
neither should be a problem at all


Joshua Brindle

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
