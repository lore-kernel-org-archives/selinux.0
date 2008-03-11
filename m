Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2B7ilTZ010853
	for <selinux@tycho.nsa.gov>; Tue, 11 Mar 2008 03:44:47 -0400
Received: from us.intercode.com.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2B7iklM022483
	for <selinux@tycho.nsa.gov>; Tue, 11 Mar 2008 07:44:46 GMT
Date: Tue, 11 Mar 2008 18:44:38 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Justin Mattock <justinmattock@gmail.com>
cc: selinux@tycho.nsa.gov
Subject: Re: 2.6.25-rc5
In-Reply-To: <dd18b0c30803102202i15fa5b28m2b05b597dee12adc@mail.gmail.com>
Message-ID: <Xine.LNX.4.64.0803111843320.8616@us.intercode.com.au>
References: <dd18b0c30803102202i15fa5b28m2b05b597dee12adc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 11 Mar 2008, Justin Mattock wrote:

> Hello
>  I've updated to 2.6.25-rc5 and am noticing new security cleasses in
> SELinux, also the new POSIX option is nice.
> 
> [    1.074531] security:  permission egress in class netif not defined in
> policy                     <----new

That's fine, it just means that the kernel is aware of permissions that 
your policy is not.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
