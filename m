From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tobias <CoUnt3r@gmx.net>, SELinux@tycho.nsa.gov
Subject: Re: hidden files and se linux?
Date: Tue, 22 Jul 2003 16:03:29 -0400
References: <20030721223849.GA2579@gmx.net>
In-Reply-To: <20030721223849.GA2579@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200307221603.29847.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 21 Jul 2003 18:38, Tobias wrote:
> is it possible to hide files under selinux?

To do that properly requires poly-instantiated directories.  AFAIK no-one will 
do that in the near future, more important file system related things such as 
NFS file labeling have not been done yet...

SE Linux allows you to deny "getattr" access (IE a stat() system call fails), 
but "ls *" will still show the existance of files.

It is my understanding that LIDS allows the files to be hidden (so a readdir() 
will not show them).  But this is not fully adequate, a hostile user can 
guess at file names and try to create them, if a file creation fails and 
there are no other issues (such as lack of disk space) then you can infer the 
existance of the file name.  Polyinstantiated directories is the solution to 
this problem.

I think that the consensus of opinion of people on this list is that hidden 
files without polyinstantiated directories is of little use.

There has been some previous discussion of this matter, checking the list 
archives (see my web site for the link) will provide you with more 
information.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
