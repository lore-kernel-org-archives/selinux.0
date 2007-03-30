Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2UErC3E019046
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 10:53:12 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2UErAiN009280
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 14:53:11 GMT
Subject: Re: Java bindings for SELinux libraries
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Dave Quigley <dquigley+selinux@gmail.com>
Cc: selinux@tycho.nsa.gov, slide@tresys.com
In-Reply-To: <f888952b0703291420p240dc242k1da0462ec0232af0@mail.gmail.com>
References: <f888952b0703291420p240dc242k1da0462ec0232af0@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 30 Mar 2007 10:51:01 -0400
Message-Id: <1175266261.3102.20.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-03-29 at 17:20 -0400, Dave Quigley wrote:
> Hello,
>     I was wondering if anyone has written or has seen java bindings
> for the selinux userspace libraries? A search through google doesn't
> yield any good results.
> 

There are not generally available Java bindings of which I am aware.
However, the python bindings are done with Swig, which should make
producing Java bindings fairly straightforward. Also, the SLIDE
developers (http://oss.tresys.com/projects/slide) may have some bindings
(CC'd).

Karl




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
