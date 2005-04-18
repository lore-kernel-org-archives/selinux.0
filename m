Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3I15r7C008740
	for <selinux@tycho.nsa.gov>; Sun, 17 Apr 2005 21:05:53 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3I0wiRD010313
	for <selinux@tycho.nsa.gov>; Mon, 18 Apr 2005 00:58:45 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: [ PATCH ] Cumulative patch - various fixes, untrusted_content_t, mozilla, gnome types
Date: Mon, 18 Apr 2005 11:01:26 +1000
Cc: ivg2@cornell.edu, dwalsh@redhat.com, selinux@tycho.nsa.gov
References: <1113445869.6139.52.camel@cobra.ivg2.net> <200504172346.39313.russell@coker.com.au> <20050417233312.GI18167@lkcl.net>
In-Reply-To: <20050417233312.GI18167@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200504181101.31615.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 18 April 2005 09:33, Luke Kenneth Casson Leighton <lkcl@lkcl.net> 
wrote:
> On Sun, Apr 17, 2005 at 11:46:34PM +1000, Russell Coker wrote:
> > Mozilla will desire read/write access to the .gconf directory and it's
> > files
>
>  not under circumstances where it's built with kde support, it won't.

If we were somehow able to get everyone to build Mozilla with KDE support then 
it would merely defer the issue until we find the next gconf application.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
