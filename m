Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB2FOsRb015421
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 10:24:54 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB2FODp5005547
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 15:24:13 GMT
Received: from sornico (pat.zurich.ibm.com [195.176.20.45])
	by jazzswing.ncsc.mil  with ESMTP id hB2FODt0005544
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 15:24:13 GMT
Message-ID: <3FCCAEA2.2040703@zurich.ibm.com>
Date: Tue, 02 Dec 2003 16:24:18 +0100
From: Chris Vanden Berghe <vbc@zurich.ibm.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: selinux@tycho.nsa.gov
Subject: Re: selinux-policy-default
References: <3FCC831A.1070002@zurich.ibm.com> <200312030159.41676.russell@coker.com.au>
In-Reply-To: <200312030159.41676.russell@coker.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

>/etc/selinux is a sym-link to /usr/share/selinux/policy/current/ and is 
>created on installation of the selinux-policy-default package.


I don't have '/usr/share/selinux/policy/current/' either, but I do have
'/usr/share/selinux/policy/default/'.  Should I link /etc/selinux to
this '.../default/' dir?

>Did you remove and re-install the package?

Yes, but I did use --purge, so I expected that all configuration files
would have been deleted by this.

And, as Dave suggested, I'm currently installing this under a
non-selinux kernel (since the selinux one doesn't boot: it complains
that it cannot find the policy file :-( ).  So the idea was to install
all the selinux related packages under a non-selinux kernel and to
afterwards boot with the selinux kernel.

Cheers,
Chris.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
