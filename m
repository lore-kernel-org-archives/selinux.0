Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lA8Ksx6I018548
	for <selinux@tycho.nsa.gov>; Thu, 8 Nov 2007 15:54:59 -0500
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lA8KspMZ029628
	for <selinux@tycho.nsa.gov>; Thu, 8 Nov 2007 20:54:51 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1) with ESMTP id lA8KnJu7012368
	for <selinux@tycho.nsa.gov>; Thu, 8 Nov 2007 15:49:19 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1/Submit) id lA8KnJ5s012367
	for selinux@tycho.nsa.gov; Thu, 8 Nov 2007 15:49:19 -0500
Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lA7NJhH1007461
	for <selinux@tycho.nsa.gov>; Wed, 7 Nov 2007 18:19:43 -0500
Received: from mx.meyering.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lA7NJhPN002404
	for <selinux@tycho.nsa.gov>; Wed, 7 Nov 2007 23:19:43 GMT
From: Jim Meyering <jim@meyering.net>
To: SE Linux <selinux@tycho.nsa.gov>
Cc: bug-coreutils@gnu.org
Subject: Re: should GNU install call matchpathcon by default?
In-Reply-To: <87k5ou9trs.fsf@rho.meyering.net> (Jim Meyering's message of
	"Wed, 07 Nov 2007 12:31:19 +0100")
References: <87k5ou9trs.fsf@rho.meyering.net>
Date: Wed, 07 Nov 2007 23:25:35 +0100
Message-ID: <87fxzh7kww.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Jim Meyering <jim@meyering.net> wrote:
> This morning I noticed a flagrant difference in the speed of
> "make install" for the just-released gettext-0.17.  It took 12(!)
> times longer on a rawhide system than on a usually-slower debian
> unstable system. (3min vs. 15s)

FYI,

Dan Walsh suggested to use
matchpathcon_init_prefix (NULL, "/first_component_of_abs_dest/");
to limit the number of regular expressions matchpathcon will have to
compile.  That works very well, as long as you're not installing into
/usr, in which case it's still better than nothing.  When installing
into /tmp, the example above takes 21-22 seconds, rather than 180.
Much better.  However, installing into /usr/tmp still required about 70
seconds, so there's room for improvement.

I've implemented that, but haven't finished testing.

For reference, the gettext installation process invokes
  install -c -m ... src_file dst_file
1278 times.

Another suggestion:

  - avoid using matchpathcon altogether when there's an existing
      destination file: use its context, instead.

I'm not convinced that this is necessary.
Other opinions?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
