Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i58HTfrT013948
	for <selinux@tycho.nsa.gov>; Tue, 8 Jun 2004 13:29:41 -0400 (EDT)
Received: from smtp802.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i58HTZ22025012
	for <selinux@tycho.nsa.gov>; Tue, 8 Jun 2004 13:29:35 -0400 (EDT)
Date: Tue, 8 Jun 2004 17:26:59 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: support for fireflight reading /proc/NNN/fd and /proc/NNN/exe
Message-ID: <20040608172659.GA29575@lkcl.net>
References: <20040607082243.GH4543@lkcl.net> <20040607205957.GA3063@lkcl.net> <20040607232158.GA2073@jmh.mhn.de> <1086714639.32646.23.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1086714639.32646.23.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jun 08, 2004 at 01:11:10PM -0400, Stephen Smalley wrote:
> On Mon, 2004-06-07 at 19:21, Thomas Bleher wrote:
> > Not the macro directly, otherwise all domains which use can_ps() will be
> > affected. If you really need that much access, you should probably add a
> > rule like
> >         allow fireflier_t file_type:file_class_set getattr;
> >         allow fireflier_t domain:{ socket_class_set fifo_file } getattr;
> > But this seems just too broad (see below).
> 
> Definitely too broad.  Use dontaudit rules to suppress the audit
> messages, and only allow it what it truly needs to function.
 
 i've spoken to martin and he accepted a patch on fireflight
 to restrict the stat operations to only those files where
 the symlink name begins with "socket:".

 if anyone with severe linux kernel knowledge (and isn't afraid
 to admit it) can forsee any problems with that approach, please do
 say so!

 martin says the code to do the /proc/<pid>/ walking he
 cut/paste from netstat so gawd only knows what horrors netstat
 gets up to.

 lsof i'd kinda expect to be better behaved and to know a few
 more kernel /proc tricks but for the life of me i can't work
 it out.  i seriously can't be bothered, the code is monster
 spaghetti and looks totally unmaintainable.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
