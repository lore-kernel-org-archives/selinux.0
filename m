MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: restorecond matchpathcon patch
Date: Tue, 20 Feb 2007 13:13:41 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158805267E@exchange.columbia.tresys.com>
References: <20070220165727.62975.qmail@web51509.mail.yahoo.com> <1171990762.14363.141.camel@moss-spartans.epoch.ncsc.mil>
From: "James Athey" <jathey@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>, "Steve G" <linux_4ever@yahoo.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> Possibly the FCGlob work will help address that problem.
> http://selinux-symposium.org/2007/abstracts.php#fcglob
> James Athey (cc'd) - what is the implementation status and prospects for
> code submission?

Here are the tasks we're working on, in order:

1. FCGlob reader and analyzer, written in Python.
2. Translate Reference Policy's fc files into FCGlob, using the results of step 1 to read and compile them.  After compilation, offer to convert the FCGlob specifications back to regular expressions, so that the resulting policy will work on systems with pre-FCGlob toolchains.
3. Update the toolchain to support FCGlob, incorporating the lessons learned from steps 1 and 2.

We're currently working on step 1.  Hence, the toolchain patches will take a little while to appear.  It's great to see that we've gotten the community's attention with our proposal, and we'll be eager to get everyone's thoughts on the work as it's completed.  We'll also be presenting our paper on the subject at this year's SELinux Symposium.

For those of you who haven't heard of FCGlob, it's a replacement syntax for file specifications that looks a lot like shell globbing.  It's a lot easier to write FCGlob specifications, because the syntax is much cleaner than regular expressions, as well as more familiar to most people.  It includes some common-sense rules that make it possible to treat file contexts as sets (in a computer science sense), so it becomes easy to matchpathcon files, find conflicts between specifications, and even display the file system as specified by the file contexts in the policy.

~James Athey




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
