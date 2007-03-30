Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2UCbbEC012740
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 08:37:37 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2UCbXUt012999
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 12:37:34 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Jim Meyering <jim@meyering.net>
Subject: Re: SELinux for upstream coreutils, finally (RFC: does mkdir need -Z?)
Date: Fri, 30 Mar 2007 23:37:30 +1100
Cc: bug-coreutils@gnu.org, selinux@tycho.nsa.gov
References: <87tzw3x9mo.fsf@rho.meyering.net>
In-Reply-To: <87tzw3x9mo.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703302237.35950.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 30 March 2007 21:18, Jim Meyering <jim@meyering.net> wrote:
> Regarding the --context=C (-Z C) option that is now accepted by
> mkdir, mknod, mkfifo, and install, I am inclined to

Currently mkdir, mknod, and mkfifo support a -m option to set the mode.  
Install has options to also set the owner and group.

I think that all programs which set the uid and gid of a file should also be 
able to set the SE Linux context.

It also seems reasonable that a program which can create a file with 
particular permissions should also be permitted to create it with a 
particular context.

> I'm still not entirely convinced that mkdir, mknod, mkfifo, and install
> need the option, and would welcome opinions one way or the other.  There's
> a good chance that I'll remove those -Z options before coreutils-6.10.

Oh well, if you merge most of the changes then that's still less work for us 
in maintaining patches.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
