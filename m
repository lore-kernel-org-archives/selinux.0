Subject: Re: Still getting random execute permissions on shared libraries.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: James Morris <jmorris@redhat.com>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <41A4B35B.3050902@redhat.com>
References: <41A3EC21.1090200@comcast.net>
	 <1101303008.22014.47.camel@moss-spartans.epoch.ncsc.mil>
	 <41A4B35B.3050902@redhat.com>
Content-Type: text/plain
Message-Id: <1101313367.22014.179.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 24 Nov 2004 11:22:47 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-11-24 at 11:14, Daniel J Walsh wrote:
> This is using java runtime environment so I don't believe there is any 
> execing going on,  So my only
> choice would be to allow mozilla these privs.  I added the following 
> changes to make it work.

I think that read_implies_exec is only enabled upon exec of a binary
(from load_elf_binary).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
