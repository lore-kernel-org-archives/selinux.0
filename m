Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA12963
	for <selinux@tycho.nsa.gov>; Tue, 7 Jan 2003 11:31:42 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA07988
	for <selinux@tycho.nsa.gov>; Tue, 7 Jan 2003 16:29:01 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id QAA07984
	for <selinux@tycho.nsa.gov>; Tue, 7 Jan 2003 16:29:00 GMT
Date: Tue, 7 Jan 2003 11:29:18 -0500 (EST)
From: Chris Vance <cvance@tislabs.com>
To: Joshua Brindle <JBrindle@snu.edu>
cc: <selinux@tycho.nsa.gov>, Chris Vance <cvance@tislabs.com>
Subject: Re: Trusted BSD is selinux compatible?
In-Reply-To: <se183a46.027@atlas.snu.edu>
Message-ID: <Pine.LNX.4.33.0301071054550.13740-100000@zorg.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


SEBSD is a on-going port of the SELinux FLASK and Type Enforcement
implementations to run on top of the TrustedBSD MAC framework.  It will
provide access to FLASK and the Type Enforcement implementations as a
pluggable module for FreeBSD 5.0.

An SEBSD kernel module has been developed and integrated into the
TrustedBSD MAC development tree; hooked directly into the kernel build.
This module includes a ported version of the FLASK access vector cache and
example security server.

Using the interfaces provided by the TrustedBSD MAC framework, SEBSD
currently supports labels and performs access control decisions for
processes, vnodes (files), filesystem mount structures, and devfs entries.
The interface allows labels to be registered and maintained for each of
these kernel resources, as well as retrieved during access control checks.
In addition, management of labels by user processes is permitted using the
policy-agnostic MAC label interfaces provided by the MAC Framework.

This is a rather long winded way of saying yes.  Since SEBSD was a port of
the SELinux AVC and security server, the policy files are binary
compatible.  In fact, when we began the porting effort, we hadn't ported
the policy compiler so we used policy files that were compiled on a Linux
box.  There are some differences at the OS integration layer due to
different OS designs and hook placements, but the goal is to protect the
objects in a consistent manner.

It's is important to note that even though everything is binary compatible
and the source file formats are the same, there are quite a few changes
necessary to correctly label the filesystem and to adequately control
programs for a typical FreeBSD installation.

Another significant difference is the way that TrustedBSD provides generic
interfaces to all loaded security modules.  Management of labels by user
processes is permitted using the policy-agnostic MAC label interfaces
provided by the MAC Framework, not by SEBSD/SELinux specific system calls
and tools.  Basically TrustedBSD labels are always prepended with a
target, for example: 'sebsd/system_u:object_r:root_t' or
'biba/high,mls/equal'


To this end, the 'setfsmac' utility encapsulates regular expression-driven
labeling of file system hierarchies, in a policy-agnostic form, but also
provides backwards compatibility for the SELinux 'file context' format, by
automagically prepending 'sebsd/' to all contexts.

All of the necessary kernel changes to the MAC Framework required to
support the current prototype SEBSD have been merged back into the main
FreeBSD tree and will be present in FreeBSD 5.0 when it is released
(should be fairly soon).

We will provide a prototype SEBSD module for download via the Network
Associates Laboratories open source web page suitable for use on FreeBSD
5.0, and advertise this on FreeBSD and other relevant mailing lists.  In
addition, we will provide an initial adaptation of the SELinux default
policy sufficient to boot and make minimal use of the system.

This is a bit of an overview, so if you have specific questions, please ask!

chris.

On Sun, 5 Jan 2003, Joshua Brindle wrote:

> anyone here used trustedbsd?
>
> --- From www.trustedbsd.org
> Mandatory access control modules based on the framework supporting a
> variety of access control models, including fixed and floating label
> Biba integrity policies, the MLS confidentiality policy, Type
> Enforcement, and other customized policies designed for common FreeBSD
> deployment scenarios. In addition, the SELinux FLASK and Type
> Enforcement implementations will be provided via an SEBSD module,
> providing access to the higher level FLASK service abstraction, and
> mature TE implementation
> ----
>
> does this mean trusted bsd can use selinux policies? Are selinux policy
> formats a pseudo standard? are there other projects like this?
>
> Joshua Brindle
> UNIX Administrator
> Southern Nazarene University
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
