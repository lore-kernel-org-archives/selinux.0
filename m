Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9A8SbWt001496
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 04:28:39 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9A8SaUb026361
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 08:28:36 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id h9A8SZhX026358 for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 08:28:36 GMT
Date: Fri, 10 Oct 2003 09:28:34 +0100
From: Dale Amon <amon@vnl.com>
To: selinux@tycho.nsa.gov
Subject: Re: newrules.pl -o option
Message-ID: <20031010082834.GA31227@vnl.com>
References: <200310090124.AA01358@ilios104.ori.hitachi-sk.co.jp> <1065723279.53567.0.camel@vorpal.mcs.drexel.edu> <20031010090846.5bdaf336.ynakam@ori.hitachi-sk.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031010090846.5bdaf336.ynakam@ori.hitachi-sk.co.jp>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Since the topic of newrules.pl has come up...

Russ made a point some time back that it may be
a bad idea for it to have the .pl extension as
it might someday be rewritten in C or whatever.
Not that it necessarily will, but it is generally
a bad idea to put extensions on "binaries" that
should end up in /sbin or /usr/sbin/.

Which also brings up the point, what is the most
appropriate place for it to install? Would it be
wise for it to be useable during early boot, thus in
/sbin, or just later in /usr/sbin? Or should it be
considered a user tool and be in /bin or /sbin?

I'd personally tend to /usr/sbin since autogen
of rule fixes during boot is not in general a 
good idea...

-- 
------------------------------------------------------
       IN MY NAME:            Dale Amon, CEO/MD
  No Mushroom clouds over     Islandone Society
    London and New York.      www.islandone.org
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
