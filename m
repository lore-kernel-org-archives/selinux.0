Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1T4MPRb020617
	for <selinux@tycho.nsa.gov>; Sat, 28 Feb 2004 23:22:25 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i1T4MOQQ016546
	for <selinux@tycho.nsa.gov>; Sun, 29 Feb 2004 04:22:25 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id i1T4MOP0016543 for <selinux@tycho.nsa.gov>; Sun, 29 Feb 2004 04:22:24 GMT
Date: Sun, 29 Feb 2004 04:21:55 +0000
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, selinux@tycho.nsa.gov
Subject: Re: Attn Colin: Overhelpful /usr/sbin/policy-remove-unwanted
Message-ID: <20040229042155.GZ11147@vnl.com>
References: <20040228181418.GO11147@vnl.com> <200402291344.28017.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200402291344.28017.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Feb 29, 2004 at 01:44:28PM +1100, Russell Coker wrote:
> On Sun, 29 Feb 2004 05:14, Dale Amon <amon@vnl.com> wrote:
> > Colin's /usr/sbin/policy-remove-unwanted gets into trouble
> > when you are using syslog-ng and do not have klogd installed:
> 
> The syslog.te file has policy to allow syslog-ng to perform klogd 
> functionality.  Why don't you have syslogd working in that manner?

This is a pure clean install straight off the debian sid 
mirror. Total hands off. If it's broke, it's because it is
that way in the dist defaults.

> > I think he needs to special case this and either test
> > for syslog-ng if the .te to be removed is klogd and
> > klogd is not found; or else simply never remove klogd.te
> > under any circumstance.
> 
> Making klogd.te depend on syslog-ng would be easy enough.  But why is it 
> necessary?

Either that or figure out why the default install works
this way.

-- 
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
