Message-ID: <3F855C35.9060508@redhat.com>
Date: Thu, 09 Oct 2003 09:01:41 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: Broke libselinux into two packages
Content-Type: multipart/mixed;
 boundary="------------020704050303070803040006"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020704050303070803040006
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

It was pointed out to me that their should be two packages for 
libselinux.  Basically the shared libraries and a devel rpm containing .a and .h files.

Packages are out on ftp://people.redhat.com/dwalsh/SELinux/Fedora

Dan


--------------020704050303070803040006
Content-Type: message/rfc822;
 name="Re: Broke libselinux into two packages."
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Re: Broke libselinux into two packages."

Return-Path: <sds@epoch.ncsc.mil>
Received: from mail.boston.redhat.com ([unix socket])
	by mail.boston.redhat.com (Cyrus v2.1.12) with LMTP; Thu, 09 Oct 2003 08:55:38 -0400
X-Sieve: CMU Sieve 2.2
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id h99Ctcnv018425
	for <dwalsh@boston.redhat.com>; Thu, 9 Oct 2003 08:55:38 -0400
Received: from mx1.redhat.com (mx1.redhat.com [172.16.48.31])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with SMTP id h99Ctcc19849
	for <dwalsh@redhat.com>; Thu, 9 Oct 2003 08:55:38 -0400
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by mx1.redhat.com (8.11.6/8.11.6) with SMTP id h99CtcM11445
	for <dwalsh@redhat.com>; Thu, 9 Oct 2003 08:55:38 -0400
Received: from moss-spartans.epoch.ncsc.mil (moss-spartans [144.51.25.121])
	by epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id h99CtWAn008974
	for <dwalsh@redhat.com>; Thu, 9 Oct 2003 08:55:32 -0400 (EDT)
Subject: Re: Broke libselinux into two packages.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <3F855A4C.4010500@redhat.com>
References: <3F855A4C.4010500@redhat.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1065704131.8181.181.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Oct 2003 08:55:31 -0400
Content-Transfer-Encoding: 7bit

On Thu, 2003-10-09 at 08:53, Daniel J Walsh wrote:
> It was pointed out to me that their should be two packages for 
> libselinux.  Basically the
> shared libraries and a devel rpm containing .a and .h files.
> 
> Packages are out on people.

You should send this kind of email (along with your earlier patch) to
the public selinux list.  Why not?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--------------020704050303070803040006--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
