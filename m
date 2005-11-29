Subject: Re: Patch to fix up sestatus, audit2allow and first version of
	semanage
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <438C68D6.4040505@redhat.com>
References: <438C68D6.4040505@redhat.com>
Content-Type: text/plain
Date: Tue, 29 Nov 2005 10:41:39 -0500
Message-Id: <1133278899.26593.120.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Should getsebool be likewise changed to use on/off rather than
active/inactive?  I definitely prefer on/off as it is clearer in meaning
and you can easily distinguish them (e.g. getsebool -a | grep on).
Does this require a change to system-config-securitylevel?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
