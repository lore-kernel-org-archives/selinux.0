Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j12ETD53022663
	for <selinux@tycho.nsa.gov>; Wed, 2 Feb 2005 09:29:14 -0500 (EST)
Subject: Re: File Browsing apps and getattr
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: ivg2@cornell.edu, selinux@tycho.nsa.gov
In-Reply-To: <4200DEA2.1080008@redhat.com>
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
Content-Type: text/plain
Message-Id: <1107354157.890.133.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 02 Feb 2005 09:22:37 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-02-02 at 09:07, Daniel J Walsh wrote:
> Added file_browse_domain to latest policy
> 
> define(`file_browse_domain', `
> # Do not flood message log, if the user does a browse
> allow $1 file_type - secure_file_type:file getattr;
> dontaudit $1 dev_fs:dir_file_class_set getattr;
> dontaudit $1 sysadmfile:file getattr;
> dontaudit $1 sysadmfile:dir read;
> ')dnl end file_browse_domain

Not clear why you want the dontaudit rules for sysadmfile, and it seems
like there would be a lot of overlap between the dontaudit getattr rule
and the allow getattr rule, meaning that you are wasting an access
vector in most cases.  

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
