Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5T5YDrT017413
	for <selinux@tycho.nsa.gov>; Tue, 29 Jun 2004 01:34:13 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5T5XX6c020298
	for <selinux@tycho.nsa.gov>; Tue, 29 Jun 2004 05:33:58 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Magnus Therning <magnus-work@therning.org>
Subject: Re: SELinux on Debian (Sid), second try
Date: Tue, 29 Jun 2004 15:33:09 +1000
Cc: selinux@tycho.nsa.gov
References: <20040624163900.GB3290@philips.com> <200406282347.41232.russell@coker.com.au> <20040628150448.GF1688@philips.com>
In-Reply-To: <20040628150448.GF1688@philips.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406291533.10068.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 29 Jun 2004 01:04, Magnus Therning <magnus-work@therning.org> wrote:
> >/etc/selinux is supposed to be a sym-link
> >to /usr/share/selinux/policy/current/ .
> >
> >Does /usr/share/selinux/policy/current/ exist?
>
> Nope, it doesn't. All I have is /usr/share/selinux/policy/default/

Change line 12 of /etc/dpkg/postinst.d/selinux to be the following and things 
should work.  I'll upload a new version of selinux-policy-default to fix this 
shortly.
if grep -q selinuxfs /proc/mounts && test -e /etc/selinux ; then


-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
