Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4HNxeRb028005
	for <selinux@tycho.nsa.gov>; Mon, 17 May 2004 19:59:41 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4HNvGB2012804
	for <selinux@tycho.nsa.gov>; Mon, 17 May 2004 23:57:16 GMT
Received: from smtp.sws.net.au ([61.95.69.6])
	by jazzswing.ncsc.mil  with ESMTP id i4HNu6wi012743
	for <selinux@tycho.nsa.gov>; Mon, 17 May 2004 23:57:15 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: error on build of latest cvs (head) selinux-usr/policy
Date: Tue, 18 May 2004 09:57:16 +1000
Cc: selinux@tycho.nsa.gov
References: <20040517214625.GV9378@lkcl.net>
In-Reply-To: <20040517214625.GV9378@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405180957.16424.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 18 May 2004 07:46, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> mkdir -p /etc/security/selinux
> /usr/bin/checkpolicy -o /etc/security/selinux/policy.15 policy.conf
> /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> ERROR 'syntax error' at token 'typealias' on line 2764:
> typealias net_conf_t alias resolv_conf_t;
> type net_conf_t, file_type, sysadmfile;
> /usr/bin/checkpolicy:  error(s) encountered while parsing configuration

What version of checkpolicy are you using?  It looks like you have an old 
checkpolicy and a new policy source...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
