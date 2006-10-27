Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9RN4enr021639
	for <selinux@tycho.nsa.gov>; Fri, 27 Oct 2006 19:04:40 -0400
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9RN353D001319
	for <selinux@tycho.nsa.gov>; Fri, 27 Oct 2006 23:03:06 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Valdis.Kletnieks@vt.edu
Subject: Re: [redhat-lspp] Re: MLS enforcing PTYs, sshd, and newrole
Date: Sat, 28 Oct 2006 09:04:22 +1000
Cc: Daniel J Walsh <dwalsh@redhat.com>, casey@schaufler-ca.com,
        redhat-lspp@redhat.com, selinux@tycho.nsa.gov
References: <20061012153701.75777.qmail@web36603.mail.mud.yahoo.com> <200610201700.31748.russell@coker.com.au> <200610271536.k9RFactr013813@turing-police.cc.vt.edu>
In-Reply-To: <200610271536.k9RFactr013813@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200610280904.25797.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 28 October 2006 01:36, Valdis.Kletnieks@vt.edu wrote:
> On Fri, 20 Oct 2006 17:00:28 +1000, Russell Coker said:
> > On Thursday 19 October 2006 23:21, Daniel J Walsh <dwalsh@redhat.com> 
wrote:
> > > If we then remove -l from newrole we are done?
> >
> > Why remove it?  Why not just cease using it and leave it there for other
> > people who have different needs?
>
> I suspect that it wouldn't fly during an eval, because even if unused, it

OK.

Well #if 0 would still be better than removing the code.  This is something we 
may want to resurrect at a later time.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
