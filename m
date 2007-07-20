Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6KEkhSV030167
	for <selinux@tycho.nsa.gov>; Fri, 20 Jul 2007 10:46:43 -0400
Received: from mail7.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6KEkf02023344
	for <selinux@tycho.nsa.gov>; Fri, 20 Jul 2007 14:46:42 GMT
Date: Fri, 20 Jul 2007 10:46:40 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Daniel J Walsh <dwalsh@redhat.com>, Eric Paris <eparis@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [Fwd: cups AVC...]
In-Reply-To: <1184941981.17338.801.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Line.LNX.4.64.0707201045520.7144@d.namei>
References: <46A0C494.7060000@redhat.com> <1184941981.17338.801.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 20 Jul 2007, Stephen Smalley wrote:

> Yuck.  We need a better way to handle these things, to avoid having to
> touch policy configuration each time a new pseudo fs type is introduced.
> Possibly the file_system_type structure could also specify labeling
> behavior for security modules.

What about some way of recognising that there is no policy at all for the 
fstype, and just allowing the access (with a warning) ?


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
