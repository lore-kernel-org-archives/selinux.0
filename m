Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7PADvrT004265
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 06:13:57 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7PADALV023857
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 10:13:10 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: patch for ssh-agent
Date: Wed, 25 Aug 2004 20:13:51 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040823215904.GE13677@lkcl.net>
In-Reply-To: <20040823215904.GE13677@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408252013.51983.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 24 Aug 2004 07:59, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> absolutely clueless as to what this is for, but at least it gets
> rid of the audit warnings, which were bugging me.

Are you running in permissive mode?  The below line should prevent any 
selinux_config_t:file access unless the file handle is being inherited from 
kdm (in which case it would be a kdm bug and we don't want to hide it with a 
dontaudit).

dontaudit $1_ssh_agent_t selinux_config_t:dir { search };


-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
