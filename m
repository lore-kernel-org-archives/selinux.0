Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6G8hVrT027903
	for <selinux@tycho.nsa.gov>; Fri, 16 Jul 2004 04:43:31 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6G8h5bx027776
	for <selinux@tycho.nsa.gov>; Fri, 16 Jul 2004 08:43:07 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: SELinux Policy patches
Date: Fri, 16 Jul 2004 18:43:18 +1000
Cc: Erich Schubert <erich@debian.org>, selinux@tycho.nsa.gov
References: <20040716002210.GA1081@wintermute.xmldesign.de> <200407161234.03434.russell@coker.com.au> <20040716081924.GB3097@lkcl.net>
In-Reply-To: <20040716081924.GB3097@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200407161843.18666.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 16 Jul 2004 18:19, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > > I have a couple of access violation with applications of
> > >   foo var_lib_t:dir search;
> > >   foo var_lib_t:lnk_file read;
> > > for example syslogd, inetd, postfix_masteri, staff_ssh_t.
> > > Should i allow these or use dontaudit, and should i submit patches for
> > > such? Is there a known reason for such behaviour?
> >
> > What are they trying to access under /var/lib?
>
>  i've seen this too - related to nsswitch iirc correctly.

The db module?

I never bothered writing policy for that because the Linux implementation 
really isn't any good.  If I had a lot of spare time I'd consider 
contributing some code to make it as good as the AIX equivalent which would 
make it usable enough to be useful.

With the Linux db module the db file gets precedence over /etc/passwd.  This 
means that if the db file is out of date (there is no automatic mechanism for 
running /bin/passwd, useradd, etc to automatically update the db so it's 
often out of date) then you get the wrong data.

In AIX the time stamps on the db file and the source file are checked, if they 
are the same then the db is used, if the source file is newer it is used.  
Therefore if the db file creation processes gets forgotten (unlikely as all 
the tools know to update it - but it may happen if you wrote your own tool to 
do such things) then the only problem is that performance goes down.  No 
incorrect operation.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
