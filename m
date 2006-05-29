Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4TDpdGK004158
	for <selinux@tycho.nsa.gov>; Mon, 29 May 2006 09:51:39 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4TDpcOn027891
	for <selinux@tycho.nsa.gov>; Mon, 29 May 2006 13:51:38 GMT
Subject: Re: daemons and MCS categories
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>,
        Shintaro Fujiwara <shin216@xf7.so-net.ne.jp>
In-Reply-To: <200605220930.05483.russell@coker.com.au>
References: <200605220930.05483.russell@coker.com.au>
Content-Type: text/plain
Date: Mon, 29 May 2006 09:52:17 -0400
Message-Id: <1148910738.14262.67.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-05-22 at 09:30 +1000, Russell Coker wrote:
> It seems to me that there is a benefit to giving some categories to daemons.
> 
> For example we may have two different categories for files that should be 
> protected from each other but which are to be shared by Apache (note that 
> categories in MCS are used for protecting integrity as well as 
> confidentiality).

I don't understand why you say that, MCS isn't used for integrity, that
is what type enforcement is for.

> One idea that occurred to me is to give Apache (and other daemons) categories 
> c128.c255.  Then there are 128 categories that can be used to restrict access 
> of files that should not be accessed by daemons and 128 categories that can 
> be used for files that can be accessed by daemons.

I agree with James on this, I don't think we want to impose semantics in
the MCS categories, and that this

> Another possibility is to have the ability to configure which categories are 
> assigned to a daemon via run_init or some similar program.  It would not be 
> difficult to read a config file that maps the domain of a daemon to the range 
> that should be granted to it.

is useful so that if users do want to run a daemon with categories, they
can.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
