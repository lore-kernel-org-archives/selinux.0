Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n6KHOkts027571
	for <selinux@tycho.nsa.gov>; Mon, 20 Jul 2009 13:24:46 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id n6KHPYhp017619
	for <selinux@tycho.nsa.gov>; Mon, 20 Jul 2009 17:25:35 GMT
Subject: Re: adding human understandable, and translatable description
 support to selinux
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Christopher Pardy <cpardy@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4A648075.3090402@redhat.com>
References: <4A648075.3090402@redhat.com>
Content-Type: text/plain
Date: Mon, 20 Jul 2009 13:27:17 -0400
Message-Id: <1248110839.23783.721.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-07-20 at 10:34 -0400, Christopher Pardy wrote:
> I'm currently working on improving the gui tools for managing
> selinux(the ones that ship with fedora). One of the things that has
> already come up is a need for more plain English descriptions of
> various policy components. Currently this capability exists in the
> policy.xml for booleans however this file is not rebuilt at policy
> compile time so changes and even the installation of modules is not
> reflected in this. I'd like to propose that a documentation section be
> added to each policy directory, "/etc/selinux/<policyname>/docs/".
> This would contain locale specific documentation files that would
> store information in key-value pairs. ie: {users.guest_u:"A guest user
> who can only (etc)"}. An interface to this store would be built for
> libselinux and support for setting and getting documentation would be
> added to some of the command line tools or given it's own tool.
> Additionally a method would need to be created for policy authors to
> define descriptions in there policy (similar to the policy.xml method)
> Before I get started on this I wanted to see what the general opinion
> on both the need and the best implementation would be. So what do you
> guys think?

Why can't we just build on the policy.xml stuff instead of making a
whole new format?  Refpolicy devel headers already installs sufficient
xml to rebuild the policy.xml.  The xml portion of the headers could be
separated out into a -docs pakage.  Why not just formalize the
(re)building of the xml in the infrastructure?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
