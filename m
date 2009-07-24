Subject: Re: [PATCH] Security/sysfs: Enable security xattrs to be set on
 sysfs files, directories, and symlinks.
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: sds@tycho.nsa.gov, Greg KH <greg@kroah.com>, casey@schaufler-ca.com,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
In-Reply-To: <alpine.LRH.2.00.0907241810490.32272@tundra.namei.org>
References: <1247665721-2619-1-git-send-email-dpquigl@tycho.nsa.gov>
	 <1248194067.10726.22.camel@localhost> <1248195700.10726.28.camel@localhost>
	 <alpine.LRH.2.00.0907241810490.32272@tundra.namei.org>
Content-Type: text/plain
Date: Fri, 24 Jul 2009 10:34:01 -0400
Message-Id: <1248446041.2421.74.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-07-24 at 18:13 +1000, James Morris wrote:
> On Tue, 21 Jul 2009, David P. Quigley wrote:
> 
> > Looking more closely at the problem I was mistaken. I was concerned with
> > the dereferenceing of the dentry in the first line of the getxattr
> > function but it seems that a precondition for us getting that far is
> > that we will always have a valid dentry at that point. I'd appreciate it
> > if the people whose code the patch touches can review the patch again
> > and either NAK with more comments or sign off on it.
> 
> Please repost them with a version number so we know exactly which patches 
> we're looking at.
> 
> 

Casey is taking a shot at implementing generic xattr support for in
memory file systems.I told him I'd wait to see the initial cut of his
patch before going further with this.

Dave


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
