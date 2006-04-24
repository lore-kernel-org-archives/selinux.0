Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k3OFDsOS026553
	for <selinux@tycho.nsa.gov>; Mon, 24 Apr 2006 11:13:54 -0400
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k3OFDrQT025683
	for <selinux@tycho.nsa.gov>; Mon, 24 Apr 2006 15:13:54 GMT
Message-ID: <444CEAF7.20503@gentoo.org>
Date: Mon, 24 Apr 2006 11:12:55 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: Shintaro Fujiwara <shin216@xf7.so-net.ne.jp>
CC: selinux@tycho.nsa.gov
Subject: Re: semodule fails
References: <20060425000740.41ed51f5.shin216@xf7.so-net.ne.jp>
In-Reply-To: <20060425000740.41ed51f5.shin216@xf7.so-net.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Shintaro Fujiwara wrote:
> Hi,
>
> When I try to install .pp file, it fails with messages.
>
> #semodule -i postgresql_by_me.pp
> libsepol.check_assertion_helper: assertion on line 0 violated by allow staff_t memory_device_t:chr_file { write };
> libsepol.check_assertion_helper: assertion on line 0 violated by allow staff_t memory_device_t:chr_file { read };
> libsepol.check_assertions: 2 assertion violations occured
> libsemanage.semanage_expand_sandbox: Expand module failed
> semodule: Failed!
>
> I saw archives and it says that libsepol-1.11 could solve the problem,
> but mine is 1.12.
>
>   
What is in postgresql_by_me.te? I suspect this isn't a toolchain failure 
but actually real assertion failures due to just dumping rules from 
audit2allow into a te file.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
