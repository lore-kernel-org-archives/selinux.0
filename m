Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1EGKJRb003779
	for <selinux@tycho.nsa.gov>; Sat, 14 Feb 2004 11:20:19 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i1EGKIc3008743
	for <selinux@tycho.nsa.gov>; Sat, 14 Feb 2004 16:20:18 GMT
Received: from ns.sws.net.au ([61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id i1EGKHR0008734 for <selinux@tycho.nsa.gov>; Sat, 14 Feb 2004 16:20:18 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dale Amon <amon@vnl.com>
Subject: Re: Problem with defaulting answers to selinux-policy-default
Date: Sun, 15 Feb 2004 03:18:45 +1100
Cc: selinux@tycho.nsa.gov
References: <20040208163236.GF10500@vnl.com> <20040209154855.GF22989@vnl.com> <20040214155143.GB25142@vnl.com>
In-Reply-To: <20040214155143.GB25142@vnl.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402150318.45514.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 15 Feb 2004 02:51, Dale Amon <amon@vnl.com> wrote:
> Had some time this weekend and I'm making some progress
> on fixing my scripts to deal with the changes. I did a
> bit of handwaving with debconf-loadtemplate and
> debconf-configure to sort things out...
>
> I get an error in the Automatic build though:
>
> ERROR 'unknown type klogd_t' at token ';' on line 39546:
> neverallow ~klogd_t proc_kmsg_t:file ~{ getattr };

You should have klogd.te included.  I'll have to change the policy package to 
not allow you to deselect such files.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
