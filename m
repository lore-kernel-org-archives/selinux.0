Subject: Re: libselinux does not compile on ia64
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Janak Desai <janak@us.ibm.com>
Cc: Manoj Srivastava <manoj.srivastava@stdc.com>,
   Janak Desai <jdesai@us.ibm.com>, selinux@tycho.nsa.gov
In-Reply-To: <42F75828.1090700@us.ibm.com>
References: <877jez41lm.fsf@glaurung.internal.golden-gryphon.com>
	 <1123504573.13654.113.camel@moss-spartans.epoch.ncsc.mil>
	 <42F75828.1090700@us.ibm.com>
Content-Type: text/plain
Date: Thu, 11 Aug 2005 11:01:41 -0400
Message-Id: <1123772501.7810.35.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-08-08 at 09:03 -0400, Janak Desai wrote:
> Yup. That's correct. We can drop setupns() from both utils/setupns.c and
> src/setupns.c. Functionality provided by setupns() has migrated to the
> pam_namespace patch.

Ok, setupns has been dropped from libselinux as of 1.25.1.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
