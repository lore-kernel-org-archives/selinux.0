Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3HHKG8N010419
	for <selinux@tycho.nsa.gov>; Thu, 17 Apr 2008 13:20:16 -0400
Received: from fg-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m3HHKF88014403
	for <selinux@tycho.nsa.gov>; Thu, 17 Apr 2008 17:20:15 GMT
Received: by fg-out-1718.google.com with SMTP id 16so109007fgg.40
        for <selinux@tycho.nsa.gov>; Thu, 17 Apr 2008 10:19:59 -0700 (PDT)
Message-ID: <cadfc0e40804170822n2ff34af1lcc92aa2c0a1cfff2@mail.gmail.com>
Date: Thu, 17 Apr 2008 10:22:51 -0500
From: "Xavier Toth" <txtoth@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>, "SE Linux" <selinux@tycho.nsa.gov>
Subject: Re: Fwd: adding a new security class
In-Reply-To: <1208442613.18883.386.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <cadfc0e40804161540u2c8796dcr99f67dc7c1aba33d@mail.gmail.com>
	 <48073FC6.6040908@redhat.com>
	 <cadfc0e40804170600g610fb3fdy2f7f416d4d7849ff@mail.gmail.com>
	 <1208438080.18883.361.camel@moss-spartans.epoch.ncsc.mil>
	 <cadfc0e40804170720q56eb623bn22dc7b7af31f671c@mail.gmail.com>
	 <1208442613.18883.386.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I appended the class declaration to the security_classes files.

I have installed the new policy and libselinux. However now when
trying to use this new class in a te file the build fails with an
'unknown class' error. Do I need to rebuild any other packages before
I can use this class? I tried rebuilding checkpolicy but that didn't
help.

On Thu, Apr 17, 2008 at 9:30 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
>  On Thu, 2008-04-17 at 09:20 -0500, Xavier Toth wrote:
>  > If the new security class is a userspace object manager related class
>  > do I still need to rebuild the kernel?
>
>  No.  You should find that the regenerated kernel headers are no
>  different, as they no longer include userspace classes (if annotated as
>  such in the security_classes file).
>
>  I assume though that you are adding your new class to the end of the
>  security_classes list.  Inserting a class before an existing one can
>  perturb the values of the existing classes, which isn't a good idea
>  (forbidden for kernel classes and any userspace object managers that use
>  the old libselinux API; permissible for new userspace object classes
>  when they use the dynamic class/permission discovery support but can
>  still break running applications until we have support for remapping
>  upon reload there).
>
>  --
>
>
> Stephen Smalley
>  National Security Agency
>
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
