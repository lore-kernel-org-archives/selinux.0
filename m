Subject: Re: Latest patches
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Jim Carter <jwcart2@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <423253FB.6090602@redhat.com>
References: <423253FB.6090602@redhat.com>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 08:25:02 -0500
Message-Id: <1110893102.25947.7.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-03-11 at 21:29 -0500, Daniel J Walsh wrote:
> Fixed to Makefile to better handle local.users

Why is system.users a dependency of $(FCPATH) while local.users is a
dependency of install?

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
