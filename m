Subject: Re: libselinux patch to add file_context.homedirs and remove
	potential memory and fd leaks.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <420BD7E6.4000208@redhat.com>
References: <420BD7E6.4000208@redhat.com>
Content-Type: text/plain
Message-Id: <1108656384.24494.67.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 17 Feb 2005 11:06:24 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks, merged as of libselinux 1.21.10.

Note that we still haven't merged the new genhomedircon yet, due to the
compatibility issue.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
