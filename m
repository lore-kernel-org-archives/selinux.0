Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3B3cgRb002487
	for <selinux@tycho.nsa.gov>; Sat, 10 Apr 2004 23:38:42 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i3B3aeUZ002707
	for <selinux@tycho.nsa.gov>; Sun, 11 Apr 2004 03:36:40 GMT
Received: from mutemail.com (mutemail.com [24.244.170.124])
	by jazzswing.ncsc.mil  with SMTP id i3B3admT002704
	for <selinux@tycho.nsa.gov>; Sun, 11 Apr 2004 03:36:39 GMT
Date: Sat, 10 Apr 2004 20:38:29 -0700
From: Bill McCarty <bmccarty@pt-net.net>
To: "Milan P. Stanic" <mps@rns-nis.co.yu>, selinux@tycho.nsa.gov
Subject: Re: Problems finding working kernel/user land combination
Message-ID: <36722574.1081629509@[192.168.0.3]>
In-Reply-To: <20040409204356.GA6027@rns-nis.co.yu>
References: <88042458.1081270777@[192.168.0.3]>
 <20040407075405.D19421@lemuria.org> <20040409204356.GA6027@rns-nis.co.yu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Milan,

--On Friday, April 09, 2004 10:43 PM +0200 "Milan P. Stanic" 
<mps@rns-nis.co.yu> wrote:

> Maybe you could look at my backports from debian unstable to woody
> at http://www.rns-nis.co.yu/~mps/ or with apt:
> deb http://www.rns-nis.co.yu/~mps selinux/
>
> I backported it with the help from Russell Coker, and  tested it only
> under UML with 2.6.4 kernel.

I gave it a go; but dpkg reports that libselinux1 depends on libattr1 >= 
2.4.4-1, which is not part of Woody. Did I take a wrong turn?

Cheers,

---------------------------------------------------
Bill McCarty, Ph.D.
Professor of Information Technology
Azusa Pacific University



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
