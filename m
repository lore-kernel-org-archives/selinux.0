Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o9RKoQkq016525
	for <selinux@tycho.nsa.gov>; Wed, 27 Oct 2010 16:50:26 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id o9RKoPjx025606
	for <selinux@tycho.nsa.gov>; Wed, 27 Oct 2010 20:50:25 GMT
Message-ID: <4CC8908C.9010404@tresys.com>
Date: Wed, 27 Oct 2010 16:50:20 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Xavier Toth <txtoth@gmail.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: [RFC PATCH URL] mcstrans - SELInux Project contribution
References: <AANLkTi=e6niGe9wFVFc_wKvaCTubN=QQjA5b0WbkSvVf@mail.gmail.com>
In-Reply-To: <AANLkTi=e6niGe9wFVFc_wKvaCTubN=QQjA5b0WbkSvVf@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Due to size constrains, my changes for the mcstrans patch can be
downloaded here:

http://oss.tresys.com/files/selinux/mcstrans-review.patch.tgz

The majority of the patch is just handling the case of memory
allocation failures and making sure things get cleaned up correctly in
those cases.

This also moves duplicate code in parse_ebitmap() and parse_raw() into
parse_category(), and also updates the parse function to ensure the
config files are in the correct format.

But aside from that, only very minor changes.

Reviewed by: Steve Lawrence <slawrence@tresys.com>


On 07/21/2010 03:40 PM, Xavier Toth wrote:
> Due to posting size constraints my previous attempt to post this patch
> failed you can now find it at:
> 
> http://www.nall.com/tedx/mcstrans.patch.tgz
> 
> 
> SELinux Project contribution of mcstrans. mcstrans is a userland package
> specific to SELinux which allows system administrators to define sensitivity
> levels and categories and provides a daemon for their translation into human
> readable form. This version is a merge of Joe Nalls git tree (
> http://github.com/joenall/mcstrans) and patches supplied by Dan Walsh and
> others at RedHat.
> 
> Ted
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
