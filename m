Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i166ToRb021182
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 01:29:50 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i166TnOi005221
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 06:29:49 GMT
Received: from ms0.nttdata.co.jp (ms0.nttdata.co.jp [163.135.193.231])
        by jazzband.ncsc.mil  with ESMTP id i166TlWW005212 for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 06:29:48 GMT
Subject: Re: fork and security context transitions
From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao <bs-f-vazquez@bs.rd.nttdata.co.jp>
To: russell@coker.com.au
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200402040019.11770.russell@coker.com.au>
References: <1075437775.1088.144.camel@volcano.rd.nttdata.co.jp>
	 <1075469989.22930.19.camel@moss-spartans.epoch.ncsc.mil>
	 <1075788687.826.222.camel@volcano.rd.nttdata.co.jp>
	 <200402040019.11770.russell@coker.com.au>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1076048950.2108.113.camel@volcano.rd.nttdata.co.jp>
Mime-Version: 1.0
Date: Fri, 06 Feb 2004 15:29:10 +0900
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have read two previous messages somehow related to the problem I'm
trying to address:
http://marc.theaimsgroup.com/?l=selinux&m=107397046201084&w=2
http://marc.theaimsgroup.com/?l=selinux&m=107400517101821&w=2

They deal with the nonexistence of setfsuid/setuid peers in SELinux in
applications such as NFS or Samba, and I would like to know whether
there's any ongoing work on that matter or, otherwise, it has been
completely dismissed as harmful. In the former case I would be
interested in its use/development.

I understand that you don't want to "allow wide and arbitrary changing
of context as setuid()", or the setforkcon I suggested in a preceding
email, does, but the arbitrariness of such functions would be
constrained to a set of user-specific domains that allow access to
user-specific types of files. Besides, a new "process control" could be
created to limit the use of such new functions.

If all the NFS/Samba users used the same samba_staff_t domain for their
IO, any user could access another user's files in the event of a bug in
the code of the servers.

Wouldn't the existence of functions such as the previously mentioned
improve the security?

As you say in one of the messages linked above, "it would be really
difficult to change the smbd code to make it re-exec 
itself every time someone authenticates". Furthermore, I feel it
is not a good way to approach the problem, since it would require
a lot of application-specific changes.

Best regards

Fernando Vázquez

2004/02/03 (火) 22:19 に Russell Coker さんは書きました:
> On Tue, 3 Feb 2004 17:11, Fernando Luis Vázquez Cao 
> <bs-f-vazquez@bs.rd.nttdata.co.jp> wrote:
> > As an example, if we wanted to make Samba and Apache SELinux aware so
> > that, in the event of a user session, a child process would be created
> > in a user-specific domain, what should we do? With SELinux you are
> > forced to split the servers in two executables, eventually being forced
> > to make a lot of application specific changes (once more, if this is the
> > only right approach let's stick with it).
> 
> For Samba this will not work.
> 
> The SMB protocol supports multiple SMB identities on the same SMB connection.  
> Currently this is only really used in Windows Terminal Server edition, but it 
> should be used in future workstation products when some bugs in the MS client 
> code are fixed.
> 
> Of course in the development version of Samba things are a bit different and 
> you can write plug-ins to do these sorts of things.  It would be possible to 
> have the main Samba process execute helper programs to do the actual file IO 
> and then communicate with the parent process by shared memory and pipes.  
> Then a smbd which is serving for two SMB identities can have two helper 
> children running in different contexts.
> 
> The other option is something like setfsuid() for SE Linux as previously 
> discussed.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
