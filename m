Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBKLpxIi018031
	for <selinux@tycho.nsa.gov>; Mon, 20 Dec 2004 16:51:59 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBKLq1eP000389
	for <selinux@tycho.nsa.gov>; Mon, 20 Dec 2004 21:52:01 GMT
Subject: Re: [patch] misc. policy updates
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Russell Coker <russell@coker.com.au>
Cc: Greg Norris <haphazard@kc.rr.com>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <200412201201.11825.russell@coker.com.au>
References: <20041217012224.GA11330@yggdrasil.localdomain>
	 <200412201201.11825.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1103579643.3220.32.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 20 Dec 2004 16:54:04 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged both Greg's and Russell's patches.

Russell, I added "log_domain(ddclient)" as you mention below.  I also
added "var_lib_domain(ddclient)" since your patch assigns a
var_lib_ddclient_t.  Or did you do something different there?

I've removed ddt-client.te and ddt-client.fc from CVS.

On Sun, 2004-12-19 at 20:01, Russell Coker wrote:
> On Friday 17 December 2004 12:22, Greg Norris <haphazard@kc.rr.com> wrote:
> > The attached diff against ddclient.te is necessary in order for it to
> > work properly with the new networking macros.  Also, it updates my email
> > address in the policy header.  The other two simply perform the latter
> > update for the other policies I've submitted.
> 
> I've added them to my tree.  I also added "log_domain(ddclient)" at the end of 
> the file (no patch attached as a patch for a patch is painful) and added the 
> attached patch to the file_contexts.
> 
> This means that ddclient takes over the policy of ddt-client.  Please delete 
> ddt-client.te and ddt-client.fc from the policy source.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
