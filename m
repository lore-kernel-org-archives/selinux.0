Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA14952
	for <selinux@tycho.nsa.gov>; Mon, 7 May 2001 09:49:31 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA02662
	for <selinux@tycho.nsa.gov>; Mon, 7 May 2001 13:48:44 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id NAA02658
	for <selinux@tycho.nsa.gov>; Mon, 7 May 2001 13:48:43 GMT
Date: Mon, 7 May 2001 09:48:08 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: "Hugo F. Martinez" <hmartinez@cti.com.ar>
cc: selinux@tycho.nsa.gov
Subject: Re: Installing selinux
In-Reply-To: <3AF341AD.FB40BD7F@cti.com.ar>
Message-ID: <Pine.SOL.3.95.1010507094145.20044H-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Several people have reported this problem when installing on 
RedHat 7.0, and have been able to work around it by replacing
their gcc.  I haven't been able to reproduce this error on our
RedHat 6.x systems, and I don't know if it occurs with RedHat 7.1.
Perhaps someone who has successfully installed SELinux on RedHat 7.x
can post a message explaining what they did to address this problem.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com


On Fri, 4 May 2001, Hugo F. Martinez wrote:

> Hi:
>     I have some problems installing the selinux policy the error ocurrs
> when I make the initinstall
> 
> and is goes like this
> 
> ...............
> ERROR IN THE STATEMENT ENDING ON LINE 1054 (TOKEN ';'):
>     UNKNOWN CLASS FILESYSTEM USED IN RULE


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
