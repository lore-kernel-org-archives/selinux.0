Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i972oKrT011126
	for <selinux@tycho.nsa.gov>; Wed, 6 Oct 2004 22:50:20 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i972nAnN009886
	for <selinux@tycho.nsa.gov>; Thu, 7 Oct 2004 02:49:11 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: .fonts-cache being created as user_home_dir_t
Date: Thu, 7 Oct 2004 12:50:14 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20041005091026.GB25251@lkcl.net>
In-Reply-To: <20041005091026.GB25251@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200410071250.14304.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 5 Oct 2004 19:10, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> it looks like a file_auto_trans() is missing somewhere: i find
> that ~/.fonts.cache-1 is set to type user_home_dir_t.

Is that being created by kdm?  Is the machine in permissive mode at the time 
the file is created?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
