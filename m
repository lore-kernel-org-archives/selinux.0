Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA24634
	for <selinux@tycho.nsa.gov>; Tue, 28 Jan 2003 08:29:41 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0SDTeI10099
	for <selinux@tycho.nsa.gov>; Tue, 28 Jan 2003 13:29:41 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id h0SDTdf10095 for <selinux@tycho.nsa.gov>; Tue, 28 Jan 2003 13:29:39 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: j.logsdon@lancaster.ac.uk, selinux@tycho.nsa.gov
Subject: Re: Some questions ...
Date: Tue, 28 Jan 2003 14:29:30 +0100
References: <Pine.LNX.4.10.10301281113250.1316-100000@mercury.quantex>
In-Reply-To: <Pine.LNX.4.10.10301281113250.1316-100000@mercury.quantex>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_6WoN+FJU5NqsRXJ"
Message-Id: <200301281429.30941.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_6WoN+FJU5NqsRXJ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, 28 Jan 2003 12:34, j.logsdon@lancaster.ac.uk wrote:
> 1) When booting up, I still get a large number of avc denied messages. Do
> (some of) these always come up or is it in principle possible to boot up
> with no such messages?  I am obviously in permissive mode at the moment!:)

I've attached the messages from the early stages of boot of one of my 
machines.  As you can see it's only sys_module access from "lsmod" and the 
"nsd" program (Name Server Daemon) is trying to chown a file.  I'll probably 
fix the nsd issue eventually.

If you get many more than that then it indicates a problem with policy, 
labelling, or configuration of boot scripts.

> 2) One cronned job really took over the machine - I think it was tripwire
> (don't know why I had it installed at all) - where after a short period
> (generally when I wasn't looking) the load meter went solid and absolutely
> nothing could be done.  I tracked it down to a job initiated by cron from

I imagine that it was accessing a huge number of files that it is not 
permitted to, and SE Linux was logging all the errors to syslog, and you have 
your syslogd configured to write the files synchronously.  If you run in 
enforcing mode such things are less of an issue.  In enforcing mode a program 
will be denied access to a directory rather than having a log entry for each 
file it tries to access.

For the moment put a "-" before the file name for the kernel log in 
/etc/syslog.conf so it doesn't write synchronously.

> 3) If I boot into another kernel then back into selinux, do I have to run
> make relabel each time?  It takes ages on my box - I would go into
> overdose if I made coffee all the time.

Yes.  As for the overdose issue, just don't run a non-SE kernel.  There's no 
reason to.

> 5) I know it is not a good idea to start X from root (head hung in shame
> but I am the only user at the moment and it is not connected to anything
> sensitive) but an appropriate message saying it was not allowed would be
> better than hanging the machine I think...  Is this in the new version?

If you are in permissive mode then it should not be able to hang the machine 
or prevent the usual operation in any other way.

In any case if you have the wrong permissions for the X server and you are not 
using a frame-buffer driver with SAK enabled then you are likely to hang your 
machine.  The X server is very invasive and does a lot of direct hardware 
access.  Frame Buffer rules!

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_6WoN+FJU5NqsRXJ
Content-Type: text/plain;
  charset="iso-8859-1";
  name="avc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="avc"

Jan 15 23:15:23 lyta kernel: avc:  denied  { sys_module } for  pid=118 comm=lsmod capability=16 scontext=system_u:system_r:initrc_t tcontext=system_u:system_r:initrc_t tclass=capability
Jan 15 23:15:23 lyta kernel: avc:  denied  { sys_module } for  pid=379 comm=lsmod capability=16 scontext=system_u:system_r:hotplug_t tcontext=system_u:system_r:hotplug_t tclass=capability
Jan 15 23:15:23 lyta kernel: avc:  granted  { avc_toggle } for  pid=407 exe=/sbin/avc_toggle scontext=system_u:system_r:initrc_t tcontext=system_u:system_r:kernel_t tclass=system
Jan 15 23:15:23 lyta kernel: avc:  denied  { sys_module } for  pid=450 comm=lsmod capability=16 scontext=system_u:system_r:hotplug_t tcontext=system_u:system_r:hotplug_t tclass=capability
Jan 15 23:15:23 lyta kernel: avc:  denied  { sys_module } for  pid=455 comm=lsmod capability=16 scontext=system_u:system_r:hotplug_t tcontext=system_u:system_r:hotplug_t tclass=capability
Jan 15 23:15:40 lyta kernel: avc:  denied  { chown } for  pid=1068 comm=nsd capability=0 scontext=system_u:system_r:nsd_t tcontext=system_u:system_r:nsd_t tclass=capability

--Boundary-00=_6WoN+FJU5NqsRXJ--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
