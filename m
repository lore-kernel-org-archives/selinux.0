Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8KDe0sJ002963
	for <selinux@tycho.nsa.gov>; Sat, 20 Sep 2003 09:40:01 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8KDcId0004909
	for <selinux@tycho.nsa.gov>; Sat, 20 Sep 2003 13:38:18 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h8KDcGVY004906
	for <selinux@tycho.nsa.gov>; Sat, 20 Sep 2003 13:38:17 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dale Amon <amon@vnl.com>
Subject: Re: Boot time avc messages
Date: Sat, 20 Sep 2003 23:39:52 +1000
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
References: <20030915214153.GE8988@vnl.com> <200309201632.59282.russell@coker.com.au> <20030920122108.GE12158@vnl.com>
In-Reply-To: <20030920122108.GE12158@vnl.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309202339.52886.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 20 Sep 2003 22:21, Dale Amon wrote:
> The test machine is a particularly simple setup and doesn't
> use as much of the capabilities of the remote logging as some
> of my "real" machines. However, this is what I have at the moment:
>
> allow syslogd_t port_t:tcp_socket { name_bind };

That's not what we want of course, if we know the port then we can assign a 
type to it.

> allow syslogd_t syslogd_t:capability { fsetid };

I still can't work out why syslogd would need fsetid.  What stops working if 
you deny it?

> allow syslogd_t tty_device_t:chr_file { setattr };

If we could make it some sort of standard to write to /dev/tty12 (for example) 
then we could relabel the terminal device(s) in question to a syslog specific 
type and allow syslog to write to it.

Also how does syslog-ng handle ^S on the terminal it's writing to?

> > Why does it use port 999?
>
> There are 3 ports discussed in the manual
> (found at http://www.balabit.com/products/syslog_ng/reference/book1.html).
>
> The internal default is to listen on 514 tcp and/or udp or send to
> that port. However it is also used by rshell, so many people
> use the document's example ports instead and place this line in
> syslog-ng.conf:

So syslog-ng has it's own special method of logging in addition to the 
standard ways?  :(

> 	    destination d_tcp { tcp("10.1.2.3" port(1999); localport(999)); };

What is port 1999 for?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
