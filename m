Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n51D4xJc032447
	for <selinux@tycho.nsa.gov>; Mon, 1 Jun 2009 09:04:59 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id n51D4p5t025304
	for <selinux@tycho.nsa.gov>; Mon, 1 Jun 2009 13:04:51 GMT
Subject: Re: [refpolicy] libjackserver.so file context
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stefan Schulze Frielinghaus <stefan@seekline.net>, selinux@tycho.nsa.gov
In-Reply-To: <4A23CB29.1020803@redhat.com>
References: <20090530084611.GA8305@vogon.seekline.net>
	 <4A23CB29.1020803@redhat.com>
Content-Type: text/plain
Date: Mon, 01 Jun 2009 09:04:15 -0400
Message-Id: <1243861457.8402.41.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-06-01 at 08:35 -0400, Daniel J Walsh wrote:
> On 05/30/2009 04:46 AM, Stefan Schulze Frielinghaus wrote:
> > Hi,
> >
> > libjackserver.so needs text relocation. Attached file solves the
> > problem.
> >
> Please report this as a bug to the providers of libjackserver.so

I've added this to refpolicy.  But you definitely should also report
that bug as Dan says.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
