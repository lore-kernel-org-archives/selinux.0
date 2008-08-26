Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7QFmMKb000584
	for <selinux@tycho.nsa.gov>; Tue, 26 Aug 2008 11:48:22 -0400
Received: from mho-01-bos.mailhop.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7QFlsFw005531
	for <selinux@tycho.nsa.gov>; Tue, 26 Aug 2008 15:47:54 GMT
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
        Paul Moore <paul.moore@hp.com>
Message-Id: <374F28B6-E756-4E7C-BC5E-66757D689955@nall.com>
From: Joe Nall <joe@nall.com>
To: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20080821210239.7951.59652.stgit@flek.lan>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v928.1)
Subject: Re: [RFC PATCH v3 00/13] Labeled networking patches for 2.6.28
Date: Tue, 26 Aug 2008 10:47:37 -0500
References: <20080821210239.7951.59652.stgit@flek.lan>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Aug 21, 2008, at 4:25 PM, Paul Moore wrote:

> Another update to the labeled networking patches for 2.6.28.  This  
> revision
> adds some small fixes, the dead-code removal patch posted earlier,  
> and the big
> addition ... wait for it ... full LSM label/context support for local
> connections.  This is accomplished by creating a new, private CIPSO  
> tag type
> (allowed by the spec with a tag number > 127) which carries the  
> LSM's secid
> value, allowing full LSM contexts to be carried across local  
> connections
> without the headaches of labeled IPsec.
>
> For those of you interested in testing this out, you will need the  
> latest
> from the netlabel_tools addrsel branch, revision 74 or higher should  
> work.
> If you enable the new local labeling you will almost certainly need  
> to run
> SELinux in permissive mode since I'm fairly certain the current  
> policies don't
> have the necessary allow rules.  With that said, enabling the new  
> local
> labeling is pretty easy ...

Paul created a 2.6.26 patch which I've been testing with excellent  
results in Fedora 9. Local (lo and ethN) labeled networking is more  
reliable than the IPSec equivalent and does not have the IPSec SA  
creation latency. I'll push this to a larger set of developers and  
testers next week and report any issues.

joe


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
