Subject: RE: Restorecon script
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   "'Joshua Brindle'" <jbrindle@tresys.com>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, "'SELinux'" <selinux@tycho.nsa.gov>,
   selinux-dev@tresys.com
In-Reply-To: <1118425292.3774.137.camel@moss-spartans.epoch.ncsc.mil>
References: <200506101744.j5AHi55F008714@gotham.columbia.tresys.com>
	 <1118425292.3774.137.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 14:01:43 -0400
Message-Id: <1118426503.3720.17.camel@dhcp83-8.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> These files are under the user's control anyway; the purpose of labeling
> them with their own type is to allow particular user apps to access them
> without allowing those apps to access all of the user's files.

By the way, I have addressed the need for { relabelto relabelfrom } on
various types, by adding those rules for each individual domain
that we're currently relabeling in the script.

An alternative is to add { relabelto relabelfrom } on all of
$1_file_type, but I wasn't sure whether or not that's something
we want to do.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
