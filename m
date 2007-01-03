Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l04BV1jC000318
	for <selinux@tycho.nsa.gov>; Thu, 4 Jan 2007 06:31:01 -0500
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l04BVjOg008099
	for <selinux@tycho.nsa.gov>; Thu, 4 Jan 2007 11:31:46 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Latest diffs
Date: Thu, 4 Jan 2007 09:05:35 +1100
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
References: <459BDFD4.7080903@redhat.com>
In-Reply-To: <459BDFD4.7080903@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701040905.40416.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 04 January 2007 03:54, Daniel J Walsh <dwalsh@redhat.com> wrote:
> allow_daemons_dump_core - Allow daemons to create corefiles in /

I hope you aren't planning to make this be on by default.  The potential for 
daemons creating files such as /.autorelabel is not nice.

It would probably be better to have some other directory for core files, 
someone who wants to collect them all could always change kernel.core_pattern 
to indicate a directory that has appropriate write permissions.

> Fixes for slocate on MLS

Isn't this just a bad idea?

Over the years there have been a number of issues with locate.  The design of 
having all the data in a file that all users can access is risky at best.

Are there actually people who desire both the confidentiality protections that 
MLS offers but who don't desire the integrity protection offered by turning 
off locate?

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
