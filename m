Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5GEMGgA000669
	for <selinux@tycho.nsa.gov>; Thu, 16 Jun 2005 10:22:17 -0400 (EDT)
Received: from smtp2.centrin.net.id (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5GED4I8008887
	for <selinux@tycho.nsa.gov>; Thu, 16 Jun 2005 14:13:08 GMT
Received: from hendra ([202.146.226.149])
	by smtp2.centrin.net.id (8.13.0/8.13.0) with SMTP id j5GEDVfR015367
	for <selinux@tycho.nsa.gov>; Thu, 16 Jun 2005 21:13:32 +0700
Message-ID: <002801c5727d$9486fc40$0101a8c0@hendra>
Reply-To: "hendra" <ikasari@centrin.net.id>
From: "hendra" <ikasari@centrin.net.id>
To: <selinux@tycho.nsa.gov>
References: <004401c57215$f870f840$0101a8c0@hendra> <1118909660.13716.119.camel@sabrina>
Subject: Re: Step by step installation instruction
Date: Thu, 16 Jun 2005 21:13:00 +0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks for a lot of reply, but I wonder if my download complete or not? Or
the steps for installation goes wrong. But everything compile and install
successfully. Should
1) I put directory /selinux on / or on /etc and mount it there?
2) Installing policy package on /etc, but if I mount directory /etc/selinux,
then error happen "Permission denied". And should I create
/etc/selinux/strict or /etc/selinux/targeted manually? Or it comes from
installatin from one of the package?

I'm using SuSE linux 9.1 as a homebase, but has very bad support for
SElinux. I download kernel 2.6.11.10 with SElinux patched ready.

Hendra


> You should refer to your specific distribution documentation on how to
> activate Selinux. If you're bolting into your homegrown, then you'll
> need to read a lot of source and do a lot of patching.
>
> If you want, you can shoot an email back and I'll provide a list of
> links i've bookmarked over the past couple of months but it's nothing
> you couldn't google up.
>
> -Christopher Warner
>
> On Thu, 2005-06-16 at 08:51 +0700, hendra wrote:
> > Hi all,
> >
> > I'm a newbie on SElinux. Can someone give me information about how to
> > installing SElinux step by step. I already trying alot of tutorial on
> > how to install, but still failed, especially when I do make load.
> > There always message "No rule to make load". As for information I'm
> > using downloadable kernel ver 2.6.11.10 with SElinux embedded enabled
> > already.
> >
> > Thanks for help
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
