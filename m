Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i13DKkRb005573
	for <selinux@tycho.nsa.gov>; Tue, 3 Feb 2004 08:20:47 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i13DKj1I010584
	for <selinux@tycho.nsa.gov>; Tue, 3 Feb 2004 13:20:45 GMT
Received: from ns.sws.net.au ([61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id i13DKhbs010412 for <selinux@tycho.nsa.gov>; Tue, 3 Feb 2004 13:20:44 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Fernando Luis =?iso-8859-1?q?V=E1zquez=20Cao?= <bs-f-vazquez@bs.rd.nttdata.co.jp>
Subject: Re: fork and security context transitions
Date: Wed, 4 Feb 2004 00:19:11 +1100
Cc: selinux@tycho.nsa.gov
References: <1075437775.1088.144.camel@volcano.rd.nttdata.co.jp> <1075469989.22930.19.camel@moss-spartans.epoch.ncsc.mil> <1075788687.826.222.camel@volcano.rd.nttdata.co.jp>
In-Reply-To: <1075788687.826.222.camel@volcano.rd.nttdata.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402040019.11770.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 3 Feb 2004 17:11, Fernando Luis Vázquez Cao 
<bs-f-vazquez@bs.rd.nttdata.co.jp> wrote:
> As an example, if we wanted to make Samba and Apache SELinux aware so
> that, in the event of a user session, a child process would be created
> in a user-specific domain, what should we do? With SELinux you are
> forced to split the servers in two executables, eventually being forced
> to make a lot of application specific changes (once more, if this is the
> only right approach let's stick with it).

For Samba this will not work.

The SMB protocol supports multiple SMB identities on the same SMB connection.  
Currently this is only really used in Windows Terminal Server edition, but it 
should be used in future workstation products when some bugs in the MS client 
code are fixed.

Because of this such code that you might write for Samba will only work for a 
while (until the next release of Windows maybe).

Of course in the development version of Samba things are a bit different and 
you can write plug-ins to do these sorts of things.  It would be possible to 
have the main Samba process execute helper programs to do the actual file IO 
and then communicate with the parent process by shared memory and pipes.  
Then a smbd which is serving for two SMB identities can have two helper 
children running in different contexts.

The other option is something like setfsuid() for SE Linux as previously 
discussed.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
