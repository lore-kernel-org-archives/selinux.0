Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8GK6NNs000656
	for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2005 16:06:23 -0400 (EDT)
Received: from mail.nagafix.co.uk (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8GK2xvo008005
	for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2005 20:02:59 GMT
Subject: Re: error building file_contexts
From: Antoine Martin <antoine@nagafix.co.uk>
To: Eric Paris <eparis@parisplace.org>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1126647898.3769.19.camel@localhost>
References: <1126563533.13869.5.camel@localhost>
	 <1126617433.29303.25.camel@moss-spartans.epoch.ncsc.mil>
	 <1126618085.4218.14.camel@localhost.localdomain>
	 <1126623363.6074.7.camel@localhost.localdomain>
	 <1126647898.3769.19.camel@localhost>
Content-Type: text/plain
Date: Fri, 16 Sep 2005 21:32:40 +0100
Message-Id: <1126902760.17715.16.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -/usr/sbin/amavisd(.*)?/*$
For reference, this should have been (...)amavisd.*
(I had plenty of similar mistakes in my fc files)

Not sure why this has only surfaced now, I am pretty sure this mistake
has been in my *.fc files for a while.

The changes to the script were really helpful, maybe it would be helpful
to have a debug option to enable this output? (or somehow make it part
of the backtrace) - sorry I can't hack python to that extent.
>                         regex = regex + "/*$"
>                         sys.stderr.write("-%s\n" % regex)
>                         sys.stderr.write("-%s\n" % potential)
>                         sys.stderr.flush()
>                         if re.search(regex, potential, 0):
>                                 addme = 0
> 

Antoine


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
