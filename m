Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j12G1R53023467
	for <selinux@tycho.nsa.gov>; Wed, 2 Feb 2005 11:01:27 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j12G1SL8026232
	for <selinux@tycho.nsa.gov>; Wed, 2 Feb 2005 16:01:30 GMT
Subject: Re: File Browsing apps and getattr
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, selinux@tycho.nsa.gov
In-Reply-To: <4200E589.8000207@redhat.com>
References: <1107210369.1928.5.camel@cobra.ivg2.net>
	 <1107259894.26936.27.camel@moss-spartans.epoch.ncsc.mil>
	 <1107263308.6722.5.camel@cobra.ivg2.net>
	 <1107263499.26936.50.camel@moss-spartans.epoch.ncsc.mil>
	 <1107264384.6956.2.camel@cobra.ivg2.net>
	 <1107264676.26936.63.camel@moss-spartans.epoch.ncsc.mil>
	 <1107283354.7117.13.camel@cobra.ivg2.net>
	 <1107287529.26936.231.camel@moss-spartans.epoch.ncsc.mil>
	 <1107301148.3429.10.camel@cobra.ivg2.net>
	 <1107345834.890.9.camel@moss-spartans.epoch.ncsc.mil>
	 <1107350380.7449.2.camel@cobra.ivg2.net>  <4200DEA2.1080008@redhat.com>
	 <1107354157.890.133.camel@moss-spartans.epoch.ncsc.mil>
	 <4200E589.8000207@redhat.com>
Content-Type: text/plain
Date: Wed, 02 Feb 2005 09:01:32 -0700
Message-Id: <1107360093.14674.8.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Tightened up a little bit.
> define(`file_browse_domain', `
> # Do not flood message log, if the user does a browse
> dontaudit $1 file_type - secure_file_type:dir_file_class_set getattr;
> dontaudit $1 dev_fs:dir_file_class_set getattr;
> dontaudit $1 file_type - secure_file_type:dir read;
> ')dnl end file_browse_domain

I don't like how security types are being excluded as being special.
I understand the concern, but that will cause audited denials for proper
use of applications like ls. 

Stephen Smalley:
"Yes, shadow_t would fall into that class.  So at that point you might
dontaudit attempts to getattr it from user domains, while leaving them
audited for the daemon domains."

I don't think daemon domains should be using this file_browse_domain
in the first place - seems to me like it should be used only for user
domains. For smbd, for example, something more specialized could be used
like the patch I posted which is restricted to $1_file_type only
(since we don't allow arbitrary samba shares through the filesystem
anyway)

Will user_t be using this macro? 
-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
