Subject: Re: Desktop apps interoperability
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, selinux@tycho.nsa.gov,
   fedora-selinux-list@redhat.com
In-Reply-To: <20050328182714.GG3430@lkcl.net>
References: <1111985855.1514.70.camel@cobra.ivg2.net>
	 <20050328100449.GC3430@lkcl.net>
	 <1112016992.2914.19.camel@moss-spartans.epoch.ncsc.mil>
	 <20050328182714.GG3430@lkcl.net>
Content-Type: text/plain
Date: Mon, 28 Mar 2005 13:23:39 -0500
Message-Id: <1112034219.2914.117.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-03-28 at 19:27 +0100, Luke Kenneth Casson Leighton wrote:
>  ... question: in what ways do you ensure that a security-aware
>  compromised program is only allowed to create certain filetypes?

In the same manner as with a security-unaware program; the domain must
be allowed create permission to the file type via an allow rule.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
