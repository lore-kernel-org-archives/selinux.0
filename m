Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8KCLEsJ002802
	for <selinux@tycho.nsa.gov>; Sat, 20 Sep 2003 08:21:14 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8KCJVd0001915
	for <selinux@tycho.nsa.gov>; Sat, 20 Sep 2003 12:19:31 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id h8KCJVVY001912
	for <selinux@tycho.nsa.gov>; Sat, 20 Sep 2003 12:19:31 GMT
Date: Sat, 20 Sep 2003 13:21:08 +0100
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: Boot time avc messages
Message-ID: <20030920122108.GE12158@vnl.com>
References: <20030915214153.GE8988@vnl.com> <200309172245.18594.russell@coker.com.au> <20030919154123.GF22480@vnl.com> <200309201632.59282.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200309201632.59282.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Sep 20, 2003 at 04:32:59PM +1000, Russell Coker wrote:
> > Still loads of messages from syslog-ng. I wonder if I'm the
> > first user of this policy who actually uses the full capability
> > of remote logging with syslog-ng? I'm going to see if I can
> 
> Probably.  Let me know what you are getting and I'll change my policy 
> accordingly.

The test machine is a particularly simple setup and doesn't
use as much of the capabilities of the remote logging as some
of my "real" machines. However, this is what I have at the moment:

allow syslogd_t port_t:tcp_socket { name_bind };
allow syslogd_t syslogd_t:capability { fsetid };
allow syslogd_t tty_device_t:chr_file { setattr };

avc:  denied  { name_bind } for  pid=221 
      exe=/sbin/syslog-ng 
      port=999 
      scontext=system_u:system_r:syslogd_t 
      tcontext=system_u:object_r:port_t 
      tclass=tcp_socket

avc:  denied  { fsetid } for  pid=221 
      exe=/sbin/syslog-ng 
      capability=4 
      scontext=system_u:system_r:syslogd_t 
      tcontext=system_u:system_r:syslogd_t 
      tclass=capability

avc:  denied  { setattr } for  pid=221 
      exe=/sbin/syslog-ng 
      dev=sda2 
      ino=946940 
      scontext=system_u:system_r:syslogd_t 
      tcontext=system_u:object_r:tty_device_t 
      tclass=chr_file

> Why does it use port 999?

There are 3 ports discussed in the manual
(found at http://www.balabit.com/products/syslog_ng/reference/book1.html).

The internal default is to listen on 514 tcp and/or udp or send to
that port. However it is also used by rshell, so many people
use the document's example ports instead and place this line in 
syslog-ng.conf:

	    destination d_tcp { tcp("10.1.2.3" port(1999); localport(999)); };
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
