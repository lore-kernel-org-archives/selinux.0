Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j03JBSIi019077
	for <selinux@tycho.nsa.gov>; Mon, 3 Jan 2005 14:11:28 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j03J9UFS015838
	for <selinux@tycho.nsa.gov>; Mon, 3 Jan 2005 19:09:36 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Nick Gray <nick-lists@austin.rr.com>
Subject: Re: Two machines, two differenct conditions.
Date: Tue, 4 Jan 2005 06:11:18 +1100
Cc: SELinux ML <selinux@tycho.nsa.gov>
References: <1103564031.25938.81.camel@hawaii.grays-systems.com>
In-Reply-To: <1103564031.25938.81.camel@hawaii.grays-systems.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200501040611.22086.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 21 December 2004 04:33, Nick Gray <nick-lists@austin.rr.com> wrote:
> On the laptop I can do this
>
> cat /dev/null > /var/log/messages.
>
> On the server I get permission denied.
>
> The DACs are root:root 600 and the label is user_u:object_r:var_t.
>
> Anyone have any ideas what would cause the inconsistency.

What AVC messages do you get?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
