Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jA3LUWMA019946
	for <selinux@tycho.nsa.gov>; Thu, 3 Nov 2005 16:30:32 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id jA3LOfp3023258
	for <selinux@tycho.nsa.gov>; Thu, 3 Nov 2005 21:24:42 GMT
Message-Id: <200511032124.jA3LOqYs026202@gotham.columbia.tresys.com>
From: "Kevin Carr" <kcarr@tresys.com>
To: <selinux@tycho.nsa.gov>, <fedora-selinux-list@redhat.com>
Subject: ANN: Setools-2.2
Date: Thu, 3 Nov 2005 16:24:52 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A new version of setools is available for download on the Tresys Technology
website.  http://www.tresys.com

Included in this release is a new tool called sechecker.  This tool performs
a number of checks on a SELinux policy and is designed to be modular so that
it is easily extensible in the future.  We will be extending the capability
of this tool in the next release.

Sediffx has an updated user interface that separates key elements of the
policy difference for easier analysis (for example rules that were removed
because a type was removed from the policy).  Also added was the ability to
specify renamed types when computing a difference.

Libapol now has support for storing some additional policy components such
as MLS, and constraints.

Various bug fixes are included in this release as well.

Kevin Carr
Tresys Technology
410.290.1411 x137




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
