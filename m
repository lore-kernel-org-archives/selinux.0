Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j11DI853015028
	for <selinux@tycho.nsa.gov>; Tue, 1 Feb 2005 08:18:08 -0500 (EST)
Subject: Re: File Browsing apps and getattr
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: ivg2@cornell.edu
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1107263308.6722.5.camel@cobra.ivg2.net>
References: <1107210369.1928.5.camel@cobra.ivg2.net>
	 <1107259894.26936.27.camel@moss-spartans.epoch.ncsc.mil>
	 <1107263308.6722.5.camel@cobra.ivg2.net>
Content-Type: text/plain
Message-Id: <1107263499.26936.50.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 01 Feb 2005 08:11:39 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-02-01 at 08:08, Ivan Gyurdiev wrote:
> Why? I don't see why it's necessary to get all those denials,
> and why ls doesn't show me the file properties for restricted types. 
> It seems reasonable to me that if you can search the parent directory
> you should be permitted to stat the files in it.
> 
> Even the manpage of stat() says so:
> 
> "These  functions  return information about the specified file.  You do
> not need any access rights to the file to get this information but you
> need search rights to all directories named in the path leading to the
> file."

Yes, that is in the absence of mandatory access control.  Properties of
the file should be protected in accordance with the security label of
the file, not the parent directory.  The name is part of the directory
state, but the stat(2) information is part of the inode state.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
