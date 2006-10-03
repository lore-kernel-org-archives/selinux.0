Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k93GkN4q017806
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 12:46:23 -0400
Received: from atlrel9.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k93GjmO7006182
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 16:45:49 GMT
Message-ID: <452293D2.10108@hp.com>
Date: Tue, 03 Oct 2006 12:46:10 -0400
From: Linda Knippers <linda.knippers@hp.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
Cc: Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        redhat-lspp@redhat.com, paul.moore@hp.com, vyekkirala@TrustedCS.com
Subject: Re: RHEL5 Kernel with labeled networking
References: <1159834998.28144.115.camel@localhost.localdomain>  <452282F2.1000107@hp.com> <1159890356.28144.136.camel@localhost.localdomain> <Pine.LNX.4.64.0610031207260.21081@d.namei> <45228EAA.5050105@hp.com> <Pine.LNX.4.64.0610031240430.23290@d.namei>
In-Reply-To: <Pine.LNX.4.64.0610031240430.23290@d.namei>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> On Tue, 3 Oct 2006, Linda Knippers wrote:
> 
> 
>>Dumb question....should compat_net be "1" by default?
> 
> 
> Ideally, no, the new secmark controls were posted in May and everyone 
> should be using them.  I only added the compat_net option to help 
> with transition, and it could disappear at any time.

Just seems like we're pretty early in the transition if updating
the kernel requires a new policy to not suffer a major regression,
but then I don't really understand all the secid reconciliation stuff.

-- ljk

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
