Date: Fri, 24 Jul 2009 18:13:21 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
cc: sds@tycho.nsa.gov, Greg KH <greg@kroah.com>, casey@schaufler-ca.com,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: [PATCH] Security/sysfs: Enable security xattrs to be set on
 sysfs files, directories, and symlinks.
In-Reply-To: <1248195700.10726.28.camel@localhost>
Message-ID: <alpine.LRH.2.00.0907241810490.32272@tundra.namei.org>
References: <1247665721-2619-1-git-send-email-dpquigl@tycho.nsa.gov>  <1248194067.10726.22.camel@localhost> <1248195700.10726.28.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 21 Jul 2009, David P. Quigley wrote:

> Looking more closely at the problem I was mistaken. I was concerned with
> the dereferenceing of the dentry in the first line of the getxattr
> function but it seems that a precondition for us getting that far is
> that we will always have a valid dentry at that point. I'd appreciate it
> if the people whose code the patch touches can review the patch again
> and either NAK with more comments or sign off on it.

Please repost them with a version number so we know exactly which patches 
we're looking at.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
