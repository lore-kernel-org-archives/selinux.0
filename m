Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7SGUuLa020229
	for <selinux@tycho.nsa.gov>; Thu, 28 Aug 2003 12:30:56 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h7SGUtet002954
	for <selinux@tycho.nsa.gov>; Thu, 28 Aug 2003 16:30:55 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id h7SGUslq002951 for <selinux@tycho.nsa.gov>; Thu, 28 Aug 2003 16:30:55 GMT
Date: Thu, 28 Aug 2003 17:30:44 +0100
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, selinux <selinux@tycho.nsa.gov>
Subject: Re: Package install probs
Message-ID: <20030828163043.GB6898@vnl.com>
References: <20030828144825.GA6898@vnl.com> <200308290149.15229.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200308290149.15229.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Aug 29, 2003 at 01:49:15AM +1000, Russell Coker wrote:
> However if you use a syslogd that includes klogd functionality in the main 
> program (such as syslog-ng) then the thing to do is add the ability to read 
> /proc/kmsg to syslogd_t and change assert.te to refer to syslogd_t instead of 
> klogd_t.

Yep, I switched to syslog-ng and never looked back :-)

Semi-auto install didn't add syslogd.te at all, probably because
it doesn't know about syslog-ng. I had to move that one manually.

I notice you already have the syslog-ng lines in syslogd.te, just
commented out.

dpkg.te also refers to klogd, so I commented that line out
The install does not ignore dpkg.te~ by the way... I stopped it
and deleted the emacs ~ file before procedding with the build.

In assert.te I commented out the assert_execute(klogd). I presume
that's what should be done as there's already and ifdef on 
execute syslogd further down.

Built the policy but it failed to load. I may not have
built capabilities on this kernel so I'll have to double
check that, rebuild and reboot.

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
