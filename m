Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9BHA9rT006780
	for <selinux@tycho.nsa.gov>; Mon, 11 Oct 2004 13:10:10 -0400 (EDT)
Received: from mail.gmx.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i9BHA8WH029217
	for <selinux@tycho.nsa.gov>; Mon, 11 Oct 2004 17:10:08 GMT
Received: from localhost (shorty@debby [127.0.0.1])
	by localhost.localdomain (8.13.1/8.13.1/Debian-15) with ESMTP id i9BH9vjC003226
	for <selinux@tycho.nsa.gov>; Mon, 11 Oct 2004 19:09:58 +0200
Subject: Re: Where to find libselinux-devel-1.11.4-1.src.rpm ?
From: Wolfgang Pfeiffer <roto@gmx.net>
To: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20041010190439.92095.qmail@web51510.mail.yahoo.com>
References: <20041010190439.92095.qmail@web51510.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1097514597.1661.25.camel@debby>
Mime-Version: 1.0
Date: Mon, 11 Oct 2004 19:09:57 +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2004-10-10 at 21:04, Park Lee wrote:
> Hi,
>      I'm doing something in SELinux, and need the
> libselinux-devel-1.11.4-1.src.rpm. I try to find it on the web, I've
> tried to search it either in
> http://fedora.redhat.com/projects/selinux/ or in  http://rpmfind.net/.
> but I would only find libselinux-1.11.4-1.src.rpm,
> libselinux-1.17.14-1.src.rpm,...... etc. 
>    So, would you please tell me where
> libselinux-devel-1.11.4-1.src.rpm is?

a quick search on Google suggests there is no
libselinux-devel-1.11.4-1.src.rpm.

<http://fr.rpmfind.net/linux/rpm2html/search.php?query=libselinux-devel&submit=Search+...>

According to what I saw in some links above I'd guess you simply get
some libselinux-1.11.4-1.src.rpm (that is,not necessarily one from the
page above), compile it via the rpm routines, and then you probably have
automagically something like a 
libselinux-devel-1.11.4-1 RPM. Provided this is what you want in the
end.

But I don't use rpm based OS's any more, so please take this with the
necessary grain of salt ...

>  
>     And, now I'm using FC2,in which libselinux-1.11.4-1.i386.rpm is
> installed. Then, can I use the newest libselinux-1.17.14-1.i386.rpm to
> update my system, while don't update all the other rpm packages? and
> if I do this, will my FC2 be damaged? 

I don't know.

Best Regards
Wolfgang
-- 
Wolfgang Pfeiffer                           gpg ID: 0AA7E825 
Profile, links: http://profiles.yahoo.com/wolfgangpfeiffer


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
