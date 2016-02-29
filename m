Subject: Re: should setfscreatecon be able to override auto type transition
 rules?
To: Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov
References: <56D4987B.2030001@gmail.com> <56D4A8A9.40704@tycho.nsa.gov>
 <56D4AA85.3050405@gmail.com> <56D4AC1C.7000102@gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <56D4B2B5.3000909@tycho.nsa.gov>
Date: Mon, 29 Feb 2016 16:05:57 -0500
MIME-Version: 1.0
In-Reply-To: <56D4AC1C.7000102@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/29/2016 03:37 PM, Dominick Grift wrote:
> On 02/29/2016 09:31 PM, Dominick Grift wrote:
>> On 02/29/2016 09:23 PM, Stephen Smalley wrote:
>>> On 02/29/2016 02:14 PM, Dominick Grift wrote:
>>>> I encountered this today and it got me thinking. Should this
>>>> be happenin g?
>
>>> Yes.
>
>>>> I would think that a auto type transition rule should always
>>>> take precedence, and that setfscreatecon should only be
>>>> honored if there is nothing in policy overriding it.
>
>>> No.  The type_transition rules are merely defaults to provide
>>> compatibility with a non-security-aware userspace.
>>> setfscreatecon() intentionally permits overriding type
>>> transition or default inheritance rules.  Of course, one can only
>>> use setfscreatecon() if one has the requisite permissions,
>>> including setfscreate to even use it at all, plus create to the
>>> specified type.  However, in Android, the usage permissions like
>>> setfscreate are tightly locked down; only a few domains are
>>> allowed them.
>
>
>> So if one does not allow the requisite permissions for the
>> setfscreatecon, should it then "fall" back to the auto type
>> transition?
>
>> this is one of the instances:
>
>> AVC avc:  denied  { create } for  pid=31307 comm="useradd"
>> name="subuid-"
>> scontext=wheel.id:sysadm.role:useradd.subj:s0-s0:c0.c1023
>> tcontext=sys.id:sys.role:config.config_file:s0 tclass=file
>> permissive=1
>
>> There was a rule:
>
>> type_transition useradd.subj config.config_file:file
>> passwords.file;
>
>> But there was no file context specified for it.
>
>> Thus useradd wanted to create /etc/subuid- with type
>> config.config_file even though there was a type transition.
>
>> In enforcing mode, would it have created /etc/subuid- with type
>> passwords.file? Since it was not allowed to create /etc/suduid-
>> with type config.config_file?
>
>
> I think I know the answer. No it would not fall back.

Correct; if an application used setfscreatecon() and it is not allowed 
to create a file with that type, then the file creation system call 
(i.e. open, mkdir, symlink, mknod, ...) will fail with errno EACCES.

>
> I can understand that setfscreate overrides default inheritance, but I
> personally think that auto type transition should take precedence.
>
> In gnu/linux even coreutils request setfscreatecon. Sometimes that
> makes perfect sense but sometimes you want to be able to override that.
