Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id AAA22385
	for <selinux@tycho.nsa.gov>; Thu, 25 Oct 2001 00:27:42 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id EAA13246
	for <selinux@tycho.nsa.gov>; Thu, 25 Oct 2001 04:27:07 GMT
Received: from localhost.localdomain (fdslppp21.dnvr.uswest.net [63.225.20.21])
	by jazzband.ncsc.mil  with ESMTP id EAA13242
	for <selinux@tycho.nsa.gov>; Thu, 25 Oct 2001 04:27:07 GMT
Date: Wed, 24 Oct 2001 22:09:58 -0600 (MDT)
From: Dave Nielsen <dave@technogeeks.com>
To: Stephen Smalley <sds@tislabs.com>
cc: Paul Krumviede <pwk@acm.org>,
        "White, Tom (AZ15)" <tom.white@honeywell.com>, <selinux@tycho.nsa.gov>
Subject: Re: Problems with install
In-Reply-To: <Pine.GSO.4.33.0110241825500.20260-100000@raven>
Message-ID: <Pine.LNX.4.33.0110242157360.1787-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 24 Oct 2001, Stephen Smalley wrote:

|
|On Wed, 24 Oct 2001, Paul Krumviede wrote:
|
|> i've had occasion to wonder about the formatting of the
|> README file. in the BUILDING section, one is presented
|> with two options. the final paragraph ("To build the SELinux
|> module..."), while it seems to be intended for use with
|> the second config/build option, isn't indented. a naive
|> reading of the build instructions might cause someone
|> to (re-)build the SELinux module as if it were a loadable
|> kernel module, and that might cause problems.
|
|Oh, I see your point.  I'll try to make it clearer in the README.
|
What about breaking the instructions into two files and have the README
point the user to the file that goes with the build that he is wanting.

IE.
Install.kernel for the instructions on building inside of the kernel

or

Install.module for the instructions on building the SELinux as a modular

Dave


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
