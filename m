Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l04GMibM010863
	for <selinux@tycho.nsa.gov>; Thu, 4 Jan 2007 11:22:44 -0500
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l04GNOVJ007410
	for <selinux@tycho.nsa.gov>; Thu, 4 Jan 2007 16:23:27 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Steve G <linux_4ever@yahoo.com>
Subject: Re: Latest diffs
Date: Fri, 5 Jan 2007 03:23:42 +1100
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
References: <37187.99487.qm@web51515.mail.yahoo.com>
In-Reply-To: <37187.99487.qm@web51515.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701050323.49009.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 05 January 2007 00:33, Steve G <linux_4ever@yahoo.com> wrote:
> >> Fixes for slocate on MLS
>
> Is slocate in anyone's security target? I was thinking that it was not due
> to needing to be level aware.

Before returning a result locate checks whether it can be accessed by the 
calling user.  As long as you trust locate to do the right thing in this 
regard it should be OK.  Based on history I'm not going to trust it on my 
systems.

> >Isn't this just a bad idea?
>
> Or maybe needless.

Machines have become much faster since locate was invented, even when it's 
installed few people bother to use it.  The machines I run fall into two 
general categories, machines on which find is fast enough that you would 
never desire to run locate, and machines on which "find /" might not complete 
in 24 hours and therefore need to have locate disabled.

> >desire the integrity protection offered by turning off locate?
>
> locate offers no integrity protection. It also has dubious confidentiality
> since it is likely not level aware.

You mis-read my message.  I consider running locate to be risking the 
integrity of the system.  But you are probably correct in considering it to 
be a confidentiality issue instead.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
