Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4KGm9Rb020584
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 12:48:10 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4KGm7AR010816
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 16:48:07 GMT
Received: from smtp802.mail.ukl.yahoo.com (smtp802.mail.ukl.yahoo.com [217.12.12.139])
        by jazzband.ncsc.mil  with SMTP id i4KGm6Hn010813 for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 16:48:06 GMT
Received: from unknown (HELO lkcl.net) (selinux@tycho.nsa.gov@81.130.181.235 with poptime)
  by smtp802.mail.ukl.yahoo.com with SMTP; 20 May 2004 16:48:05 -0000
Date: Thu, 20 May 2004 16:45:16 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Russell Coker <rcoker@redhat.com>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: is this pretty much it (to patch kdm 3.2.2)?
Message-ID: <20040520164516.GA17553@lkcl.net>
References: <20040519074242.GK7348@lkcl.net> <1085057380.521.70.camel@moss-spartans.epoch.ncsc.mil> <20040520145258.GF8810@lkcl.net> <200405210139.49261.rcoker@redhat.com> <20040520161423.GJ8810@lkcl.net> <1085070386.521.198.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1085070386.521.198.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, May 20, 2004 at 12:26:26PM -0400, Stephen Smalley wrote:
> On Thu, 2004-05-20 at 12:14, Luke Kenneth Casson Leighton wrote:
> >  sadly i cannot tell.  i have been meaning to ask:
> > 
> >  is it possible to run things to present more debug info at the TIME
> >  that an avc message is placed in the logs?
> 
> You might get more information by enabling syscall auditing in your
> kernel.  Boot with audit=1.

 ta.

> You could patch the audit daemon (if you are running one) or syslogd to
> run whatever you want as it receives audit messages.
 
  ah ha!


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
