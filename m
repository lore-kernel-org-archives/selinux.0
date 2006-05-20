Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4KCDqPo030343
	for <selinux@tycho.nsa.gov>; Sat, 20 May 2006 08:13:53 -0400
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4KCDnI5019236
	for <selinux@tycho.nsa.gov>; Sat, 20 May 2006 12:13:50 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Maria Iano <maria@iano.org>
Subject: Re: correct way to set context in perl?
Date: Sat, 20 May 2006 22:13:52 +1000
Cc: Erich Schubert <erich@debian.org>, selinux@tycho.nsa.gov
References: <20060518160656.V26098@iano.org> <200605192357.39325.russell@coker.com.au> <20060519103127.A26098@iano.org>
In-Reply-To: <20060519103127.A26098@iano.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200605202213.56675.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 20 May 2006 00:31, Maria Iano <maria@iano.org> wrote:
> So for now I don't need to know the best approach to have a perl script set
> the security context of a file. I would guess that I will need to do it at
> some point in the future - if not for this application then for something
> else. I would really appreciate if someone could help me understand the
> best approach for this. Is it best to design and code to avoid having to do
> it (as in this case where I redesigned the directory structure)? If so, I'd
> like to know why.

I am not a great Perl programmer, so I probably can't give the best answer to 
this.

I believe that it is possible to call any system call from Perl, so you could 
set the XATTR values directly, but to correctly support MCS/MLS you need a 
Perl interface to libselinux (which is quite possible, we just need someone 
to write it).

Another possibility is to execute chcon.  If you only have a small number of 
files to relabel (or if you are using the -R option) then the performance 
overhead will be negligible.

Finally if the file contexts that you desire match the file_contexts file then 
you can execute restorecon.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
