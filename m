Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA18998
	for <selinux@tycho.nsa.gov>; Mon, 24 Feb 2003 16:12:34 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h1OLCWI10904
	for <selinux@tycho.nsa.gov>; Mon, 24 Feb 2003 21:12:32 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id h1OLCUf10900 for <selinux@tycho.nsa.gov>; Mon, 24 Feb 2003 21:12:31 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Clem Skorupka <ragnor@mitre.org>, Wayne Salamon <wsalamon@tislabs.com>
Subject: Re: Core policy
Date: Mon, 24 Feb 2003 22:12:20 +0100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.LNX.4.33.0302241349350.1479-100000@vox.gw.tislabs.com> <3E5A7BBC.63AF1F96@mitre.org>
In-Reply-To: <3E5A7BBC.63AF1F96@mitre.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200302242212.20796.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 24 Feb 2003 21:08, Clem Skorupka wrote:
> Basically think of core as the minimum services/policy that any
> stripped-down "specialty" server would want.
> So if I was building a hardened dns server, I would have no need of
> printing, or an apache web server.  Or inetd/xinetd.
> I wouldn't need sound.  Or dhcp client.

I agree with the concept, however I think that inetd may be considered a base 
package.  Also sshd should be there.

> After that I'd create some category of "server" policy, to cover the
> webservers, ftp servers, dns, et al.
> Some might want to slice this up into internal servers (e.g. printing,
> databases) vs. external servers (e.g. web).  I'd follow common industry
> practices such as keeping servers "headless".
>
> Another category would be "user-workstation/gui", which would include dhcp
> client, x-windows, sound, web browsers.

This concept makes a lot of sense to me.

I suggest that we make the second line of each .te file contain a comment 
stating which category it is in, with the possibility of policy being in 
multiple categories.

Also for serious distributions such as Red Hat and Debian we will eventually 
need a mapping between distribution package name and policy file.  If you 
install "kdm" or "gdm" on Debian then you need xdm.te.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
