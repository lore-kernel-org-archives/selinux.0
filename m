Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6G88crT027797
	for <selinux@tycho.nsa.gov>; Fri, 16 Jul 2004 04:08:38 -0400 (EDT)
Received: from smtp811.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i6G88aNn029070
	for <selinux@tycho.nsa.gov>; Fri, 16 Jul 2004 08:08:37 GMT
Date: Fri, 16 Jul 2004 09:19:24 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: Erich Schubert <erich@debian.org>, selinux@tycho.nsa.gov,
   bam@snoopy.apana.org.au
Subject: Re: SELinux Policy patches
Message-ID: <20040716081924.GB3097@lkcl.net>
References: <20040716002210.GA1081@wintermute.xmldesign.de> <200407161234.03434.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200407161234.03434.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > I have a couple of access violation with applications of
> >   foo var_lib_t:dir search;
> >   foo var_lib_t:lnk_file read;
> > for example syslogd, inetd, postfix_masteri, staff_ssh_t.
> > Should i allow these or use dontaudit, and should i submit patches for
> > such? Is there a known reason for such behaviour?
> 
> What are they trying to access under /var/lib?
 
 i've seen this too - related to nsswitch iirc correctly.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
