Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA25762
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 09:43:09 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA03954
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 13:42:38 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id NAA03950
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 13:42:38 GMT
Date: Thu, 27 Jun 2002 09:42:09 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>
cc: "'Michael Nyika'" <nyix@yahoo.com>, <selinux@tycho.nsa.gov>
Subject: RE: Object Security Classes
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A1015243B2@csoc-mail-box.csoconline.com>
Message-ID: <Pine.GSO.4.33.0206270938330.1331-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 27 Jun 2002, Westerman, Mark wrote:

> /usr/local/selinux/flask/access_vectors
>
> The definition of class define the attribute that
> they can take on.

Just to clarify, the 'security_classes' file declares the set of object
security classes, and the 'access_vectors' file defines the set of
permissions for each object class.  Both files live in
lsm-2.4/security/selinux/flask in the kernel source tree and are installed
into /usr/local/selinux/flask (upstream) or /usr/lib/selinux (Debian).

As noted in the report, these definitions are not specific to any
particular security model, and should rarely change.  Changes to these
files require recompilation of the module and policy, and will typically
require updates to the module and policy to use the new values.  These
files do not need to be modified to configure the security model
implemented by the example security server.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
