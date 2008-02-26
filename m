Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1QJ9awV000538
	for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2008 14:09:36 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m1QJ9SQG013966
	for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2008 19:09:29 GMT
Subject: Re: Global requirements were not met
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Ronald van den Blink <selinux@a61.nl>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <C3EA1F2C.299B%selinux@a61.nl>
References: <C3EA1F2C.299B%selinux@a61.nl>
Content-Type: text/plain
Date: Tue, 26 Feb 2008 14:06:56 -0500
Message-Id: <1204052816.32061.193.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-02-26 at 19:55 +0100, Ronald van den Blink wrote:
> On [DATE], "[NAME]" <[ADDRESS]> wrote:
> 
> > On Tue, 2008-02-26 at 17:06 +0100, selinux@a61.nl wrote:
> >> Still having problems setting up modules dor JBoss + Java:
> >> 
> >> I believe our JBoss module has a fine start now. We decided to write a
> >> complete new java-module (jbossjava) so we will be able to get java to
> >> work is strict-mode.
> >> 
> >> See the following files:
> >> myjboss.if: http://pastebin.com/f4df202a2
> >> myjboss.te: http://pastebin.com/d7318637b
> >> myjboss.fc: http://pastebin.com/f2f66ff68
> >> 
> >> jbossjava.if: http://pastebin.com/f179749e8
> >> jbossjava.te: http://pastebin.com/f1731b45d
> >> jbossjava.fc: http://pastebin.com/f52227f13
> > [...]
> >>    1:selinux-policy-strict  ########################################### [
> >> 33%]
> >> libsepol.print_missing_requirements: jbossjava's global requirements were
> >> not met: type/attribute jboss_rx_t
> >> libsemanage.semanage_link_sandbox: Link packages failed
> >> semodule:  Failed!
> > [...]
> >> Apparently, jbossjava doesn't have any access to the interfaces in
> >> myjboss.pp. why?
> > 
> > Its not an interface problem, jboss_rx_t isn't declared.
> 
> If I look in the myjboss.if file I see:
> 
> interface(`jboss_rx_files',`
>         gen_require(`
>                 type jboss_rx_t;
>         ')
>         allow $1 jboss_rx_t:file exec_file_perms;
> ')
> 
> If I understand the interfaces right it is declared in the gen_require
> statement? And then we can use it in jbossjava.te:
> 
> jboss_rx_files(jbossjava_t)
> 
> Or do we not understand the way interfaces work? Do we have to declare
> jboss_rx_t in jbossjava.te also?

gen_require only specifies dependencies, it doesn't declare them.  You
still have to declare it in jbossjava.te.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
