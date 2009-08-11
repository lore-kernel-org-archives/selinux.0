Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7BLMCgF022951
	for <selinux@tycho.nsa.gov>; Tue, 11 Aug 2009 17:22:12 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id n7BLNFG9005638
	for <selinux@tycho.nsa.gov>; Tue, 11 Aug 2009 21:23:15 GMT
Date: Tue, 11 Aug 2009 17:22:11 -0400
Subject: Re: libsemanage patch
From: Chad Sellers <csellers@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Message-ID: <C6A75943.A99C9%csellers@tresys.com>
In-Reply-To: <4A5DE96B.7080400@redhat.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 7/15/09 10:36 AM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:

> If you have a homedir that ends in '/', genhomedircon gets confused.
> 
> # useradd -h /home2/dwalsh/ dwalsh
> # genhomedircon
> 
> Check out the labeling.  genhomedircon thinks dwalsh is a toplevel home root.
> 
> We should just get rid of this command...  :^)
> 
> Patch removes all trailing '/' from homedir.

Acked-by: Chad Sellers <csellers@tresys.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
