Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4KGRQRb020402
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 12:27:26 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4KGRNAR009403
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 16:27:23 GMT
Received: from smtp804.mail.ukl.yahoo.com (smtp804.mail.ukl.yahoo.com [217.12.12.141])
        by jazzband.ncsc.mil  with SMTP id i4KGRMHn009400 for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 16:27:23 GMT
Received: from unknown (HELO lkcl.net) (selinux@tycho.nsa.gov@81.130.181.235 with poptime)
  by smtp804.mail.ukl.yahoo.com with SMTP; 20 May 2004 16:27:22 -0000
Date: Thu, 20 May 2004 16:24:45 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <rcoker@redhat.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: FAM uses seteuid and setegid
Message-ID: <20040520162445.GM8810@lkcl.net>
References: <20040520121538.GA8810@lkcl.net> <200405210114.53119.rcoker@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200405210114.53119.rcoker@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, May 21, 2004 at 01:14:53AM +1000, Russell Coker wrote:
> On Thu, 20 May 2004 22:15, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > so, famd is designed to "effectively" set its user and group ids,
> > such that any file access is done as these, whilst still remaining
> > actually running as root.
> 
> Famd is badly designed for security.  There has been talk of replacing that 
> functionality with other code, the general concept is that for a local FAM 
> you just have the first process to call it fork off a child process which 
> executes a famd in the user context, then other processes with the same UID 
> can connect to the same famd.
 
 that's much more sensible.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
