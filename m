Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8MAZ1sJ006140
	for <selinux@tycho.nsa.gov>; Mon, 22 Sep 2003 06:35:01 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8MAZ02R020896
	for <selinux@tycho.nsa.gov>; Mon, 22 Sep 2003 10:35:01 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id h8MAZ01A020813 for <selinux@tycho.nsa.gov>; Mon, 22 Sep 2003 10:35:00 GMT
Date: Mon, 22 Sep 2003 11:34:23 +0100
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: Boot time avc messages
Message-ID: <20030922103423.GR12158@vnl.com>
References: <20030915214153.GE8988@vnl.com> <200309201632.59282.russell@coker.com.au> <20030920122108.GE12158@vnl.com> <200309202339.52886.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200309202339.52886.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Sep 20, 2003 at 11:39:52PM +1000, Russell Coker wrote:
> > allow syslogd_t syslogd_t:capability { fsetid };
> 
> I still can't work out why syslogd would need fsetid.  What stops working if 
> you deny it?

In syslog-ng's affile.c it seems to twiddle file ownerships if
necessary when opening a log file, if I correctly understood what
is going on around a chown() call after all of 30 seconds of code
scanning...

> > allow syslogd_t tty_device_t:chr_file { setattr };
> 
> If we could make it some sort of standard to write to /dev/tty12 (for example) 
> then we could relabel the terminal device(s) in question to a syslog specific 
> type and allow syslog to write to it.

Trouble is, this is user configurable, for example, I have this on some of
my machines:

# Virtual console.
#
destination console_all { file("/dev/tty8"); };

> Also how does syslog-ng handle ^S on the terminal it's writing to?

Haven't checked yet. I'm still sipping coffee and the only machine
here in my home office with this running would be the firewall for
which I have to find a keyboard and crawl under the table to connect
it first. Later. :-)

> > There are 3 ports discussed in the manual
> > (found at http://www.balabit.com/products/syslog_ng/reference/book1.html).
> >
> > The internal default is to listen on 514 tcp and/or udp or send to
> > that port. However it is also used by rshell, so many people
> > use the document's example ports instead and place this line in
> > syslog-ng.conf:
> 
> So syslog-ng has it's own special method of logging in addition to the 
> standard ways?  :(
> 
> > 	    destination d_tcp { tcp("10.1.2.3" port(1999); localport(999)); };
> 
> What is port 1999 for?

A server listens on 1999, clients rcv on 999. Sometimes you can have a
machine acting as both, ie a host that consolidates from a local LAN 
as a server and then connects over a tunnel as a logging client to a 
master server.

Here's what a connection looks like in iptstate:

Source IP             Destination IP        Proto   State        TTL    
xx.xx.xx.xx,999       yy.yy.yy.yy,1999        tcp     ESTABLISHED  119:59:42


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
