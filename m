Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5A2KLrT024411
	for <selinux@tycho.nsa.gov>; Wed, 9 Jun 2004 22:20:22 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5A2KFP2005605
	for <selinux@tycho.nsa.gov>; Wed, 9 Jun 2004 22:20:16 -0400 (EDT)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: [debian] - installation of mysqld requires chfn
Date: Thu, 10 Jun 2004 12:20:53 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040609222209.GH5727@lkcl.net>
In-Reply-To: <20040609222209.GH5727@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406101220.53966.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 10 Jun 2004 08:22, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> i added the can_exec chfn_exec_t into domains/programs/dpkg.te:

ifdef(`passwd.te', `
domain_auto_trans(dpkg_t, chfn_exec_t, chfn_t)
')

The above is what you want.  You don't want to allow dpkg_t direct access 
to /etc/shadow because it will probably mess it up (replace it with a copy 
labelled as etc_t).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
