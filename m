Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i16B4MRb021849
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 06:04:23 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i16B4LOi014768
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 11:04:21 GMT
Received: from ns.sws.net.au ([61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id i16B4KWW014742 for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 11:04:21 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Fernando Luis =?utf-8?q?V=C3=A1zquez=20Cao?= <bs-f-vazquez@bs.rd.nttdata.co.jp>
Subject: Re: fork and security context transitions
Date: Fri, 6 Feb 2004 22:02:54 +1100
Cc: selinux@tycho.nsa.gov
References: <1075437775.1088.144.camel@volcano.rd.nttdata.co.jp> <200402040019.11770.russell@coker.com.au> <1076048950.2108.113.camel@volcano.rd.nttdata.co.jp>
In-Reply-To: <1076048950.2108.113.camel@volcano.rd.nttdata.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200402062202.54746.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 6 Feb 2004 17:29, Fernando Luis Vázquez Cao 
<bs-f-vazquez@bs.rd.nttdata.co.jp> wrote:
> http://marc.theaimsgroup.com/?l=selinux&m=107400517101821&w=2
>
> I understand that you don't want to "allow wide and arbitrary changing
> of context as setuid()", or the setforkcon I suggested in a preceding
> email, does, but the arbitrariness of such functions would be
> constrained to a set of user-specific domains that allow access to
> user-specific types of files. Besides, a new "process control" could be
> created to limit the use of such new functions.

I think that some sort of setfsuid() type operation makes sense.

> If all the NFS/Samba users used the same samba_staff_t domain for their
> IO, any user could access another user's files in the event of a bug in
> the code of the servers.

In the case of a bug in the core server code then the setfsuid() type 
operation could be performed by the exploiting code so SE Linux would provide 
little protection against a cracked server process.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
