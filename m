Message-Id: <200507200203.j6K23jvx018651@gotham.columbia.tresys.com>
From: "Frank Mayer" <mayerf@tresys.com>
To: "'Casey Schaufler'" <casey@schaufler-ca.com>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>,
   "'Jim Carter'" <jwcart2@epoch.ncsc.mil>,
   "'SELinux'" <SELinux@tycho.nsa.gov>
Subject: RE: Latest diffs
Date: Tue, 19 Jul 2005 22:03:45 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <20050720000557.77677.qmail@web31604.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>> We are removing access
>> to removable_t devices from userspace for mls policy to help get lspp
>> approval.
> 
> Microsoft took an awful lot of grief for doing that in their first C2
> evaluation. What requirement is the sticky issue?

Hmmmm it's been a while but I'm don't recall removable media being a big
issue for any of the NT kernel evaluations...the only issue as I recall, and
this from memory form 13 or so years ago so take it with a grain a salt, was
ensuring that permission could be granted/removed which resulted in Registry
keys being added (i.e., the devices had ACLs but no UI to change them).

In any case, an LSPP evaluation is different. I presume the reasoning has to
do with label integrity and label exporting; non-issues for a C2/CAPP
evaluation.
Frank



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
