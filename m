Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5SDlrrT012732
	for <selinux@tycho.nsa.gov>; Mon, 28 Jun 2004 09:47:53 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5SDlVVC021301
	for <selinux@tycho.nsa.gov>; Mon, 28 Jun 2004 13:47:38 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Magnus Therning <magnus-work@therning.org>
Subject: Re: SELinux on Debian (Sid), second try
Date: Mon, 28 Jun 2004 23:47:41 +1000
Cc: selinux@tycho.nsa.gov
References: <20040624163900.GB3290@philips.com> <200406251908.56334.russell@coker.com.au> <20040628094230.GB1688@philips.com>
In-Reply-To: <20040628094230.GB1688@philips.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406282347.41232.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 28 Jun 2004 19:42, Magnus Therning <magnus-work@therning.org> wrote:
> Everything goes well until I get to the selinux-policy-default package.
> The version I get is 1:1.12-3 (from Sid). The installation ends with the
> following:
>
> make: *** /etc/selinux: No such file or directory.  Stop.
> run-parts: /etc/dpkg/postinst.d/selinux exited with return code 2
> "/bin/run-parts --arg=selinux-policy-default /etc/dpkg/postinst.d" failed:
> 256 dpkg: error processing selinux-policy-default (--configure):
>  1Error running trigger postinst: No such file or directory
> Errors were encountered while processing:
>  selinux-policy-default
> E: Sub-process /usr/bin/dpkg returned error code (1)
>
>
> Indeed, there is no directory called /etc/selinux. When should it have
> been created? (By what package?)

/etc/selinux is supposed to be a sym-link 
to /usr/share/selinux/policy/current/ .

Does /usr/share/selinux/policy/current/ exist?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
