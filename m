Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2HCgMRb025705
	for <selinux@tycho.nsa.gov>; Wed, 17 Mar 2004 07:42:22 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i2HCea6Q002572
	for <selinux@tycho.nsa.gov>; Wed, 17 Mar 2004 12:40:36 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i2HCea5t002569
	for <selinux@tycho.nsa.gov>; Wed, 17 Mar 2004 12:40:36 GMT
Subject: Re: newrole failed in enforcing mode
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Carsten Grohmann <carstengrohmann@gmx.de>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>,
   Russell Coker <russell@coker.com.au>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <200403171227.52632.carstengrohmann@gmx.de>
References: <200403101650.07042.carstengrohmann@gmx.de>
	 <200403161839.13748.carstengrohmann@gmx.de>
	 <1079460805.4583.50.camel@moss-spartans.epoch.ncsc.mil>
	 <200403171227.52632.carstengrohmann@gmx.de>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1079527308.10795.5.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 17 Mar 2004 07:41:48 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-03-17 at 06:27, Carsten Grohmann wrote:
> On Dienstag, 16. März 2004 19:13, Stephen Smalley wrote:
> > To debug the newrole failure in enforcing mode, do a 'make
> > enableaudit reload' in policy and then try using newrole, and
> 
> "make enableaudit" was a good hint. The newrole domain needs read 
> access to shadow_t. The attached patch grant this by using the auth 
> attribute. 

This should be handled by having pam_unix run the helper program when it
cannot directly read /etc/shadow, and the helper program should run in a
domain that can read /etc/shadow.  Do you have the same problem with the
latest pam package from the Fedora Core 2 development tree?  The SRPMS
from nsa.gov/selinux are a little old; I've hesitated to update them to
the FC2 devel packages because some of those SRPMS wouldn't build or
would fail regression tests for me on FC1 or even on FC2 test1.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
