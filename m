Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9GK2bPn021165
	for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2008 16:02:37 -0400
Received: from el-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9GK2bab005845
	for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2008 20:02:37 GMT
Received: by el-out-1112.google.com with SMTP id j27so61522elf.21
        for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2008 13:02:36 -0700 (PDT)
Message-ID: <cadfc0e40810161302m18dd3c0er54ee77c598cdc902@mail.gmail.com>
Date: Thu, 16 Oct 2008 15:02:36 -0500
From: "Xavier Toth" <txtoth@gmail.com>
To: "Andy Warner" <warner@rubix.com>
Subject: Re: adding objects classes and permissions to policy
Cc: selinux@tycho.nsa.gov
In-Reply-To: <48F798BB.6070602@rubix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <48F798BB.6070602@rubix.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Oct 16, 2008 at 2:40 PM, Andy Warner <warner@rubix.com> wrote:
>
> When adding new object classes and permissions to SELinux policy is it
> necessary to re-create flask.h and av_permissions.h header files so that a
> user-space object manager can access the associated defines? If so, would
> someone give me some pointers as to how these are generated?
>
> Thanks,
>
> Andy
>
This might help:
http://selinuxproject.org/page/Adding_New_Permissions

Ted

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
