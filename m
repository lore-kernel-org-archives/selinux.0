MIME-Version: 1.0
In-Reply-To: <52f64b13-c53f-9f0a-5e53-a262353ca49c@debian.org>
References: <CAJfZ7=kyusEMDqACeTjJXaUWyZ0ATLi76hv2jYRHDV=SvUauUQ@mail.gmail.com>
 <b06d1099-0b11-2b36-b3c1-6200795076ae@tycho.nsa.gov>
 <e595ebf5-e2a5-64cf-13d5-44a47185de71@tycho.nsa.gov>
 <61bbb7c9-1b98-b1b7-ee0b-73a4dd43655b@debian.org>
 <bdf13777-4c4c-980a-3942-a1fc5ce1f5eb@debian.org>
 <ff9efc5e-bb98-5d7b-aabc-0a968d1db42b@tycho.nsa.gov>
 <52f64b13-c53f-9f0a-5e53-a262353ca49c@debian.org>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Sat, 14 Jul 2018 17:49:19 +0200
Message-ID: <CAJfZ7=nCUW9RcQubw_HcSj-v2=X-ZiF=fXi_QnpoceWRo8835w@mail.gmail.com>
To: Laurent Bigonville <bigon@debian.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: libsemanage getpwent and nss-systemd incompability
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Jul 13, 2018 at 6:59 PM, Laurent Bigonville <bigon@debian.org> wrote:
>
> Le 13/07/18 à 16:37, Stephen Smalley a écrit :
>
>> On 07/13/2018 10:26 AM, Laurent Bigonville wrote:
>>>
>>> Le 13/07/18 à 16:19, Laurent Bigonville a écrit :
>>>>
>>>> Le 10/07/18 à 17:58, Stephen Smalley a écrit :
>>>>>
>>>>> On 07/10/2018 11:40 AM, Stephen Smalley wrote:
>>>>>>
>>>>>> On 07/09/2018 04:20 PM, Nicolas Iooss wrote:
>>>>>>>
>>>>>>> Hello,
>>>>>>>
>>>>>>> While testing a systemd update on Arch Linux, I encountered the
>>>>>>> following message (in a Vagrant virtual machine):
>>>>>>>
>>>>>>> # semanage fcontext -m -s sysadm_u -t user_home_t '/vagrant(/.*)?'
>>>>>>> libsemanage.get_home_dirs: Error while fetching users. Returning list so far.
>>>>>>>
>>>>>>> A quick debugging of get_home_dirs() in
>>>>>>> libsemanage/src/genhomedircon.c shows that the loop "while ((pwbuf =
>>>>>>> getpwent()) != NULL)" stops with pwbuf=NULL and errno=2 (ENOENT). My
>>>>>>> /etc/nsswitch.conf contains:
>>>>>>>
>>>>>>> passwd: files mymachines systemd
>>>>>>>
>>>>>>> If I remove "systemd" from this line, the error disappears. Therefore
>>>>>>> it seems that systemd's NSS module returns a ENOENT error when
>>>>>>> getpwent() is called. I have not found any clue in systemd's code [1]
>>>>>>> about such an error and I have not got much time to debug this issue.
>>>>>>> Does this occurs for someone else (using Fedora for example)?
>>>>>>
>>>>>> Fedora ships with usepasswd=False in semanage.conf, so we'll never reach that code in a default configuration.
>>>>>> Fedora nsswitch.conf has following for passwd:
>>>>>> passwd:        files sss systemd
>>>>>>
>>>>>> Removing usepasswd=False from semanage.conf, I see the same behavior with libsemanage 2.8, systemd 239, and glibc 2.27 on Fedora and it did not occur with systemd 238.  systemd v239 does introduce support into nss-systemd for looking up dynamic users, so this seems to be the cause. Not sure yet whether this represents a bug in libsemanage or systemd, but it appears to just be a warning and not fatal to operation.
>>>>>
>>>>> I'm inclined to think that this is a bug in systemd.  The man page for getpwent() says nothing about setting errno to ENOENT upon reaching the end of the passwd database; it should just return NULL w/o setting errno AFAICT.
>>>>
>>>> I see the same warning in debian.
>>>>
>>>> If I'm reading https://www.gnu.org/software/libc/manual/html_node/NSS-Modules-Interface.html well this is actually valid to set errno=ENOENT and return NSS_STATUS_NOTFOUND if "The requested entry is not available.", so that should be OK?
>>>
>>> There are more info at https://www.gnu.org/software/libc/manual/html_node/NSS-Module-Function-Internals.html as well: "The function shall return NSS_STATUS_SUCCESS as long as there are more entries. When the last entry was read it should return NSS_STATUS_NOTFOUND. When the buffer given as an argument is too small for the data to be returned NSS_STATUS_TRYAGAIN should be returned. When the service was not formerly initialized by a call to _nss_DATABASE_setdbent all return values allowed for this function can also be returned here."
>>>
>>> But indeed, it's not that clear if you should set errno or not if you reach the last entry
>>
>> I'm not averse to a patch for libsemanage to ignore ENOENT from getpwent(), but I think it is a bug in either systemd (i.e. it shouldn't be setting ENOENT) or glibc (it should suppress it) given that it is not documented as a possible errno value in getpwent(3).  If we ignore it, we likely ought to clear errno to avoid incorrect propagation of an ENOENT errno to later code.  But someone likely ought to open a bug with either systemd or glibc maintainers regardless.  Should be easy to create a trivial test case w/o involving libsemanage, just some code that calls getpwent() until it returns NULL and then tests the errno value, and show that it changes between systemd v238 and systemd v239.
>
> FTR I've opened https://sourceware.org/bugzilla/show_bug.cgi?id=23410 as the errno is not documented, let's see what they will say

Thanks. I have been quite busy this week, and now that I have some
time, I took a look at systemd's code. It appears setting errno to
ENOENT is done there:
https://github.com/systemd/systemd/blob/v239/src/nss-systemd/nss-systemd.c#L781
, so at least it is not something else leaking errno to NSSwitch's
internals. I have added this information to glibc's ticket and will
wait for the feedback from glibc's developers.

Nicolas
