Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2PEfxPe010323
	for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2008 10:41:59 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2PEfwh6007195
	for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2008 14:41:58 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1) with ESMTP id m2PEbqaG012101
	for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2008 10:37:52 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1/Submit) id m2PEbqPw012100
	for selinux@tycho.nsa.gov; Tue, 25 Mar 2008 10:37:52 -0400
Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2PEAO4T006026
	for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2008 10:10:24 -0400
Received: from web36605.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m2PEANaX028242
	for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2008 14:10:24 GMT
Date: Tue, 25 Mar 2008 07:09:19 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: ls in Debian/Unstable
To: russell@coker.com.au, SE-Linux <selinux@tycho.nsa.gov>
Cc: Jim Meyering <jim@meyering.net>
In-Reply-To: <200803251523.34329.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <846433.9019.qm@web36605.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Russell Coker <russell@coker.com.au> wrote:

> unstable0:~/coreutils-6.10# ls -l /
> total 158
> drwxr-xr-x+  2 root root  4096 2008-03-25 10:02 bin
> drwxr-xr-x+  6 root root  1024 2008-03-21 12:30 boot
> drwxr-xr-x+ 16 root root  3700 2008-03-25 13:38 dev
> drwxr-xr-x+ 80 root root  4096 2008-03-25 13:38 etc
> drwxr-xr-x+  3 root root  4096 2008-02-15 22:08 home
> 
> In Debian/Unstable the output of "ls -l" is as above, the "+" indicates a SE 
> Linux security context

The "+" indicates that there is additional security metadata associated
with the file, it could be an ACL, timelock, or just about anything.
This is in accordance with the POSIX P1003.2 specification for ls(1).

> - which doesn't do much good when every file has one.

Well, there is that. 

> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=472590
> 
> The above URL has the Debian bug report with a patch.

I honestly don't know if this should be considered a bug in ls.
It is behaving as documented and if you've got MCS turned on
the SELinux label is being used to make DAC decisions. The "+"
is there to let you know that the mode bits don't tell the
whole access control story, but as you say, it is pretty silly
when every file has it.

> If you wish to add additional comments then email sent to 
> 472590@bugs.debian.org will be appended.
> 
> -- 
> russell@coker.com.au
> http://etbe.coker.com.au/          My Blog
> 
> http://www.coker.com.au/sponsorship.html Sponsoring Free Software development
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 
> 
> 


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
