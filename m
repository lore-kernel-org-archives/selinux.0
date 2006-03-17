Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2H2Ek99030016
	for <selinux@tycho.nsa.gov>; Thu, 16 Mar 2006 21:14:46 -0500
Received: from authusersmtp.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2H2D83h012705
	for <selinux@tycho.nsa.gov>; Fri, 17 Mar 2006 02:13:08 GMT
Received: from [192.168.2.105] (cpe-24-59-125-231.twcny.res.rr.com [24.59.125.231])
	(authenticated bits=0)
	by authusersmtp.mail.cornell.edu (8.13.1/8.12.10) with ESMTP id k2H2Ee8Q026045
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Thu, 16 Mar 2006 21:14:45 -0500 (EST)
Message-ID: <441A1B8E.8040807@cornell.edu>
Date: Thu, 16 Mar 2006 21:14:38 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: semodule dumps core
References: <20060316224834.GA8552@thorium.jmh.mhn.de>
In-Reply-To: <20060316224834.GA8552@thorium.jmh.mhn.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thomas Bleher wrote:
> Seems like semodule doesn't like me. I just recompiled my policy with
> the new versions of the tools and now semodule dumps core when I do a 
> "semodule -b base.pp".
>
> The backtrace from gdb looks like this:
> (gdb) backtrace
> #0  0x37ec2f5c in fclose@plt () from /lib/libsemanage.so.1
> #1  0x37ec8950 in semanage_direct_commit (sh=0x804c4a8) at direct_api.c:401
> #2  0x37eca3fe in semanage_commit (sh=0x804c4a8) at handle.c:227
> #3  0x08049507 in main (argc=3, argv=0x3fc5db44) at semodule.c:361
>
>   
Hmm? line 401 in direct_api.c is not in semanage_direct_commit()
in the version of libsemanage you specified (1.6?)...


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
