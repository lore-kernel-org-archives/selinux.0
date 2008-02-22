MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: [Fwd: excessively verbose policy]
Date: Fri, 22 Feb 2008 10:27:19 -0500
Message-ID: <1203694039.32061.20.camel@gorn>
In-Reply-To: <1203690375.2804.19.camel@moss-spartans.epoch.ncsc.mil>
References: <1203690375.2804.19.camel@moss-spartans.epoch.ncsc.mil>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>, "Karl MacMillan" <kmacmillan@tresys.com>,
        "Chad Sellers" <csellers@tresys.com>,
        "Daniel J Walsh" <dwalsh@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-02-22 at 09:26 -0500, Stephen Smalley wrote:
> I think that this concern is legitimate, although I understand the
> motivation for the current approach.
> 
> -------- Forwarded Message --------
> From: Bill Nottingham <notting@redhat.com>
> To: fedora-selinux-list@redhat.com
> Subject: excessively verbose policy
> Date: Thu, 21 Feb 2008 18:23:21 -0500
> 
> I was writing policy today, and I couldn't help notice a lot of
> repetitiveness in our policy:
> 
> 	libs_use_ld_so(...)
> 	libs_use_shared_libs(...)

I've been thinking about moving this into domain_type() since the only
domain that wouldn't need this would be static linked.  These two
interfaces should also be collapsed into one.

> These are needed by, well, everything. Can't they be assumed-unless-denied?
> 
> Similarly, 99% of confined apps need:
> 
> 	miscfiles_read_localization()
> 	files_read_etc_files(.)

An approach I was considering was making some sort of interface like
"libs_glibc_linked()" or the like, which would have the above shared
libs access plus things like the above two and other related access that
being linked to a fat libc brings along.

>         pipes & stream sockets

the stream sockets tend to be for syslog(), which the
logging_send_syslog_msg() has.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
