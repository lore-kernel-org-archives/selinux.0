Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6MD6XvW016787
	for <selinux@tycho.nsa.gov>; Sun, 22 Jul 2012 09:06:34 -0400
Message-ID: <1342962360.34427.YahooMailClassic@web87705.mail.ir2.yahoo.com>
Date: Sun, 22 Jul 2012 14:06:00 +0100 (BST)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: Is the CIL project still active
To: jwcart2@tycho.nsa.gov, Jeremy Solt <jsolt@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1342811585.1721.5.camel@moss-lions.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Glad to hear its still going as I started converting the Android policy to CIL using the current compiler that works ok so far. However I'm having problems defining 'sets of classes' for example with M4:

define(`dir_file_class_set (dir file lnk_file sock_file fifo_file chr_file blk_file))

I've tried various methods using classmap/classmapping etc. but failed to work out how to define in CIL:

mlsconstrain dir_file_class_set { create relabelfrom relabelto }
	     (l2 eq h2 and (l1 eq l2 or t1 == mlstrustedsubject));

I can produce CIL mlsconstrain statements when I define them with each class separately but not as a set. Is it possible with the current release of CIL ? (if not I'll just produce an entry for each class so I can continue).

Thanks
Richard


--- On Fri, 20/7/12, James Carter <jwcart2@tycho.nsa.gov> wrote:

> From: James Carter <jwcart2@tycho.nsa.gov>
> Subject: Re: Is the CIL project still active
> To: "Richard Haines" <richard_c_haines@btinternet.com>
> Cc: selinux@tycho.nsa.gov
> Date: Friday, 20 July, 2012, 20:13
> On Fri, 2012-07-20 at 19:39 +0100,
> Richard Haines wrote:
> > Does anyone know the status of the CIL project as it
> looked useful and would seem ideal for SEAndroid.
> 
> There are still a few more bugs that need to be fixed so
> that it can
> correctly compile a CIL-transformed Refpolicy. Progress has
> been slow
> recently, but it is not going to be abandoned.
> 
> -- 
> James Carter <jwcart2@tycho.nsa.gov>
> National Security Agency
> 
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
