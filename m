Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i98A0rrT020393
	for <selinux@tycho.nsa.gov>; Fri, 8 Oct 2004 06:00:53 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i98A0pZ2028693
	for <selinux@tycho.nsa.gov>; Fri, 8 Oct 2004 10:00:52 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: .fonts-cache being created as user_home_dir_t
Date: Fri, 8 Oct 2004 20:00:39 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20041005091026.GB25251@lkcl.net> <200410071250.14304.russell@coker.com.au> <20041008100458.GC5089@lkcl.net>
In-Reply-To: <20041008100458.GC5089@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200410082000.40125.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 8 Oct 2004 20:04, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > > it looks like a file_auto_trans() is missing somewhere: i find
> > > that ~/.fonts.cache-1 is set to type user_home_dir_t.
> >
> > Is that being created by kdm?
>
>  i couldn't entirely say: let me see if i can find out...
>  a search through all kdebase *.cpp,h only shows up
>  something in kcontrol kio handler.  so that didn't work.

Put in:
auditallow domain user_home_dir_t:file *;

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
