Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j14EGf53007450
	for <selinux@tycho.nsa.gov>; Fri, 4 Feb 2005 09:16:41 -0500 (EST)
Subject: Re: Latest diffs
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: ivg2@cornell.edu, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <42037FDC.9000908@redhat.com>
References: <1106940328.32737.120.camel@moss-spartans.epoch.ncsc.mil>
	 <41FA9717.2000609@redhat.com>
	 <1107283533.31281.8.camel@moss-lions.epoch.ncsc.mil>
	 <1107287300.26936.226.camel@moss-spartans.epoch.ncsc.mil>
	 <1107349736.890.72.camel@moss-spartans.epoch.ncsc.mil>
	 <1107350272.890.82.camel@moss-spartans.epoch.ncsc.mil>
	 <4200D68A.6030309@redhat.com> <1107478728.4065.3.camel@cobra.ivg2.net>
	 <42037FDC.9000908@redhat.com>
Content-Type: text/plain
Message-Id: <1107526206.8078.55.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 04 Feb 2005 09:10:06 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-02-04 at 08:59, Daniel J Walsh wrote:
> You need to set the boolean
> 
> setsebool -P allow_execmod 1
>  On fresh installs this will be in there. 
> 
> Why should we have the boolean if we know that X will require it always?

- It is only needed for certain drivers, e.g. nvidia, and not others (I
don't need it for my machine), and
- It represents a security risk to allow it, especially since X is
highly privileged.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
