MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Policy compiler issues.
Date: Wed, 19 May 2004 18:10:17 -0400
Message-ID: <E7E29FA7C732D146887C784B34AEF6A0044E3FD7@xch-ne-01.ne.nos.boeing.com>
From: "Bush, Daniel" <Daniel.Bush@boeing.com>
To: "SELinux" <SELinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all,
  I've got what is probably a fairly stupid question, but I'll ask anyway:
  I'm trying to deploy SELInux in an embedded environment. Footprint space is tight, every kilobyte counts. The environment is also fairly dynamic, the users list and assigned roles can change fairly rapidly.
  It's my understanding that whenever the users' list changes (aside from default users)in a SELinux system, that the policy files and security labels need to be re-compiled. Is there any way around that? Can a user be assigned a set of (non-default user) roles without re-compiling the security system?

  Another question: Can SELinux be compiled under uClibc? I'm not having much luck at that, and I was wondering if something special needed to be done, or if anybody had any tips.

Thanks in advance for your patience and help.

-=Dan Bush
"Peace through superior surrealism"



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
