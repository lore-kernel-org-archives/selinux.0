From: Stephen Smalley <sds@tycho.nsa.gov>
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux <selinux@tycho.nsa.gov>
References: <CAJfZ7=kyusEMDqACeTjJXaUWyZ0ATLi76hv2jYRHDV=SvUauUQ@mail.gmail.com>
 <b06d1099-0b11-2b36-b3c1-6200795076ae@tycho.nsa.gov>
Message-ID: <e595ebf5-e2a5-64cf-13d5-44a47185de71@tycho.nsa.gov>
Date: Tue, 10 Jul 2018 11:58:59 -0400
MIME-Version: 1.0
In-Reply-To: <b06d1099-0b11-2b36-b3c1-6200795076ae@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Subject: Re: libsemanage getpwent and nss-systemd incompability
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/10/2018 11:40 AM, Stephen Smalley wrote:
> On 07/09/2018 04:20 PM, Nicolas Iooss wrote:
>> Hello,
>>
>> While testing a systemd update on Arch Linux, I encountered the
>> following message (in a Vagrant virtual machine):
>>
>> # semanage fcontext -m -s sysadm_u -t user_home_t '/vagrant(/.*)?'
>> libsemanage.get_home_dirs: Error while fetching users.  Returning list so far.
>>
>> A quick debugging of get_home_dirs() in
>> libsemanage/src/genhomedircon.c shows that the loop "while ((pwbuf =
>> getpwent()) != NULL)" stops with pwbuf=NULL and errno=2 (ENOENT). My
>> /etc/nsswitch.conf contains:
>>
>> passwd: files mymachines systemd
>>
>> If I remove "systemd" from this line, the error disappears. Therefore
>> it seems that systemd's NSS module returns a ENOENT error when
>> getpwent() is called. I have not found any clue in systemd's code [1]
>> about such an error and I have not got much time to debug this issue.
>> Does this occurs for someone else (using Fedora for example)?
> 
> Fedora ships with usepasswd=False in semanage.conf, so we'll never reach that code in a default configuration.
> Fedora nsswitch.conf has following for passwd:
> passwd:		files sss systemd
> 
> Removing usepasswd=False from semanage.conf, I see the same behavior with libsemanage 2.8, systemd 239, and glibc 2.27 on Fedora and it did not occur with systemd 238.  systemd v239 does introduce support into nss-systemd for looking up dynamic users, so this seems to be the cause. Not sure yet whether this represents a bug in libsemanage or systemd, but it appears to just be a warning and not fatal to operation.

I'm inclined to think that this is a bug in systemd.  The man page for getpwent() says nothing about setting errno to ENOENT upon reaching the end of the passwd database; it should just return NULL w/o setting errno AFAICT.

> 
>>
>> For information, this issue occurs with SELinux release 2.8 (and git
>> master branch), systemd 239.0 and glibc 2.27, on a system with SELinux
>> in permissive mode.
>>
>> Best,
>> Nicolas
>>
>> [1] https://github.com/systemd/systemd/blob/master/src/nss-systemd/nss-systemd.c
