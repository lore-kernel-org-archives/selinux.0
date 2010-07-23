MIME-Version: 1.0
In-Reply-To: <1279909967.8180.43.camel@moss-terrapins.epoch.ncsc.mil>
References: <AANLkTinTLamY+tesxS3W7ocnQCmEDCFhGT973jttYk_z@mail.gmail.com>
	<1279909967.8180.43.camel@moss-terrapins.epoch.ncsc.mil>
Date: Fri, 23 Jul 2010 13:57:13 -0500
Message-ID: <AANLkTiniFb1LjDJQRoc7zOVgD0FVXi=gBaxjusP36RZ3@mail.gmail.com>
Subject: Re: fuse and selinux don't seem to work well together
From: Xavier Toth <txtoth@gmail.com>
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jul 23, 2010 at 1:32 PM, David P. Quigley <dpquigl@tycho.nsa.gov> wrote:
> On Fri, 2010-07-23 at 12:14 -0500, Xavier Toth wrote:
>> I'm looking at building a fuse filesystem for polyinstantiated
>> directories which could be used as a alternative to pam_namespace.
>> I've noticed that my filesystem is never queried for the xattr
>> security.selinux and that the file contexts are defaulting to a fuse
>> file type. I've seen some list posting from 2004 related to this
>> subject but not much else. Is this a bug or a feature?
>>
>> Ted
>>
>> --
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>> the words "unsubscribe selinux" without quotes as the message.
>
> After a brief conversation with Steve more information has come up with
> respect to this. A while back Eric Paris had developed a patch to
> dynamically probe the file system's getxattr handler to determine if we
> can use xattr support on the file system for SELinux labels. The major
> stumbling block that Eric ran into was that he was experiencing
> deadlocks when using the code. Apparently there were and still might be
> locking issues between the fuse and SELinux code. I'm sure you could dig
> up Eric's old patch and try to forward port it to see if those locking
> issues still exist.
>
> Dave
>
>

Thanks I'll try and run down the patch and contact Eric. I'll report
back if I can get this to work.

Ted

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
