Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j11IgT53017392
	for <selinux@tycho.nsa.gov>; Tue, 1 Feb 2005 13:42:29 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j11IeKrX000132
	for <selinux@tycho.nsa.gov>; Tue, 1 Feb 2005 18:40:21 GMT
Subject: Re: File Browsing apps and getattr
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1107264676.26936.63.camel@moss-spartans.epoch.ncsc.mil>
References: <1107210369.1928.5.camel@cobra.ivg2.net>
	 <1107259894.26936.27.camel@moss-spartans.epoch.ncsc.mil>
	 <1107263308.6722.5.camel@cobra.ivg2.net>
	 <1107263499.26936.50.camel@moss-spartans.epoch.ncsc.mil>
	 <1107264384.6956.2.camel@cobra.ivg2.net>
	 <1107264676.26936.63.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 01 Feb 2005 11:42:34 -0700
Message-Id: <1107283354.7117.13.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> You can certainly propose allowing access to additional file types on a
> case-by-case basis, possibly introducing new attributes to identify the
> desired set of types, but adding permissions always requires a
> justification, not just 'why not?'.  What is the functional requirement
> that ls display the attributes of those subdirectories/files?  What is
> the real benefit if you cannot search the subdirectories or read the
> files?

I've accepted that searching the subdirectories and reading the files
is something we do not want to/need to do. I was just asking about the
getattr check. 

I understand your arguments, however, and will agree this is not
absolutely necessary. What needs to be done in that case is dontaudit,
so that those denials go away.

> dontaudit is appropriate if you just want to silence the warnings,
> although you obviously don't want to do that for a file to which you
> truly want to track attempted accesses.

Would it be acceptable to have dontaudit getattr on dir_file_class_set
for file browsing applications. I currently have a rule like that in the
mplayer policy? If not, how would you suggest the denials be suppressed?

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
