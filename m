Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1954FRb002022
	for <selinux@tycho.nsa.gov>; Mon, 9 Feb 2004 00:04:16 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i1954EOi025356
	for <selinux@tycho.nsa.gov>; Mon, 9 Feb 2004 05:04:15 GMT
Received: from ns.sws.net.au ([61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id i1954DWW025329 for <selinux@tycho.nsa.gov>; Mon, 9 Feb 2004 05:04:14 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dale Amon <amon@vnl.com>, selinux@tycho.nsa.gov
Subject: Re: Problem with defaulting answers to selinux-policy-default
Date: Mon, 9 Feb 2004 16:02:48 +1100
References: <20040208163236.GF10500@vnl.com>
In-Reply-To: <20040208163236.GF10500@vnl.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402091602.48538.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 9 Feb 2004 03:32, Dale Amon <amon@vnl.com> wrote:
> I think Russell is again buried in email and work, so

Sorry for the delay.

> Using policy installation method "Semi-Automatic"
> Copying the sample /usr/share/selinux/policy/current directory from
> /usr/share/selinux/policy/default
> Removal of unwanted policy files
> Removing "current/domains/program/gnome-pty-helper.te"
> Include "Checkpolicy - SELinux policy compliler"
> (current/domains/program/checkpolicy.te) in policy? (References known
> installed packages: checkpolicy)
>  Yes/No/Display/Background [Y/n/d/b]?

What I probably need to do is to have a debconf setting allowing you to say 
"c" to all questions about policy changes, and then get Colin's code working 
for installing new .te files IFF they are needed.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
