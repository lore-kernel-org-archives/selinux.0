Subject: Re: security files - why not sysadmfile
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1109618857.17982.1.camel@cobra.ivg2.net>
References: <1109440349.11452.7.camel@cobra.ivg2.net>
	 <1109617986.28470.41.camel@moss-spartans.epoch.ncsc.mil>
	 <1109618857.17982.1.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Mon, 28 Feb 2005 14:20:19 -0500
Message-Id: <1109618419.28470.49.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-02-28 at 14:27 -0500, Ivan Gyurdiev wrote:
> ...what's stopping malicious code ran as sysadm from turning off
> selinux, then doing whatever it wants?

That is another example of where we want permissions migrated from
sysadm_t to specific program domains, where said programs are further
expected to use a trusted path mechanism to verify intent with the user
to avoid malicious invocation.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
