Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5241KrT001115
	for <selinux@tycho.nsa.gov>; Wed, 2 Jun 2004 00:01:20 -0400 (EDT)
Received: from smtp802.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i52Btpbn010384
	for <selinux@tycho.nsa.gov>; Wed, 2 Jun 2004 07:55:51 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp802.mail.ukl.yahoo.com with SMTP; 1 Jun 2004 09:14:38 -0000
Date: Tue, 1 Jun 2004 09:12:04 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: progress! ssh.
Message-ID: <20040601091204.GO8312@lkcl.net>
References: <20040531212109.GQ3170@lkcl.net> <200406011312.48669.russell@coker.com.au> <20040601084631.GJ8312@lkcl.net> <200406011909.07645.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200406011909.07645.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jun 01, 2004 at 07:09:07PM +1000, Russell Coker wrote:
> On Tue, 1 Jun 2004 18:46, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > > This is not necessary.  In the Fedora PAM package there is code to close
> > > those file handles before exec so those accesses are never attempted.
> >
> >  oh, right.  *puzzled*.
> >
> >  if Fedora PAM has been patched, would you mind forwarding the patch
> >  to me so i can ping pam-list with it?
> 
> http://download.fedora.redhat.com/pub/fedora/linux/core/2/i386/os/SRPMS/
> 
> The PAM source at the above URL has it.  pam-list seems to be dead however.  
> PAM development continues independently in Debian and Red Hat.  

 oh, bugger.

 oh joy.

> If you want a 
> new upstream version of PAM then the best thing to do would be to fork it.  

 hm, it's in sf.  i wonder if andrew's responsive.

> Forking PAM will get less resistance from upstream than forking Samba...

 so that explains why there are FIFTY patches to pam 0.76 in the
 debian/patches directory.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
