Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o6B5D447024892
	for <selinux@tycho.nsa.gov>; Sun, 11 Jul 2010 01:13:06 -0400
Received: from smtp106.prem.mail.sp1.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id o6B5C053004324
	for <selinux@tycho.nsa.gov>; Sun, 11 Jul 2010 05:12:00 GMT
Message-ID: <4C3952D6.7040608@schaufler-ca.com>
Date: Sat, 10 Jul 2010 22:12:54 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Kyle Moffett <kyle@moffetthome.net>
CC: "David P. Quigley" <dpquigl@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>,
        "J. Bruce Fields" <bfields@fieldses.org>, hch@infradead.org,
        viro@zeniv.linux.org.uk, sds@tycho.nsa.gov, matthew.dodd@sparta.com,
        trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 06/10] NFSv4: Add label recommended attribute and NFSv4
 	flags
References: <1278513086-23964-1-git-send-email-dpquigl@tycho.nsa.gov> 	<1278513086-23964-7-git-send-email-dpquigl@tycho.nsa.gov> 	<20100707170058.GD28815@fieldses.org> <alpine.LRH.2.00.1007080928180.14102@tundra.namei.org> 	<1278596363.2494.194.camel@moss-terrapins.epoch.ncsc.mil> 	<alpine.LRH.2.00.1007090834190.23354@tundra.namei.org> <1278684348.2494.223.camel@moss-terrapins.epoch.ncsc.mil> <AANLkTinUO-xqvQQINTzKLcXnljq-RaN5X6ulEAqvuf0d@mail.gmail.com>
In-Reply-To: <AANLkTinUO-xqvQQINTzKLcXnljq-RaN5X6ulEAqvuf0d@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Kyle Moffett wrote:
> ...
> Even in local filesystems like ext3 we prefer to turn labels into
> numbers, store the number with each inode, and then keep the labels
> indexed in a separate datastructure.
>   

I don't know what system you're talking about, but that notion
was pretty well dispelled in the late 1980's, after the SystemV/MLS
and SecureWare examples.

> Cheers,
> Kyle Moffett
>
>
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
