Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4OIRhJt014457
	for <selinux@tycho.nsa.gov>; Sun, 24 May 2009 14:28:23 -0400
Received: from mail-ew0-f173.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n4OIRqAq021756
	for <selinux@tycho.nsa.gov>; Sun, 24 May 2009 18:27:53 GMT
Received: by ewy21 with SMTP id 21so1909579ewy.18
        for <selinux@tycho.nsa.gov>; Sun, 24 May 2009 11:27:35 -0700 (PDT)
Subject: Re: SELinux acl's options
From: Dominick Grift <domg472@gmail.com>
To: Justin Mattock <justinmattock@gmail.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <dd18b0c30905240931u49912081o88fc47ec1599187a@mail.gmail.com>
References: <dd18b0c30905240931u49912081o88fc47ec1599187a@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 24 May 2009 20:27:32 +0200
Message-Id: <1243189652.3697.12.camel@notebook2.grift.internal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2009-05-24 at 09:31 -0700, Justin Mattock wrote:
> I've been freaking out for a few weeks at looking
> at ls -Z and seeing a dot at the end of the permissions.
> (then after gogling I found)
> http://www.linux-archive.org/fedora-development/285498-dot-end-permissions-something-new.html
> 
> relieving me of thinking I have a hole in the ACL's.
> 
> Anyways how would one go about changing
> the "." to a "+" at the end of the permission?
> 

The dot in the end means there is also a SELinux context.
The plus in the end means there is also a ACL defined.

No dot and plus means only basic DAC permissions are defined.

I hope this clears things up for you:

[root@notebook2 /]# mkdir test
[root@notebook2 /]# ls -alZ / | grep test
drwxr-xr-x. root root dgrift:object_r:default_t:SystemLow test
[root@notebook2 /]# setfacl -m u:dgrift:r test
[root@notebook2 /]# ls -alZ / | grep test
drwxr-xr-x+ root root dgrift:object_r:default_t:SystemLow test
[root@notebook2 /]#


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
