Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i16FBuRb023129
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 10:11:56 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i16FBsOi000535
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 15:11:54 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i16FBrWW000532 for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 15:11:54 GMT
Subject: Re: fork and security context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao <bs-f-vazquez@bs.rd.nttdata.co.jp>
Cc: Russell Coker <russell@coker.com.au>, selinux@tycho.nsa.gov
In-Reply-To: <1076048950.2108.113.camel@volcano.rd.nttdata.co.jp>
References: <1075437775.1088.144.camel@volcano.rd.nttdata.co.jp>
	 <1075469989.22930.19.camel@moss-spartans.epoch.ncsc.mil>
	 <1075788687.826.222.camel@volcano.rd.nttdata.co.jp>
	 <200402040019.11770.russell@coker.com.au>
	 <1076048950.2108.113.camel@volcano.rd.nttdata.co.jp>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1076080294.16170.16.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 06 Feb 2004 10:11:35 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-02-06 at 01:29, Fernando Luis Vázquez Cao wrote:
> I have read two previous messages somehow related to the problem I'm
> trying to address:
> http://marc.theaimsgroup.com/?l=selinux&m=107397046201084&w=2
> http://marc.theaimsgroup.com/?l=selinux&m=107400517101821&w=2
> 
> They deal with the nonexistence of setfsuid/setuid peers in SELinux in
> applications such as NFS or Samba, and I would like to know whether
> there's any ongoing work on that matter or, otherwise, it has been
> completely dismissed as harmful. In the former case I would be
> interested in its use/development.

There is work in progress on NFS support, but that doesn't require
exporting the interface to a "fs SID" to userspace, as Jim Carter noted
earlier.  But I expect that this will ultimately be exported to
userspace for things like Samba, even though I don't think it offers
much security benefit.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
