Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j11Nd653019549
	for <selinux@tycho.nsa.gov>; Tue, 1 Feb 2005 18:39:06 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j11Nd5YD006317
	for <selinux@tycho.nsa.gov>; Tue, 1 Feb 2005 23:39:08 GMT
Subject: Re: File Browsing apps and getattr
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1107287529.26936.231.camel@moss-spartans.epoch.ncsc.mil>
References: <1107210369.1928.5.camel@cobra.ivg2.net>
	 <1107259894.26936.27.camel@moss-spartans.epoch.ncsc.mil>
	 <1107263308.6722.5.camel@cobra.ivg2.net>
	 <1107263499.26936.50.camel@moss-spartans.epoch.ncsc.mil>
	 <1107264384.6956.2.camel@cobra.ivg2.net>
	 <1107264676.26936.63.camel@moss-spartans.epoch.ncsc.mil>
	 <1107283354.7117.13.camel@cobra.ivg2.net>
	 <1107287529.26936.231.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 01 Feb 2005 16:39:08 -0700
Message-Id: <1107301148.3429.10.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-02-01 at 14:52 -0500, Stephen Smalley wrote:
> On Tue, 2005-02-01 at 13:42, Ivan Gyurdiev wrote:
> > Would it be acceptable to have dontaudit getattr on dir_file_class_set
> > for file browsing applications. I currently have a rule like that in the
> > mplayer policy? If not, how would you suggest the denials be suppressed?
> 
> I think we want to avoid suppressing the audit for all file types, i.e.
> not use file_type by itself.  Possibly a file_type - security_type as
> per Dan's suggestion.  Also, we may be able to legitimately add
> permission for some of these types, possibly adding usercanread to them,
> but it just requires a case-by-case review.

But the audit message can be triggered by legitimate usage (ls -l /etc,
ls -l /var). It doesn't make sense to me to log legitimate usage of a
program as an error. 

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
