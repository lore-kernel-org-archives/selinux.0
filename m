Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6V3Z9Ha000918
	for <selinux@tycho.nsa.gov>; Wed, 30 Jul 2003 23:35:09 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6V3XwFB028958
	for <selinux@tycho.nsa.gov>; Thu, 31 Jul 2003 03:33:58 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
	by jazzswing.ncsc.mil  with ESMTP id h6V3XwGD028950
	for <selinux@tycho.nsa.gov>; Thu, 31 Jul 2003 03:33:58 GMT
Subject: Re: writing a java policy file
From: Colin Walters <walters@verbum.org>
To: Michael Luu <mluu@cougaarsoftware.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <003e01c35707$c0cf6230$ef0111ac@mluudt>
References: <003e01c35707$c0cf6230$ef0111ac@mluudt>
Content-Type: text/plain
Message-Id: <1059622256.12917.5.camel@columbia>
Mime-Version: 1.0
Date: 30 Jul 2003 23:30:56 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-07-30 at 22:02, Michael Luu wrote:
> hi all,
> 
> i'm trying set up a simple java policy whereby i only allow a specific
> user (in java_r role) to run a java (type java_t)application that
> communicates with a server (e.g., www.yahoo.com).  

I think that java_t is a bad name for what you're doing.  It seems to me
that you are writing a policy for a program which is implemented in
Java, not the JVM itself.

What you probably want to do is write up a macro like

uses_java(foo_t)

that gives an application privileges to do everything that the JVM does
by default (i.e. using shared libraries, maybe mmapping /dev/zero,
whatever).  

Then you should write a policy for your application, call it myapp_t,
and use the uses_java macro.  The .fc file looks fine though.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
