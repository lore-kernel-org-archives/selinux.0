Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA21180
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2001 17:40:35 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA05220
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2001 22:39:56 GMT
Received: from vorpal.mcs.drexel.edu (vorpal.mcs.drexel.edu [129.25.6.250])
	by jazzband.ncsc.mil  with ESMTP id WAA05216
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2001 22:39:56 GMT
Subject: Re: Errors in building lsm-selinux-200111191100.tgz
From: Justin Smith <jsmith@mcs.drexel.edu>
To: Stephen Smalley <sds@tislabs.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <Pine.GSO.4.33.0111261601060.21971-100000@raven>
References: <Pine.GSO.4.33.0111261601060.21971-100000@raven>
Content-Type: text/plain
Date: 26 Nov 2001 17:37:18 -0500
Message-Id: <1006814238.1215.0.camel@vorpal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2001-11-26 at 16:02, Stephen Smalley wrote:
> 
> On 26 Nov 2001, Justin Smith wrote:
> 
> > policydb.o: In function `user_destroy':
> > /usr/src/selinux/module/checkpolicy/../selinux_plug/ss/policydb.c:357:
> > undefined reference to `mls_user_destroy'
> 


I've done this and this part of the build works OK. Unfortunately, I now
get the message (upon booting)

kernel panic: policydb version (6) does not match my version (7).

I'm pretty sure I deleted all of the files from the previous install
of Selinux (maybe I left something in /usr/local/selinux).

Am I doing something dumb here?


--



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
