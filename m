Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i89HJnrT013343
	for <selinux@tycho.nsa.gov>; Thu, 9 Sep 2004 13:19:49 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i89HJjVJ004160
	for <selinux@tycho.nsa.gov>; Thu, 9 Sep 2004 17:19:49 GMT
Date: Thu, 9 Sep 2004 18:30:59 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: at last: info regarding boot problems on multiple partitions
Message-ID: <20040909173059.GB10046@lkcl.net>
References: <20040908224949.GK7717@lkcl.net> <200409100233.47416.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200409100233.47416.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Sep 10, 2004 at 02:33:47AM +1000, Russell Coker wrote:
> On Thu, 9 Sep 2004 08:49, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > FINALLY i got a useable system when i encountered a boot problem
> > [well, i got a console login].
> >
> > the issue is that partitions fail to be mounted.
> >
> > i had noticed over a period of time that programs like pump and dhclient
> > and some others would stop partitions from being unmounted during
> > shutdown.
> >
> > [remember i have /boot, /, /usr, /var and /home]
> >
> > for some reason, this also caused the partitions to fail to MOUNT on
> > startup.
> 
> I've seen a very similar problem, but it was intermittent and didn't occur 
> enough to let me debug it.  

 yes, it is intermittent (being dependent on a program not terminating,
 thereby keeping /usr from being unmounted), and also cyclic.

 cyclic as in you run into the problem through a shutdown, then
 start up, then have to power down again to clear the problem,
 and your system is fine, but on shutdown it happens again.


 it's a pain, and i _think_ it's down to the banning of initrc_t
 from writing to /etc.

 i note that there's an audit message to attempt a touch on a file
 somewhere in /etc.

 if that causes a change in behaviour in one of the early boot-up
 scripts...



> I'm not certain that I saw the same problem but 
> the result of file systems not being mounted was similar.
 
 yes.

> I would be very interested in any further information you may find on this.

 will keep looking.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
