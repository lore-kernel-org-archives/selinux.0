Subject: Re: is it safe to use ext4 for SELinux
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "Justin P. Mattock" <justinmattock@gmail.com>,
        SE-Linux <selinux@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1248958936.11627.122.camel@moss-pluto.epoch.ncsc.mil>
References: <4A7083DB.4000003@gmail.com>
	 <1248958936.11627.122.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 30 Jul 2009 09:06:42 -0400
Message-Id: <1248959202.2597.68.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-07-30 at 09:02 -0400, Stephen Smalley wrote:
> On Wed, 2009-07-29 at 10:16 -0700, Justin P. Mattock wrote:
> > I've just downloaded the fedora 11 livecd and am installing it on an
> > imac. during the partition scheme should I use ext4,
> > or stick with ext3 for SELinux to function properly?
> 

> As to whether or not they all truly work, I don't know.
> I have used ext4 though without any selinux problems, and btrfs has been
> reported to work as well.

If you have problems with ext3, ext4, gfs2, or btrfs please file a
bugzilla and it will be a high priority for us to fix.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
