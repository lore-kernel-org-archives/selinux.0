Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h97FqlWt012435
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 11:52:47 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h97Fqi0p009929
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 15:52:44 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
	by jazzswing.ncsc.mil  with ESMTP id h97Fqhr7009917
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 15:52:43 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: /selinux/enforce permissions
Date: Wed, 8 Oct 2003 01:52:31 +1000
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>
References: <200310080000.51892.russell@coker.com.au> <200310080129.48815.russell@coker.com.au> <1065541333.3919.256.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1065541333.3919.256.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310080152.31365.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 8 Oct 2003 01:42, Stephen Smalley wrote:
> On Tue, 2003-10-07 at 11:29, Russell Coker wrote:
> > The old SE Linux allowed the avc_enforcing() system call from any
> > context, and when the machine was not in enforcing mode avc_toggle()
> > could be run from any UID.  If we want to preserve the same functionality
> > as old SE Linux then we want mode 0644.
>
> What functionality depended on that behavior?  Doesn't seem worth
> retaining to me.

Running "avc_enforcing" from any UID was very convenient, it saved doing the 
other strange things that you might have to do to determine the state of the 
machine (and also saved having to su to do it).

I guess I could just do:
alias avc_enforcing="dmesg 2> /dev/null|wc -l"

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
