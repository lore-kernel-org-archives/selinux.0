Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA06069
	for <selinux@tycho.nsa.gov>; Thu, 8 Nov 2001 08:44:02 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA23322
	for <selinux@tycho.nsa.gov>; Thu, 8 Nov 2001 13:43:54 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id NAA23318
	for <selinux@tycho.nsa.gov>; Thu, 8 Nov 2001 13:43:53 GMT
Date: Thu, 8 Nov 2001 08:43:53 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: "Kevin M. Boland" <Kevin.Boland@verizon.net>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Just starting out
In-Reply-To: <LPEKJJKEHJEBPMAJIMNJOECMCAAA.Kevin.Boland@verizon.net>
Message-ID: <Pine.GSO.4.33.0111080837080.14254-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 8 Nov 2001, Kevin M. Boland wrote:

> 	I am new to this, I have been reading the threads for a week or so. I
> currently have Redhat 7.2 installed, I think I will wait to the release
> version of SELinux before I install. The questions I have is what compliers
> do you use to program SELinux? Is it written in C? Can anyone suggest any
> that are bundle in the Redhat Distribution that would be helpful. Sorry if
> these are basic questions but I am just getting started! I look forward in
> growing with you all in this project.

We are still using RedHat 7.1 as our base platform.  Upgrading to RedHat
7.2 would require us to deal with at least the following:
1) Merging the ext3 filesystem patch since it is not yet supported by the
mainstream Linux kernel which is the base for the LSM kernel that is used
by SELinux,
2) Updating the modified daemons and utilities to newer base versions
where necessary, and
3) Updating the example policy configuration and file_contexts
configuration.

So even the next release of SELinux won't support RedHat 7.2.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
