Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5DDuhWq030999
	for <selinux@tycho.nsa.gov>; Fri, 13 Jun 2008 09:56:43 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m5DDufhG017058
	for <selinux@tycho.nsa.gov>; Fri, 13 Jun 2008 13:56:43 GMT
Subject: Re: [refpolicy] /usr/lib32 type
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Martin Orr <martin@martinorr.name>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <484D6297.1030702@martinorr.name>
References: <484A8A15.9000507@martinorr.name>
	 <1213016083.28428.9.camel@gorn>  <484D6297.1030702@martinorr.name>
Content-Type: text/plain
Date: Fri, 13 Jun 2008 09:55:18 -0400
Message-Id: <1213365318.11146.28.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-06-09 at 18:04 +0100, Martin Orr wrote:
> On 09/06/08 13:54, Christopher J. PeBenito wrote:
> > On Sat, 2008-06-07 at 14:16 +0100, Martin Orr wrote:
> >> On a 64-bit Debian system, /usr/lib32 is a symlink to
> >> /emul/ia32-linux/usr/lib.  It should be labelled as lib_t.
> >>
> >> I don't know if the distro_debian is necessary - take it out if you want.
> > 
> > Actually what seems excessive is the (.*/)? in the middle.  Is it really
> > needed?  Its very broad, and doesn't sound like its needed.
> 
> I probably copied it from the lines above.  And in fact given the -l, there
> is not much point in the (/.*)? at the end either.

I added in an entry for the /usr/lib32 symlink.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
