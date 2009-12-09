Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nB9KuWeH017183
	for <selinux@tycho.nsa.gov>; Wed, 9 Dec 2009 15:56:33 -0500
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id nB9KtNkL004800
	for <selinux@tycho.nsa.gov>; Wed, 9 Dec 2009 20:55:24 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Paul Moore <paul.moore@hp.com>
Subject: Re: tun/tap and SE Linux in 2.6.32
Date: Thu, 10 Dec 2009 07:56:22 +1100
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, "SE-Linux" <selinux@tycho.nsa.gov>
References: <200912091232.26387.russell@coker.com.au> <200912091548.03369.paul.moore@hp.com>
In-Reply-To: <200912091548.03369.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200912100756.24553.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 10 Dec 2009, Paul Moore <paul.moore@hp.com> wrote:
> > Subject: selinux PERMISSIVE blocking tun/tap device creation in v2.6.32
>
> I imagine this is because the original reporter is using a SELinux policy
> without the new TUN socket classes/permissions (which is likely the common
> case at this point).  The unknown class/permission handling that Eric added
> _should_ protect us from this - Russel do you have any more information
> about the distribution and policy in use here?

Sorry, the original message apparently wasn't clear enough (I've added some 
caps).

The problem occurred in permissive mode.  When the system is in permissive 
mode then SE Linux should not deny any action that Unix permissions will 
permit.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
