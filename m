Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4IJoKRb004818
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 15:50:21 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4IJltB2020380
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 19:47:55 GMT
Received: from smtp801.mail.ukl.yahoo.com (smtp801.mail.ukl.yahoo.com [217.12.12.138])
	by jazzswing.ncsc.mil  with SMTP id i4IJlswi020374
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 19:47:55 GMT
Received: from unknown (HELO lkcl.net) (selinux@tycho.nsa.gov@81.130.181.235 with poptime)
  by smtp801.mail.ukl.yahoo.com with SMTP; 18 May 2004 19:15:14 -0000
Date: Tue, 18 May 2004 19:12:38 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Valdis.Kletnieks@vt.edu
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: list of permissions created by allow2audit: what do i do now?
Message-ID: <20040518191238.GO24917@lkcl.net>
References: <20040518104026.GC24333@lkcl.net> <1084884047.28966.59.camel@moss-spartans.epoch.ncsc.mil> <20040518130244.GB24917@lkcl.net> <200405181625.i4IGPpIa012129@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200405181625.i4IGPpIa012129@turing-police.cc.vt.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, May 18, 2004 at 12:25:51PM -0400, Valdis.Kletnieks@vt.edu wrote:

> On Tue, 18 May 2004 13:02:44 -0000, Luke Kenneth Casson Leighton said:
> 
> >  given the number of errors i am seeing, and given that they won't
> >  go away, perhaps there is some breakdown in communication between
> >  the rules being in the policy.conf file and their application to
> >  packages.
> > 
> >  for example, should i be doing a make relabel every time i add
> >  some new rules?
> 
> If you add new *rules* (allow foo_t bar_t...), you need to do a 'make reload'
> to get the new policy in place.
> 
> If you add new file contexts, that requires a 'make relabel'.
> 
> Remember :  *.te changes -> make reload;  *.fc changes -> make relabel.
 
 ta.

> (If you're clever, you'll invoke setfiles by hand so you only relabel the
> file system(s) you need to - if all the stuff you need is on /usr, you don't
> need to redo all the other file systems...)

i'd noticed the technique employed by /etc/dpkg/postinst.d/selinux.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
