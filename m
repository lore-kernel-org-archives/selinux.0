Subject: Re: RFC Kernel interface to conditional policy
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: SELinux List <SELinux@tycho.nsa.gov>, James Morris <jmorris@redhat.com>
In-Reply-To: <1070484482.3774.54.camel@colossus.columbia.tresys.com>
References: <1070484482.3774.54.camel@colossus.columbia.tresys.com>
Content-Type: text/plain
Message-Id: <1070566110.17837.66.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 04 Dec 2003 14:28:30 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-12-03 at 15:48, Karl MacMillan wrote:
> 2) Extend the selinux filesystem. This wouldn't allow fine-grained
> labeling and would pollute the policy-neutral security server interface
> with type enforcement policy specific functionality.

BTW, I don't think it would be difficult to provide full genfs_contexts
support for selinuxfs, so that isn't a major obstacle IMHO.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
