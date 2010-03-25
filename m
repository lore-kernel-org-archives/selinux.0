Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2PFpiD1013878
	for <selinux@tycho.nsa.gov>; Thu, 25 Mar 2010 11:51:44 -0400
Received: from qmta11.emeryville.ca.mail.comcast.net (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o2PFqN9q004033
	for <selinux@tycho.nsa.gov>; Thu, 25 Mar 2010 15:52:24 GMT
Subject: Re: These two patches allow restorecond to use same code as
 setfiles/restorecon.
From: Chris PeBenito <pebenito@gentoo.org>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <4B9A81E9.2000409@redhat.com>
References: <4B9A81E9.2000409@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Thu, 25 Mar 2010 11:51:28 -0400
Message-ID: <1269532288.2750.1.camel@defiant>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2010-03-12 at 13:03 -0500, Daniel J Walsh wrote:
> First patch rearranges setfiles code separating out shared code into a 
> new c program called restore.c
> This program will be linked against restorecond and setfiles.
> 
> Second patch changes restorecond to use the separated out code and also 
> Allows restorecond to run as a user process, rather then as a system 
> service.  So it can run within the user session watching for file 
> creations in the homedir.

Can it still run as a system process after this patch?

-- 
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
 
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0xE6AF9243
Key fingerprint = B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
