Reply-To: <mayerf@tresys.com>
From: "Frank Mayer" <mayerf@tresys.com>
To: "'Joshua D. Guttman disp: current'" <guttman@mitre.org>
Cc: "'Karl MacMillan'" <kmacmillan@tresys.com>,
   "'SELinux List'" <SELinux@tycho.nsa.gov>,
   "'Stephen D. Smalley'" <sds@epoch.ncsc.mil>,
   "'Amy L. Herzog'" <aherzog@mitre.org>,
   "'John D. Ramsdell'" <ramsdell@mitre.org>,
   "'Galen B. Williamson'" <gwilliam@mitre.org>,
   "'Grant M. Wagner'" <gmw@tycho.ncsc.mil>, "'David Caplan'" <dac@tresys.com>
Subject: RE: Announce: SELinux conditional policy extensions
Date: Mon, 16 Feb 2004 20:50:40 -0500
Message-ID: <002e01c3f4f8$72f9b4e0$6601a8c0@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <nhau11qk9gf.fsf@malabar.mitre.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> When you refer to conflicting rules, what do you mean?
> 

The readme file certainly could do a better job here.  From memory, I believe
there is a potential to have conflicts for the type_* rules.  For example, the
semantics of type_transition is that for each key (i.e., each
source-target-class triple), only one "default type" may be specified.  Thus we
must ensure that only on type_transition rule is in effect at any one time for
each policy.  That is the de-conflicting that the parsers does as described by
the readme file.

There is no such conflict in the AVC rules such as allow.

Frank


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
