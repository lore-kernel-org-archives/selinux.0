Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBE0mkIi008645
	for <selinux@tycho.nsa.gov>; Mon, 13 Dec 2004 19:48:46 -0500 (EST)
Received: from web50201.mail.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id iBE0l4Ux001934
	for <selinux@tycho.nsa.gov>; Tue, 14 Dec 2004 00:47:04 GMT
Message-ID: <20041214004849.25751.qmail@web50201.mail.yahoo.com>
Date: Mon, 13 Dec 2004 16:48:49 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [patch] selinux_capget()
To: Darrel Goeddel <dgoeddel@TrustedCS.com>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
In-Reply-To: <41BE1887.4010201@trustedcs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Darrel Goeddel <dgoeddel@trustedcs.com> wrote:

> Currently, SELinux restricts the use of capabilities
> by a process based on the 
> process domain's access to the capability security
> class.  This restriction is 
> not reflected in the capabilities returned by the
> capget system call.  I have 
> attached a small patch which would remove the
> "disallowed" capabilities from the 
> effective set that is returned from the call.  This
> seems to be a good idea to 
> me because it gives an accurate picture of the the
> capabilities that a process 
> can use.  Does anyone else have an opinion on this?

I do! I do!

The POSIX 1003.1e/2c (previously P1003.6) working
group that developed the capabilities interface
upon which Linux capabilities are based discussed
this issue at length. The concensus was that such
a "correction" should not be made. One example that
was used to demonstrate the rationale is a system
(such as IRIX) on which you are allowed to perform
a privileged operation if you have the capability
or if your UID is zero (i.e. you are root). The
getcap() call should not "correct" the effective
set of capabilities to indicate they are all on
for a root process, but should instead return the
actual set. This is in line with the "stat" behavior
which reports the actual mode bits, even if they
include "w" on a read-only file system.

Briefly, the intent of the POSIX specification
is that you should not "correct" the effective set
due to the impact of additional policies or
conditions.


=====
Casey Schaufler
casey@schaufler-ca.com


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Find what you need with new enhanced search.
http://info.mail.yahoo.com/mail_250

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
