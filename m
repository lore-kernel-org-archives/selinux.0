Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j12DLR53021968
	for <selinux@tycho.nsa.gov>; Wed, 2 Feb 2005 08:21:27 -0500 (EST)
Subject: Re: File Browsing apps and getattr
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: ivg2@cornell.edu
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1107350380.7449.2.camel@cobra.ivg2.net>
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
	 <1107350380.7449.2.camel@cobra.ivg2.net>
Content-Type: text/plain
Message-Id: <1107350096.890.78.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 02 Feb 2005 08:14:56 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-02-02 at 08:19, Ivan Gyurdiev wrote:
> It was a general question, regardless of the specific type. 
> I thought perhaps shadow_t would be a security type, and would produce
> denials when I do ls -l /etc. What would you consider a
> security type?

Yes, shadow_t would fall into that class.  So at that point you might
dontaudit attempts to getattr it from user domains, while leaving them
audited for the daemon domains.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
