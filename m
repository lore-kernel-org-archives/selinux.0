Date: Tue, 9 Jul 2002 07:22:30 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: JW <jw@centraltexasit.com>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Names of files in policy/file_contexts/program/
In-Reply-To: <200207081912.04287.jw@centraltexasit.com>
Message-ID: <Pine.GSO.4.33.0207090720520.27193-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 8 Jul 2002, JW wrote:

> What governs the names of the files in policy/file_contexts/program/ ?
> Do they match the binary name, or is it referenced from somewhere else?

The policy Makefile expects the program .fc files to match the names of
the corresponding program .te files.  The set of .fc files is
automatically generated from the list of .te files that are present (see
the FCFILES definition in the Makefile), so that you can remove .te files
and have the corresponding .fc files automatically ignored.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
