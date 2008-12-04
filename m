Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mB4CcoQ1010774
	for <selinux@tycho.nsa.gov>; Thu, 4 Dec 2008 07:38:50 -0500
Received: from etbe.coker.com.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id mB4Caef9029155
	for <selinux@tycho.nsa.gov>; Thu, 4 Dec 2008 12:36:41 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dave Feustel <dfeustel@mindspring.com>
Subject: Re: Policy for Konqueror
Date: Thu, 4 Dec 2008 23:38:34 +1100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200812011617.mB1GH13d002406@mummy.ncsc.mil>
In-Reply-To: <200812011617.mB1GH13d002406@mummy.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200812042338.36117.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 02 December 2008 03:17, Dave Feustel <dfeustel@mindspring.com> 
wrote:
> "When using KDE, you may find that several graphical applications or
> features don't work properly. This occurs because KDE starts a variety
> of execuables with the same process name, kdeinit. No simple fix exists
> for such problems, since a simple fix would entail loosening security to
> an unacceptable extent. You may find it more convenient to use a desktop
> other than KDE - such as GNOME - when running SELinux.

http://www.nsa.gov/selinux/list-archive/0504/11252.cfm

This was covered in 2004 and again in 2005.  At that time it was easy to solve 
this problem.

Recent versions of KDE seem to have made this more difficult.  I expect that 
if you were prepared to do some minor hacking on KDE source it wouldn't be 
difficult to make it run without kdeinit.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
