Subject: Re: Multiple contexts
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux@tycho.nsa.gov
In-Reply-To: <20050110232312.GI6967@lkcl.net>
References: <1105390249.8093.21.camel@cobra.ivg2.net>
	 <20050110232312.GI6967@lkcl.net>
Content-Type: text/plain
Message-Id: <1105474191.20566.134.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 11 Jan 2005 15:09:51 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-01-10 at 18:23, Luke Kenneth Casson Leighton wrote:
>  i can only hazard a hazardous guess therefore that the more
>  "normal" ACL system [that we are used to seeing] was rejected
>  because it makes the formal proof methodology more difficult.

With ACLs, you have to traverse the entire filesystem state in order to:
1) determine what your policy truly is (and that policy can change
underneath you during your traversal),
2) apply any widespread changes in policy state.

Management and scalability nightmare.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
