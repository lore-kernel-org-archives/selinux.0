Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n6OEt3U4017202
	for <selinux@tycho.nsa.gov>; Fri, 24 Jul 2009 10:55:03 -0400
Received: from smtp104.prem.mail.sp1.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id n6OEscPe019232
	for <selinux@tycho.nsa.gov>; Fri, 24 Jul 2009 14:54:38 GMT
Message-ID: <4A69CB26.1070801@schaufler-ca.com>
Date: Fri, 24 Jul 2009 07:54:30 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
CC: James Morris <jmorris@namei.org>, sds@tycho.nsa.gov,
        Greg KH <greg@kroah.com>, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH] Security/sysfs: Enable security xattrs to be set on sysfs
 files, directories, and symlinks.
References: <1247665721-2619-1-git-send-email-dpquigl@tycho.nsa.gov>	 <1248194067.10726.22.camel@localhost> <1248195700.10726.28.camel@localhost>	 <alpine.LRH.2.00.0907241810490.32272@tundra.namei.org> <1248446041.2421.74.camel@localhost>
In-Reply-To: <1248446041.2421.74.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

David P. Quigley wrote:
> On Fri, 2009-07-24 at 18:13 +1000, James Morris wrote:
>   
>> On Tue, 21 Jul 2009, David P. Quigley wrote:
>>
>>     
>>> Looking more closely at the problem I was mistaken. I was concerned with
>>> the dereferenceing of the dentry in the first line of the getxattr
>>> function but it seems that a precondition for us getting that far is
>>> that we will always have a valid dentry at that point. I'd appreciate it
>>> if the people whose code the patch touches can review the patch again
>>> and either NAK with more comments or sign off on it.
>>>       
>> Please repost them with a version number so we know exactly which patches 
>> we're looking at.
>>
>>
>>     
>
> Casey is taking a shot at implementing generic xattr support for in
> memory file systems.I told him I'd wait to see the initial cut of his
> patch before going further with this.
>
>   

Work is under way. I hope to be done in a few days. No big time chunks
available unfortunately.

> Dave
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>   

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
