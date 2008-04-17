Subject: Re: Fwd: adding a new security class
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Xavier Toth <txtoth@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <cadfc0e40804170720q56eb623bn22dc7b7af31f671c@mail.gmail.com>
References: <cadfc0e40804161540u2c8796dcr99f67dc7c1aba33d@mail.gmail.com>
	 <48073FC6.6040908@redhat.com>
	 <cadfc0e40804170600g610fb3fdy2f7f416d4d7849ff@mail.gmail.com>
	 <1208438080.18883.361.camel@moss-spartans.epoch.ncsc.mil>
	 <cadfc0e40804170720q56eb623bn22dc7b7af31f671c@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 17 Apr 2008 10:30:13 -0400
Message-Id: <1208442613.18883.386.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-04-17 at 09:20 -0500, Xavier Toth wrote:
> If the new security class is a userspace object manager related class
> do I still need to rebuild the kernel?

No.  You should find that the regenerated kernel headers are no
different, as they no longer include userspace classes (if annotated as
such in the security_classes file).

I assume though that you are adding your new class to the end of the
security_classes list.  Inserting a class before an existing one can
perturb the values of the existing classes, which isn't a good idea
(forbidden for kernel classes and any userspace object managers that use
the old libselinux API; permissible for new userspace object classes
when they use the dynamic class/permission discovery support but can
still break running applications until we have support for remapping
upon reload there).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
