Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n88DrSSp020969
	for <selinux@tycho.nsa.gov>; Tue, 8 Sep 2009 09:53:28 -0400
Received: from mail.seekline.net (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n88Dskbm009062
	for <selinux@tycho.nsa.gov>; Tue, 8 Sep 2009 13:54:46 GMT
Subject: Re: [refpolicy] shutdown domain
From: Stefan Schulze Frielinghaus <stefan@seekline.net>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1252415710.17700.1.camel@gorn.columbia.tresys.com>
References: <1252256475.22458.5.camel@vogon.seekline.net>
	 <1252415710.17700.1.camel@gorn.columbia.tresys.com>
Content-Type: text/plain
Date: Tue, 08 Sep 2009 15:53:19 +0200
Message-Id: <1252417999.2600.3.camel@vogon.seekline.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-09-08 at 09:15 -0400, Christopher J. PeBenito wrote:
[...]
> I'm not sure what the purpose of this would be.  I would think it would
> effectively telinit to the shutdown runlevel, which would be fine for
> apcupsd to do.  The shutdown actions would then be performed by init
> scripts.

Every app which executes /sbin/shutdown needs the following permissions:

files_rw_generic_pids()
init_exec()
init_rw_initctl()
init_write_utmp()

And I don't like the idea that my daemon may write to generic pids e.g..
A shutdown domain may solve such a problem because I
trust /sbin/shutdown but not my daemon ;-)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
