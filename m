Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4J46eRb007519
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 00:06:40 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4J44FB2018348
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 04:04:15 GMT
Received: from smtp.sws.net.au ([61.95.69.6])
	by jazzswing.ncsc.mil  with ESMTP id i4J44Ewi018301
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 04:04:15 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: avc messages occuring that aren't getting into dmesg or syslog
Date: Wed, 19 May 2004 14:05:11 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040518205335.GE7348@lkcl.net>
In-Reply-To: <20040518205335.GE7348@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405191405.11080.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 19 May 2004 06:53, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> the hotplug ones are particularly bugging me:
>
> 	allow hotplug_t sysctl_net_t:file { write };
>
> is banned under the policy verification rules.

Should probably allow that.

> assertion on line 94076 violated by allow initrc_t etc_t:dir { setattr };

That's either a bug in one of the startup scripts or a mis-labelled directory.

> assertion on line 94076 violated by allow mount_t etc_t:dir { mounton };

Why would you want to mount something under /etc?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
