Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7UKOvrT007751
	for <selinux@tycho.nsa.gov>; Mon, 30 Aug 2004 16:24:57 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7UKOu10002889
	for <selinux@tycho.nsa.gov>; Mon, 30 Aug 2004 20:24:56 GMT
Subject: Re: policy patch
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: russell@coker.com.au
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <200408282346.05926.russell@coker.com.au>
References: <200408241818.40064.russell@coker.com.au>
	 <1093640295.24188.29.camel@moss-lions.epoch.ncsc.mil>
	 <200408282346.05926.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1093897455.3227.6.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 30 Aug 2004 16:24:16 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks.  Merged.

On Sat, 2004-08-28 at 09:46, Russell Coker wrote:
> On Sat, 28 Aug 2004 06:58, James Carter <jwcart2@epoch.ncsc.mil> wrote:
> > Also added:
> >  allow hotplug_t udev_helper_exec_t:lnk_file read;
> > It seems reasonable and I was seeing a lot of denials, but it might be
> > possible to use a dontaudit.
> 
> I think that a better thing to do is to use "--" on the file_contexts entry 
> for an executable file and have any sym-links with similar named get bin_t or 
> sbin_t.  The contents of a sym-link are almost never of any relevance to the 
> security of the system, but adding more rules increases the size of the 
> policy and the work for all of us.  Also as a side-affect specifying the 
> class of the object to be labelled makes setfiles run faster.
> 
> I have attached a patch which adds -- to all types ending in _exec_t.  It also 
> fixes some bugs in the spamassasin policy and adds a couple of other file 
> contexts things as well.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
