Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j12E7f53022470
	for <selinux@tycho.nsa.gov>; Wed, 2 Feb 2005 09:07:42 -0500 (EST)
Message-ID: <4200DEA2.1080008@redhat.com>
Date: Wed, 02 Feb 2005 09:07:30 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: ivg2@cornell.edu
CC: Stephen Smalley <sds@epoch.ncsc.mil>, selinux@tycho.nsa.gov
Subject: Re: File Browsing apps and getattr
References: <1107210369.1928.5.camel@cobra.ivg2.net>	 <1107259894.26936.27.camel@moss-spartans.epoch.ncsc.mil>	 <1107263308.6722.5.camel@cobra.ivg2.net>	 <1107263499.26936.50.camel@moss-spartans.epoch.ncsc.mil>	 <1107264384.6956.2.camel@cobra.ivg2.net>	 <1107264676.26936.63.camel@moss-spartans.epoch.ncsc.mil>	 <1107283354.7117.13.camel@cobra.ivg2.net>	 <1107287529.26936.231.camel@moss-spartans.epoch.ncsc.mil>	 <1107301148.3429.10.camel@cobra.ivg2.net>	 <1107345834.890.9.camel@moss-spartans.epoch.ncsc.mil> <1107350380.7449.2.camel@cobra.ivg2.net>
In-Reply-To: <1107350380.7449.2.camel@cobra.ivg2.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Added file_browse_domain to latest policy

define(`file_browse_domain', `
# Do not flood message log, if the user does a browse
allow $1 file_type - secure_file_type:file getattr;
dontaudit $1 dev_fs:dir_file_class_set getattr;
dontaudit $1 sysadmfile:file getattr;
dontaudit $1 sysadmfile:dir read;
')dnl end file_browse_domain

Added to base_user_domain, mozilla and mplayer.
Also added secure_file_type attribute, to shadow_t, kerberos_keytab_t, 
and cert_t.

I will submit a policy patch later.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
