Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6SIPUHa017552
	for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2003 14:25:31 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6SIOKFB000433
	for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2003 18:24:21 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h6SIOKGD000430
	for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2003 18:24:20 GMT
Subject: Re: [PATCH] 2.5 / 2.6 merge (fixed)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@verbum.org>
Cc: Miguel Bolanos <mike@linuxlabs.com>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1059416046.23281.2.camel@columbia>
References: 
	 <Pine.LNX.4.21.0307251702130.13530-101000@ucontrol.mobiledns.com>
	 <1059416046.23281.2.camel@columbia>
Content-Type: text/plain
Message-Id: <1059416720.1055.32.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 28 Jul 2003 14:25:21 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-07-28 at 14:14, Colin Walters wrote:
> On Fri, 2003-07-25 at 17:04, Miguel Bolanos wrote:
> > Greetings
> > I apolagize, in the previous mail i sent, i attached the wrong patch for
> > merging, please omit it and take this one instead.
> > Thanks and once again sorry for the inconvenient.
> 
> This has been available here for a while:
> 
> http://www.nsa.gov/selinux/lk/

Note that the SELinux module is also now available in the -mm tree, so
you can use 2.6.0-test2-mm1 without any further patches for SELinux.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
