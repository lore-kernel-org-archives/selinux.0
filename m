Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA32xtXZ011970
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 21:59:55 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA32wV8r022745
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 02:58:32 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Frank Mayer" <mayerf@tresys.com>
Subject: Re: dynamic context transitions - a seteuid parallel
Date: Wed, 3 Nov 2004 13:59:43 +1100
Cc: "'Chad Hanson'" <chanson@TrustedCS.com>,
   "'Luke Kenneth Casson Leighton'" <lkcl@lkcl.net>,
   "'SE-Linux'" <selinux@tycho.nsa.gov>
References: <00aa01c4c0da$5acdd960$1e0c010a@columbia.tresys.com>
In-Reply-To: <00aa01c4c0da$5acdd960$1e0c010a@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200411031359.43346.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2 Nov 2004 23:49, "Frank Mayer" <mayerf@tresys.com> wrote:
> So if we were honest, the real reason we want to change security content is
> for performance reasons, not security assurance reason.

Which probably made a lot of sense for Xenix, an 80286 was not a particularly 
fast CPU.

I've just done a quick test of exec time.  For a process to exec itself it 
takes an average of .9ms per exec on a P3-650.  In the past we have discussed 
at length issues related to modifying Samba for best operation under SE 
Linux.  It seems to me that any disk sub-system you might find attached to a 
P3-650 class CPU is unlikely to support 1000 operations of the form of file 
create/open/unlink per second.  So therefore if we were to have a Samba 
server process fork off a child for each file open we still probably wouldn't 
have the exec be the bottleneck for Samba performance.

Now we have to keep in mind that doing a fork/exec for every file open isn't 
the best way of doing such things.  If we create a helper process when the 
SMB authentication is performed and pass requests to it via a Unix domain 
socket then performance should be better.

What is the trend in new CPUs?  Are they getting worse or better for exec 
performance?  The only machine better than a P3-800 that I have for testing 
is a pitiful P-M.


What programs have the greatest performance requirements in terms of launching 
processes under a different context?  I suspect that a Samba server with the 
design changes we discussed could be near the top of the list, with the main 
competitor being a busy web server that's launching cgi-bin scripts.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
