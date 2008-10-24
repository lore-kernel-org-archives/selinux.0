Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9ODJahl012302
	for <selinux@tycho.nsa.gov>; Fri, 24 Oct 2008 09:19:37 -0400
Received: from cdptpa-omtalb.mail.rr.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9ODIApQ027241
	for <selinux@tycho.nsa.gov>; Fri, 24 Oct 2008 13:18:10 GMT
Message-ID: <4901CB4B.3030306@kutulu.org>
Date: Fri, 24 Oct 2008 09:19:07 -0400
From: Mike Edenfield <kutulu@kutulu.org>
MIME-Version: 1.0
To: Jim Meyering <jim@meyering.net>
CC: Vikram Noel Ambrose <noel.ambrose@gmail.com>, bug-coreutils@gnu.org,
        selinux@tycho.nsa.gov, 472590@bugs.debian.org,
        =?UTF-8?B?T25kxZllaiBWYcWh?=
 =?UTF-8?B?w61r?= <ovasik@redhat.com>
Subject: Re: RFC: changing the "+" in ls -l output to be "." or "+"
References: <200803251523.34329.russell@coker.com.au>	<87tziu96yz.fsf@rho.meyering.net> <20080325173116.GQ2626@mathom.us>	<200803260824.17731.russell@coker.com.au>	<877ifj9sgs.fsf@rho.meyering.net> <87prt8uhci.fsf_-_@rho.meyering.net>	<8763njqz9a.fsf@rho.meyering.net> <49013EA2.8070301@gmail.com> <87mygumq37.fsf@rho.meyering.net>
In-Reply-To: <87mygumq37.fsf@rho.meyering.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Jim Meyering wrote:

> A desire for compatibility makes "+" look good.
> "." is appealing for SELinux-only because it's inconspicuous.

Speaking as a fairly new SELinux user/admin, having a "." 
next to every file in my ls output is just as useful or 
non-useful as having a "+" next to them, so does it really 
buy anything?  I end up needing -Z either way.

Based on the kind of real-world problems I've had, the most 
useful thing ls could tell me about a file on my SELinux 
system would be that it *should* have a label and *doesn't*, 
something like:

if ( selinux_enabled )
   if ( label == NULL || label == fs.defaultlabel )
     use "!"
   else
     use " "
else if ( anything else )
   use "+"





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
