Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r4GDXPHf023661
	for <selinux@tycho.nsa.gov>; Thu, 16 May 2013 09:33:25 -0400
Message-ID: <5194E01F.2040505@tresys.com>
Date: Thu, 16 May 2013 09:33:19 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
Subject: Future of SETools and CIL
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It has become clear that SETools has fallen behind userspace in terms of
features and general maintenance. We would like to get it to the point
where this is not the case, and to find a way to make sure it does not
happen again. We think the solution to the maintenance issue is to make
it more visible by merging the more useful parts of SETools into the
userspace repo, while deprecating/removing the remaining pieces.

However, we are well aware of the complexity of SETools, primarily
libapol, and that upstreaming it without any changes would not solve the
problems. So, we have done a little work behind the scenes to find a way
to reduce the complexity of libapol. As a first stab at it, we started
with an older version of libapol that is quite a bit less complex and
began porting it forward for use with modern userspace, and seeing if it
would make sense to eventually merge. But before we get too deep into
this port, we wanted to start a discussion with the SELinux community to
make sure we are headed in the right direction. So to start, does this
seem like a good idea (both merging with userspace and porting older
libapol)? Or should we take a completely different direction (e.g. the
use of graphing databases as a replacement of apol has been mentioned in
the past)?

Another discussion we would like to have, which may affect the future of
SETools/apol, is CIL. Is there still interest in CIL? And if so, have
there been any thoughts on using and migrating to CIL? Is more work
needed before this can happen? Has anyone put thought into higher level
languages that could sit on top of CIL? If there is interest, this may
affect the SETools changes, for example, syntactic policy analysis for
CIL is likely very different than current policy.

Thanks,
- Steve


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
