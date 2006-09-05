Subject: Re: SELinux and separation Kernels
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Sergio C <sergnut@hotmail.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <BAY106-F307388DD362472C0381AFAA3330@phx.gbl>
References: <BAY106-F307388DD362472C0381AFAA3330@phx.gbl>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 15:09:10 -0400
Message-Id: <1157483350.24657.23.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-09-04 at 22:28 +0000, Sergio C wrote:
> Hi all!
> 
> I have a question related with the SELinux technolgy and the idea of 
> separation Kernel. Can be SELinux considered a way to achive a separation 
> kernel idea? Are similar ideas?
> 
> Thank you in advance,
> 

Your question is lacking enough context to really answer - please ask
something more specific if you want useful answers.

"Separation kernel" normally refers to an architecture with a default
security policy, though the usage seems to vary. SELinux has nothing to
do with the architectural parts (i.e., it is tied to the large,
monolithic Linux kernel) but the policy can be used to enforce certain
types of application separation, though not all (e.g., SELinux doesn't
directly address scheduling or resource usage).

Karl

> Sergio
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
