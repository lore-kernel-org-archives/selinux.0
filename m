Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w6DEQeYk020519
 for <selinux@tycho.nsa.gov>; Fri, 13 Jul 2018 10:26:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by USFBF3ID05.oob.disa.mil (Postfix) with SMTP id 41Rw9B21r9z1b8V
 for <selinux@tycho.nsa.gov>; Fri, 13 Jul 2018 14:26:38 +0000 (UTC)
Received: from USFB19PA08.eemsg.mil (unknown [192.168.16.5])
 by USFBF3ID05.oob.disa.mil (Postfix) with ESMTP id 41Rw993T7Yz1b8M
 for <selinux@tycho.nsa.gov>; Fri, 13 Jul 2018 14:26:37 +0000 (UTC)
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id 016E81A527
 for <selinux@tycho.nsa.gov>; Fri, 13 Jul 2018 16:26:33 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id GM5AFbrkcW5g for <selinux@tycho.nsa.gov>;
 Fri, 13 Jul 2018 16:26:09 +0200 (CEST)
Received: from [10.40.0.115] (unknown [193.53.238.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id 859FF1A270
 for <selinux@tycho.nsa.gov>; Fri, 13 Jul 2018 16:26:09 +0200 (CEST)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
References: <CAJfZ7=kyusEMDqACeTjJXaUWyZ0ATLi76hv2jYRHDV=SvUauUQ@mail.gmail.com>
 <b06d1099-0b11-2b36-b3c1-6200795076ae@tycho.nsa.gov>
 <e595ebf5-e2a5-64cf-13d5-44a47185de71@tycho.nsa.gov>
 <61bbb7c9-1b98-b1b7-ee0b-73a4dd43655b@debian.org>
Message-ID: <bdf13777-4c4c-980a-3942-a1fc5ce1f5eb@debian.org>
Date: Fri, 13 Jul 2018 16:26:09 +0200
MIME-Version: 1.0
In-Reply-To: <61bbb7c9-1b98-b1b7-ee0b-73a4dd43655b@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: libsemanage getpwent and nss-systemd incompability
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Le 13/07/18 à 16:19, Laurent Bigonville a écrit :
> Le 10/07/18 à 17:58, Stephen Smalley a écrit :
>> On 07/10/2018 11:40 AM, Stephen Smalley wrote:
>>> On 07/09/2018 04:20 PM, Nicolas Iooss wrote:
>>>> Hello,
>>>>
>>>> While testing a systemd update on Arch Linux, I encountered the
>>>> following message (in a Vagrant virtual machine):
>>>>
>>>> # semanage fcontext -m -s sysadm_u -t user_home_t '/vagrant(/.*)?'
>>>> libsemanage.get_home_dirs: Error while fetching users. Returning 
>>>> list so far.
>>>>
>>>> A quick debugging of get_home_dirs() in
>>>> libsemanage/src/genhomedircon.c shows that the loop "while ((pwbuf =
>>>> getpwent()) != NULL)" stops with pwbuf=NULL and errno=2 (ENOENT). My
>>>> /etc/nsswitch.conf contains:
>>>>
>>>> passwd: files mymachines systemd
>>>>
>>>> If I remove "systemd" from this line, the error disappears. Therefore
>>>> it seems that systemd's NSS module returns a ENOENT error when
>>>> getpwent() is called. I have not found any clue in systemd's code [1]
>>>> about such an error and I have not got much time to debug this issue.
>>>> Does this occurs for someone else (using Fedora for example)?
>>> Fedora ships with usepasswd=False in semanage.conf, so we'll never 
>>> reach that code in a default configuration.
>>> Fedora nsswitch.conf has following for passwd:
>>> passwd:        files sss systemd
>>>
>>> Removing usepasswd=False from semanage.conf, I see the same behavior 
>>> with libsemanage 2.8, systemd 239, and glibc 2.27 on Fedora and it 
>>> did not occur with systemd 238.  systemd v239 does introduce support 
>>> into nss-systemd for looking up dynamic users, so this seems to be 
>>> the cause. Not sure yet whether this represents a bug in libsemanage 
>>> or systemd, but it appears to just be a warning and not fatal to 
>>> operation.
>> I'm inclined to think that this is a bug in systemd.  The man page 
>> for getpwent() says nothing about setting errno to ENOENT upon 
>> reaching the end of the passwd database; it should just return NULL 
>> w/o setting errno AFAICT.
>
> I see the same warning in debian.
>
> If I'm reading 
> https://www.gnu.org/software/libc/manual/html_node/NSS-Modules-Interface.html 
> well this is actually valid to set errno=ENOENT and return 
> NSS_STATUS_NOTFOUND if "The requested entry is not available.", so 
> that should be OK?

There are more info at 
https://www.gnu.org/software/libc/manual/html_node/NSS-Module-Function-Internals.html 
as well: "The function shall return NSS_STATUS_SUCCESS as long as there 
are more entries. When the last entry was read it should return 
NSS_STATUS_NOTFOUND. When the buffer given as an argument is too small 
for the data to be returned NSS_STATUS_TRYAGAIN should be returned. When 
the service was not formerly initialized by a call to 
_nss_DATABASE_setdbent all return values allowed for this function can 
also be returned here."

But indeed, it's not that clear if you should set errno or not if you 
reach the last entry
