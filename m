Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5HFwkrT010492
	for <selinux@tycho.nsa.gov>; Thu, 17 Jun 2004 11:58:46 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5HFwbMX011486
	for <selinux@tycho.nsa.gov>; Thu, 17 Jun 2004 15:58:37 GMT
Subject: RE: Fedora Core 2 setools RPM
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'John D. Ramsdell'" <ramsdell@mitre.org>, selinux@tycho.nsa.gov
In-Reply-To: <200406171535.i5HFZVSf032291@gotham.columbia.tresys.com>
References: <200406171535.i5HFZVSf032291@gotham.columbia.tresys.com>
Content-Type: text/plain
Message-Id: <1087487902.25033.89.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 17 Jun 2004 11:58:22 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-06-17 at 11:36, Karl MacMillan wrote:
> I am not aware of an setools-devel rpm that installs the include files and
> libapol.a. I think at one point the setools rpms that Dan Walsh was making
> for Redhat/Fedora installed these files, but the current rpms for Fedora do
> not.
> 
> In general, we have not spent many resources addressing the use of libapol
> outside of setools. Because of this, we haven't added a target to install
> the headers and library. The simplest thing to do is to download our source
> and work within the setools directory. Otherwise, it is easy to write an
> install target if you want.

I think it would be helpful for libapol to be available for third party
packages to encourage other people working on policy tools to re-use and
(if necessary) contribute extensions back to libapol rather than
reinventing the wheel each time.  I'd also think you would want both
shared and static libraries, and have most of the tools dynamically
linked against the shared library.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
