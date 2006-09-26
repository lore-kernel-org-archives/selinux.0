Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8QDhE36015907
	for <selinux@tycho.nsa.gov>; Tue, 26 Sep 2006 09:43:14 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k8QDgBoN003201
	for <selinux@tycho.nsa.gov>; Tue, 26 Sep 2006 13:42:11 GMT
Subject: Re: Latest diffs.  Trimmed down this time.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Erich Schubert <erich@debian.org>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1159216788.12513.17.camel@wintermute.xmldesign.de>
References: <45183220.8090106@redhat.com>
	 <1159216788.12513.17.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Tue, 26 Sep 2006 09:43:55 -0400
Message-Id: <1159278241.3920.253.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-09-25 at 22:39 +0200, Erich Schubert wrote:
> Hello Daniel,
> > Doesn't ssh need
> > +       userdom_search_all_users_home_dirs(sshd_t)
> 
> getattr is supposedly sufficient, no need for searching. See earlier
> thread.

I've already fixed this in a different way.  Getattr by itself is not
sufficient, you need search too.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
