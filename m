Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2OExbx6002621
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 09:59:39 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h2OEu5lY025137
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 14:56:05 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id h2OEu4KX025134
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 14:56:05 GMT
Date: Mon, 24 Mar 2003 09:58:29 -0500 (EST)
From: Chris Vance <cvance@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: general policy stuff
In-Reply-To: <200303170036.12421.russell@coker.com.au>
Message-ID: <Pine.LNX.4.33.0303240942130.31241-100000@zorg.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 17 Mar 2003, Russell Coker wrote:

> Recently the line
> allow $2_t console_device_t:chr_file rw_file_perms;
> was added to the daemon_sub_domain() macro.  I don't think that this is
> desired as the ability to read/write to the console can allow a daemon a
> dangerous level of access (maybe offering a trojan login prompt).

Define recently?  CVS annotate indicates that this change was committed to
our internal tree 14-Jun-02 and was subsequently pushed out to sourceforge
03-Jul-02.  Our internal CVS log also indicates that this has always been
a part of the daemon_sub_domain() -- which I thought you submitted, our
log only says: 'Merge Russell Coker's selinux-small_2002053110-3.diff
policy changes.'

We can remove this line, but I'm curious how many child domains will break
when we do that?

chris.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
