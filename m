Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6MHXEgA007812
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 13:33:14 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6MHRdKk022539
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 17:27:39 GMT
Subject: Re: Iptables discussion
From: Jason Tang <jtang@tresys.com>
To: gyurdiev@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1122046798.25951.27.camel@celtics.boston.redhat.com>
References: <200507221246.j6MCkqvx015455@gotham.columbia.tresys.com>
	 <1122039886.24847.6.camel@celtics.boston.redhat.com>
	 <42E10804.5030401@tresys.com>
	 <1122046798.25951.27.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Fri, 22 Jul 2005 13:28:12 -0400
Message-Id: <1122053292.32644.51.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Greetings Ivan.  I co-authored libsemanage.  Karl requested that I
respond to your concerns.

On Fri, 2005-07-22 at 11:39 -0400, Ivan Gyurdiev wrote:
> Dan asked why the API is assymetric (connect vs disconnect-free),
> but no one has answered this question yet. In addition, I see a 

One reason for this proposed design is to allow for SELinux clients that
employ a multi-processor design (i.e., fork() + do stuff in the child).
Suppose that the semanage backend is writing directly to /etc/selinux.
If the child process performs a disconnect() it will release the
semanage file lock that its parent had acquired.  What the child really
wants to do is free() its memory without disturbing the file lock.

> We should not buffer errors - we should provide the user
> with a better debugging system - do you oppose sepol_enable_debug* ?

The error reporting system is primarily for error reporting and not
debugging purposes.

Furthermore:

On Fri, 2005-07-22 at 12:14 -0400, Ivan Gyurdiev wrote: 
> (1) The errors are buffered, and not displayed as they occur, so you
> don't know what is happening if something hangs

As Karl mentioned, callbacks (and other asynchronous events) in
multi-threaded programs are dangerous.  In addition some programs might
not want immediate feedback for various reasons or designs.  Any kind of
system with hard real-time requirements would definitely not use it.

In what manner could a program "hang" without affording the possibility
of reporting an error?  Suppose that your _debug() callback scheme were
to be employed.  At some point in time the program recognizes an error
and invokes the callback.  Now instead one were to use our proposed
error handling scheme.  Instead of making the callback it merely returns
an error code.  Either way program execution has not hung.

-- 
Jason Tang / jtang@tresys.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
