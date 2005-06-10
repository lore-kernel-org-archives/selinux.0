Subject: Re: Restorecon script
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Ivan Gyurdiev <gyurdiev@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
   SELinux <selinux@tycho.nsa.gov>, selinux-dev@tresys.com
In-Reply-To: <1118419542.366.8.camel@localhost>
References: <1118328119.29360.4.camel@dhcp83-8.boston.redhat.com>
	 <42A8F6C1.20106@tresys.com>
	 <1118370767.30464.16.camel@localhost.localdomain>
	 <1118419542.366.8.camel@localhost>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 12:11:11 -0400
Message-Id: <1118419871.3774.128.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-06-10 at 12:05 -0400, Joshua Brindle wrote:
> scripts that install stuff to skel maybe should be responsible for
> adding them to user dirs and labeling properly. This would be a trusted
> app (rpm or whatever) instead of a user shell script

You have to be careful in that case, as that trusted app becomes an
obvious target for attack and it is acting on paths into user-writable
directories.  One benefit of running it in the user's context (via the
shell script or when the app is first run by the user and initially
creates these files) is that the relabeling can be confined to the
user's types and there is no risk of misuse of privilege.
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
