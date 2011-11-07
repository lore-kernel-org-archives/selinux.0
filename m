Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pA7NMgO0004866
	for <selinux@tycho.nsa.gov>; Mon, 7 Nov 2011 18:22:42 -0500
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id pA7NMesn006744
	for <selinux@tycho.nsa.gov>; Mon, 7 Nov 2011 23:22:41 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: refpolicy@oss1.tresys.com, Justin Mattock <justinmattock@yahoo.com>
Subject: Re: [refpolicy] semodule segfaults with ubuntu
Date: Tue, 8 Nov 2011 10:22:29 +1100
Cc: "SE-Linux" <selinux@tycho.nsa.gov>
References: <1320681595.98236.YahooMailNeo@web114319.mail.gq1.yahoo.com>
In-Reply-To: <1320681595.98236.YahooMailNeo@web114319.mail.gq1.yahoo.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201111081022.29910.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 8 Nov 2011, Justin Mattock <justinmattock@yahoo.com> wrote:
> this is really annoying..
> I am getting a segfault with using git version of refpolicy, but using
> ubuntu's policy I dont get this. why?

Build it with debugging symbols and run it under gdb.

Also this isn't a refpolicy issue, no matter what's wrong with the policy 
semodule shouldn't SEGV.  There is no excuse for a SEGV, any program which 
gives one (*) is buggy and needs to be fixed.  Please remove the refpolicy 
list from follow-ups.

(*) Except of course for the unusual cases where hardware errors cause 
particular programs to SEGV in which case the hardware needs to be 
fixed/replaced.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
