Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6GBSarT028439
	for <selinux@tycho.nsa.gov>; Fri, 16 Jul 2004 07:28:37 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6GBSCbx002189
	for <selinux@tycho.nsa.gov>; Fri, 16 Jul 2004 11:28:13 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: SELinux Policy patches
Date: Fri, 16 Jul 2004 21:28:31 +1000
Cc: Erich Schubert <erich@debian.org>, selinux@tycho.nsa.gov,
   bam@snoopy.apana.org.au
References: <20040716002210.GA1081@wintermute.xmldesign.de> <20040716081924.GB3097@lkcl.net> <20040716105540.GD3097@lkcl.net>
In-Reply-To: <20040716105540.GD3097@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200407162128.31435.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 16 Jul 2004 20:55, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > > What are they trying to access under /var/lib?
> >
> >  i've seen this too - related to nsswitch iirc correctly.
>
>  strace shows ssh-keygen doing this sort of thing:
>
> 	connect(3, {sa_family=AF_UNIX, path="/var/run/.nscd_socket"}, 110) = -1
> 	ENOENT (No such file or directory)

Heaps of programs do that.  Most times that you see a search access on 
var_run_t:dir you can just put in a dontaudit rule.

But var_lib_t is a different issue.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
