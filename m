Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1MElsNe028911
	for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2007 09:47:54 -0500
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1MEnC8g013832
	for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2007 14:49:12 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8) with ESMTP id l1MElrT9028183
	for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2007 09:47:53 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8/Submit) id l1MElrli028182
	for selinux@tycho.nsa.gov; Thu, 22 Feb 2007 09:47:53 -0500
Subject: Re: [PATCH] sepolgen: leave generated files in current directory
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <45DC891C.50701@mentalrootkit.com>
References: <45DC891C.50701@mentalrootkit.com>
Content-Type: text/plain
Date: Thu, 22 Feb 2007 09:20:36 -0500
Message-Id: <1172154036.14363.364.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-02-21 at 13:02 -0500, Karl MacMillan wrote:
> This patch changes sepolgen so that the generated te files are left in 
> the current directory when generating policy modules (with -M). This 
> matches the behavior of the old audit2allow and allows review of the te 
> file before inserting the module.
> 
> This patch also brings up the question of API stability for the sepolgen 
> library (as it makes a minor change to the API). I suggest that it 
> remain unstable for at least 1 release (i.e., the API can change in 
> arbitrary ways). That should give sufficient time for it to stabilize 
> and, hopefully, become general enough. Thoughts?

Yes, I don't think we need to treat the sepolgen API as stable yet,
particularly given that the only user at present is audit2allow (and
they are packaged together at least in Fedora presently).

> 
> Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>
-- 
Stephen Smalley
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
