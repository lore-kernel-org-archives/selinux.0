Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA19803
	for <selinux@tycho.nsa.gov>; Wed, 6 Nov 2002 18:49:31 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id XAA08900
	for <selinux@tycho.nsa.gov>; Wed, 6 Nov 2002 23:47:33 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id XAA08896 for <selinux@tycho.nsa.gov>; Wed, 6 Nov 2002 23:47:32 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Subba Rao <sailorn@attglobal.net>
Subject: Re: SELinux and security tools?
Date: Thu, 7 Nov 2002 00:49:19 +0100
Cc: selinux <selinux@tycho.nsa.gov>
References: <Pine.LNX.4.33.0211061419220.1200-100000@vox.gw.tislabs.com>
In-Reply-To: <Pine.LNX.4.33.0211061419220.1200-100000@vox.gw.tislabs.com>
MIME-Version: 1.0
Message-Id: <200211070049.19470.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 6 Nov 2002 20:24, Wayne Salamon wrote:
> On Wed, 6 Nov 2002, Subba Rao wrote:
> > I am planning to install SELinux on one of my laptop.  The key tools I
> > plan to use are security tools such as Nessus, nmap, Snort and
> > tcpdump. Will these tools work well on on SELinux?  Has anyone
> > experienced problems with these tools on SELinux?
>
>   There shouldn't be a problem running these utilities under SELinux, but
> you will have to modify the policy for some of them. tcpdump is already
> known to the example policy (in the netutils domain), as is snort (it has

One thing to note is that network utility programs such as those have the 
sample policy setup to allow them to be run from an administrative session 
(sysadm_r).  If you want to run them from a laptop then you are probably 
doing so not as an administrative task but to use a laptop as a workstation 
or test machine for administering other machines on the network.  Therefore 
you'll probably want to run them from user_r instead which will require some 
minor adjustments to the policy.

For a while I have been thinking of setting up the policy to make it easier to 
allow separate domains for ping and netutils when run from different user 
roles.  However I don't want to enable it for everyone (as is done for most 
such domains) but to do it selectively for the particular roles that deserve 
it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
