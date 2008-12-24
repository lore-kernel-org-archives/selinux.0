Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mBO7rXQ4003110
	for <selinux@tycho.nsa.gov>; Wed, 24 Dec 2008 02:53:33 -0500
Received: from fgwmail7.fujitsu.co.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id mBO7rVAM010991
	for <selinux@tycho.nsa.gov>; Wed, 24 Dec 2008 07:53:32 GMT
Received: from m5.gw.fujitsu.co.jp ([10.0.50.75])
	by fgwmail7.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id mBO7rUju030669
	for <selinux@tycho.nsa.gov> (envelope-from sakaia@jp.fujitsu.com);
	Wed, 24 Dec 2008 16:53:30 +0900
Received: from smail (m5 [127.0.0.1])
	by outgoing.m5.gw.fujitsu.co.jp (Postfix) with ESMTP id 2154C45DE53
	for <selinux@tycho.nsa.gov>; Wed, 24 Dec 2008 16:53:30 +0900 (JST)
Received: from s5.gw.fujitsu.co.jp (s5.gw.fujitsu.co.jp [10.0.50.95])
	by m5.gw.fujitsu.co.jp (Postfix) with ESMTP id DDE1B45DE52
	for <selinux@tycho.nsa.gov>; Wed, 24 Dec 2008 16:53:29 +0900 (JST)
Received: from s5.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s5.gw.fujitsu.co.jp (Postfix) with ESMTP id BDE801DB8042
	for <selinux@tycho.nsa.gov>; Wed, 24 Dec 2008 16:53:29 +0900 (JST)
Received: from m024.s.css.fujitsu.com (m024.s.css.fujitsu.com [10.0.81.64])
	by s5.gw.fujitsu.co.jp (Postfix) with ESMTP id 737CA1DB8040
	for <selinux@tycho.nsa.gov>; Wed, 24 Dec 2008 16:53:29 +0900 (JST)
Date: Wed, 24 Dec 2008 16:53:28 +0900
From: Atsushi SAKAI <sakaia@jp.fujitsu.com>
MIME-Version: 1.0
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: Question about SELinux userspace library and scripts?
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <4951E501.30803@gmail.com>
References: <4951E501.30803@gmail.com>
Message-Id: <20081224075329.3A0E31807B@m024.s.css.fujitsu.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

Thank you for your comments.

I just want to know that
where is the ALL userland source code?

For example, I thought user-land code is only in userspace library.
But further investigatin found the code also in refpolicy/support.

I am worrying about other unread code or script exists. 

Thanks
Atsushi SAKAI


"Justin P. Mattock" <justinmattock@gmail.com> wrote:

> Atsushi SAKAI wrote:
> > Hi,
> >
> > I have a question about user-space library and script.
> > As far as I know, following 6-library and 1-script are exists.
> >
> > Userspace library(6-libs(utils included))
> >   http://userspace.selinuxproject.org/trac/wiki/Userland
> >
> > macro for reference policy(scripts in following dir)
> >   serefpolicy-3.5.13/support
> >
> > Any other library and script exists ?
> > and 
> > some explanation about serefpolicy macros?
> >
> >
> > Thanks
> > Atsushi SAKAI
> >
> >
> >
> >
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> > the words "unsubscribe selinux" without quotes as the message.
> >
> >   
>  From experience with userland
> just do a git-pull..
> should give the the proper files
> except for python-selinux to build a custom policy
> (as for macros not too sure);
> 
> regards;
> 
> Justin P. Mattock
> 
> 
> 
> 
> 
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
