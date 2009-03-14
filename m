Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2E0YGhP016518
	for <selinux@tycho.nsa.gov>; Fri, 13 Mar 2009 20:34:16 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2E0YDPf026029
	for <selinux@tycho.nsa.gov>; Sat, 14 Mar 2009 00:34:15 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Paul Cocker" <paul.cocker@tntpost.co.uk>
Subject: Re: Unable to disable SELinux
Date: Sat, 14 Mar 2009 11:34:03 +1100
Cc: selinux@tycho.nsa.gov
References: <DAE2574A7F44F44ABE07381C36213DFA069F7833@exch.cdltd.co.uk>
In-Reply-To: <DAE2574A7F44F44ABE07381C36213DFA069F7833@exch.cdltd.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200903141134.07934.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 13 Mar 2009, "Paul Cocker" <paul.cocker@tntpost.co.uk> wrote:
> Running SELinux on a CentOS 5.2 box, Im trying to temporarily disable
> SELinux via one of the following methods:
>
> 1. sudo echo 0 > /selinux/enforce

Redirecting standard output is done by your shell.  So "sudo echo > file" will 
not work unless "echo > file" works.  This is not a SE Linux issue.

"sudo setenforce 0" will work.

> 2. sudo vim /selinux/enforce
>
> The first comes back with
>
> -bash: /selinux/enforce: Permission denied

Note that the error is from "bash".

> The second comes back with
>
> Could not set security context for /home/paulc/enforcz~

Editors such as "vim" are not designed to just write data to a file.  In 
the /root directory of my SE Linux Play Machine I have a file named 
thanks.txt_append_only_dont_edit_with_vi - many people try editing it with vi 
and find that it doesn't work.

Generally don't even try using vi to edit "files" under /proc, /sys, or any 
other filesystem that is used for kernel communications.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
