Message-ID: <4c4ba1530812271726n306c7af1ha2830640cc6030a3@mail.gmail.com>
Date: Sat, 27 Dec 2008 17:26:11 -0800
From: "Tom London" <selinux@gmail.com>
To: Tim <timasyk@gmail.com>
Subject: Re: Alternative location of policy files
Cc: "Daniel J Walsh" <dwalsh@redhat.com>, "xing li" <lixing.1006@gmail.com>,
        SELinux@tycho.nsa.gov
In-Reply-To: <a5e2b64d0812271707u75def724i3a8f8b4d9e2d22ae@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <a5e2b64d0812232358u19f442dfwd27da7f0978a508c@mail.gmail.com>
	 <707f057d0812262321w4234ddabuc634f80a84cf5a9c@mail.gmail.com>
	 <707f057d0812262322r76bcc43at51406c66b98a7f2a@mail.gmail.com>
	 <49560DB5.1020500@redhat.com>
	 <a5e2b64d0812270418w4c359ff0w9c77edae341a6f6a@mail.gmail.com>
	 <49562001.9090900@redhat.com>
	 <a5e2b64d0812270455k5dfa14bfrc39d4f8dbbf5748a@mail.gmail.com>
	 <49563B84.30308@redhat.com>
	 <a5e2b64d0812271406i4c58305dx4b223e5bd5ddddbf@mail.gmail.com>
	 <a5e2b64d0812271707u75def724i3a8f8b4d9e2d22ae@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Dec 27, 2008 at 5:07 PM, Tim <timasyk@gmail.com> wrote:
> 2008/12/28 Tim <timasyk@gmail.com>:
>> 2008/12/27 Daniel J Walsh <dwalsh@redhat.com>:
>>> -----BEGIN PGP SIGNED MESSAGE-----
>>> Hash: SHA1
>>>
>>> Tim wrote:
>>>> 2008/12/27 Daniel J Walsh <dwalsh@redhat.com>:
>>>> Tim wrote:
>>>>>>> 2008/12/27 Daniel J Walsh <dwalsh@redhat.com>:
>>>>>>> xing li wrote:
>>>>>>>>>> 2008/12/27 xing li <lixing.1006@gmail.com>
>>>>>>>>>>
>>>>>>>>>>> It's work was rearly done in the "/sbin/init"  until the last step of
>>>>>>>>>>> system initialization, while the source
>>>>>>>>>>> of "/sbin/init" is included in the sysvinit. and it finally invoked
>>>>>>>>>>> "security_load_policy()" to load the binary
>>>>>>>>>>> policy "policy.XX" to the kernel structure policydb.
>>>>>>>>>>>
>>>>>>>>>>> and i have confused by the question:
>>>>>>>>>>> when and how the selinux label the all file system according
>>>>>>>>>>> to "file_contexts"?
>>>>>>>>>>> and i found the clue that when we "touch /.autorelabel",the system would
>>>>>>>>>>> invoke
>>>>>>>>>>> "fixfiles relabel" to relabel the file system. but i could't find the
>>>>>>>>>>> relevant source code.
>>>>>>>>>>> Maybt somebody has investigated that and could share infomation?
>>>>>>>>>>>
>>>>>>>>>>> 2008/12/27 Tim <timasyk@gmail.com>
>>>>>>>>>>>
>>>>>>>>>>> OK. I'm trying to trace Linux sources to find exact sequence of
>>>>>>>>>>>> function calls for loading  SELinux policy into Linux kernel at boot
>>>>>>>>>>>> time. And I've lost... to many calls to trace.
>>>>>>>>>>>>
>>>>>>>>>>>> Maybe somebody has that tracing already and can share information?
>>>>>>>>>>>>
>>>>>>>>>>>> Tim
>>>>>>>>>>>>
>>>>>>>>>>>> 2008/12/26 Justin P. Mattock <justinmattock@gmail.com>:
>>>>>>>>>>>>  > I think, one of the main jobs
>>>>>>>>>>>>> For libselinux is reading the
>>>>>>>>>>>>> Policy, from it specefied location
>>>>>>>>>>>>> And then mounting the selinuxfs.
>>>>>>>>>>>>> Or vise versa mounting selinuxfs,
>>>>>>>>>>>>> And then reading the policy. As
>>>>>>>>>>>>> For changing the location, not
>>>>>>>>>>>>> To sure what the code looks like,
>>>>>>>>>>>>> Maybe it's just a few liners to
>>>>>>>>>>>>> Do what you wanted.
>>>>>>>>>>>>>
>>>>>>>>>>>>> justin P. Mattock
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> On Dec 25, 2008, at 5:36 AM, Tim <timasyk@gmail.com> wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>>> 2008/12/25 Justin P. Mattock <justinmattock@gmail.com>:
>>>>>>>>>>>>>>> Justin P. Mattock wrote:
>>>>>>>>>>>>>>>> Paul Howarth wrote:
>>>>>>>>>>>>>>>>> Tim wrote:
>>>>>>>>>>>>>>>>>> Hello all,
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> I was wondering, how can I change default location of SELinux
>>>>>>>>>>>> policy
>>>>>>>>>>>>>>>>>> from /etc/selinux/_policyname_ to some other path?
>>>>>>>>>>>>>>>>>> What source codes should be modified for that?
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> The reason to do that are:
>>>>>>>>>>>>>>>>>> - I want to work with loadable policy modules --> that requires
>>>>>>>>>>>>>>>>>> /etc/selinux/_policyname_ directory to be writable.
>>>>>>>>>>>>>>>>>> - limitation of my filesystem having /etc directory (it is
>>>>>>>>>>>> read-only
>>>>>>>>>>>>>>>>>> filesystem)
>>>>>>>>>>>>>>>>>> - unfortunately, I can not mount /etc into some other writable
>>>>>>>>>>>>>>>>>> filesystem
>>>>>>>>>>>>>>>>> Perhaps you could mount /etc/selinux/_policyname_ rather than /etc
>>>>>>>>>>>> from
>>>>>>>>>>>>>>>>> a
>>>>>>>>>>>>>>>>> writeable filesystem?
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Paul.
>>>>>>>>>>>>>>>>> cy
>>>>>>>>>>>>>>>>> --
>>>>>>>>>>>>>>>>> This message was distributed to subscribers of the selinux mailing
>>>>>>>>>>>>>>>>> list.
>>>>>>>>>>>>>>>>> If you no longer wish to subscribe, send mail to
>>>>>>>>>>>>>>>>> majordomo@tycho.nsa.gov
>>>>>>>>>>>>>>>>> with
>>>>>>>>>>>>>>>>> the words "unsubscribe selinux" without quotes as the message.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> This is confusing to me:
>>>>>>>>>>>>>>>> it sounds like there not trying to mount
>>>>>>>>>>>>>>>> SELinux, but have the policy load
>>>>>>>>>>>>>>>> in a different location other than
>>>>>>>>>>>>>>>> /etc/selinux/*
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> regards;
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Justin P. Mattock
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> On second thought  from what  it  sounds,
>>>>>>>>>>>>>>> to have SELinux be read in another location,
>>>>>>>>>>>>>>> you would have to locate in
>>>>>>>>>>>>>>> libselinux the location from where the library is
>>>>>>>>>>>>>>> told to read the the policy, and simple just change the location,
>>>>>>>>>>>>>>> but then you might have to change the kernel, all the libraries,
>>>>>>>>>>>>>>> all apps, etc.. that read /etc/selinux/*
>>>>>>>>>>>>>>> maybe a simple change of /etc/selinux/config
>>>>>>>>>>>>>>> seems simpler. rather than going through
>>>>>>>>>>>>>>> lines of code.
>>>>>>>>>>>>>>> Anyways,
>>>>>>>>>>>>>>> "Merry christmas"
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> regards;
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Justin P. Mattock
>>>>>>>>>>>>>> You are right. I would like kernel to read policy just from different
>>>>>>>>>>>>>> location.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> So options are as folowing:
>>>>>>>>>>>>>> 1. Change libselinux sources and sources of all related apps + kernel.
>>>>>>>>>>>>>> 2. Try to change /etc/selinux/config.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Regarding second one - manuals on SELinux say that /etc/selinux/config
>>>>>>>>>>>>>> contains name of policy to be loaded. And that name _policyname_ is a
>>>>>>>>>>>>>> name of directory in /etc/selinux/_policyname_ having subdirectory
>>>>>>>>>>>>>> policy with actual policy file.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> So, it seems only option #1 is the one to use.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Does kernel use libselinux to read policy or it reads it directly from
>>>>>>>>>>>>>> filesystem?
>>>>>>>>>>>>>> Any other pitfalls?
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Tim
>>>>>>>>>>>> --
>>>>>>>>>>>> This message was distributed to subscribers of the selinux mailing list.
>>>>>>>>>>>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.govwith
>>>>>>>>>>>> the words "unsubscribe selinux" without quotes as the message.
>>>>>>>>>>>>
>>>>>>> Everything uses libselinux to find the paths to policy.  So if you
>>>>>>> wanted to change the location of where SELinux stores the policy you
>>>>>>> would need to modify libselinux.  In the file src/selinux_config.c
>>>>>>> you would modify
>>>>>>>
>>>>>>> $ grep /etc/selinux src/selinux_config.c
>>>>>>> #define SELINUXDIR "/etc/selinux/"
>>>>>>>
>>>>>>> All of the other paths are relative to this.
>>>>>>>
>>>>>>> I do not believe that we have hard coded this path in to any other user
>>>>>>> tools.  If we have that is a bug.  I don't understand why you would want
>>>>>>> to change this path, and would suggest that you use bind mounts or
>>>>>>> remote mounts if you want these files to be located somewhere else.  You
>>>>>>> would also need to maintain the file context if you do this.
>>>>>>> The motivation for having alternative path for selinux policy
>>>>>>> directory _policyname_ in /etc/selinux/_policyname_ is as following:
>>>>>>> 1) I have legacy system that mounts root filesystem including
>>>>>>> /etc/selinux/... in read-only mode;
>>>>>>> 2) also the system mounts a writable filesystem;
>>>>>>> 3) I can not change that behavior (modes of mounting, filesystem
>>>>>>> types, sequence of mounting, number of mount points etc) of legacy
>>>>>>> system for some reason;
>>>>>>> 4) I can freely modify sources -> kernel, selinux-related (under above
>>>>>>> limitations).
>>>>>>> 5) there is a requirement to support modular policy infrastructure in
>>>>>>> that system;
>>>>>>> To do that I plan to make SELinux subsystem operate on policy-related
>>>>>>> files on different location --> on writable filesystem.
>>>>>>> Could you please clarify that?
>>>> You would also need to maintain the file context if you do this.
>>>>
>>>>>>> Tim
>>>> If you want to maintain the SELinux files on say /var/lib/selinux then
>>>> all of the file context under /var/lib/selinux needs to match that of
>>>> /etc/selinux
>>>>
>>>> So /var/lib/selinux/targeted needs to be labeled selinux_config_t.
>>>>
>>>> In Rawhide for example I have the following labeling for /etc/selinux
>>>> # grep /etc/selinux /etc/selinux/targeted/contexts/files/file_contexts
>>>> /etc/selinux(/.*)?      system_u:object_r:selinux_config_t:s0
>>>> /etc/selinux/([^/]*/)?seusers   --      system_u:object_r:selinux_config_t:s0
>>>> /etc/selinux/([^/]*/)?users(/.*)?       --      system_u:object_r:selinux_config_t:s0
>>>> /etc/selinux/([^/]*/)?policy(/.*)?      system_u:object_r:semanage_store_t:s0
>>>> /etc/selinux/([^/]*/)?setrans\.conf     --      system_u:object_r:selinux_config_t:s0
>>>> /etc/selinux/([^/]*/)?contexts(/.*)?    system_u:object_r:default_context_t:s0
>>>> /etc/selinux/([^/]*/)?contexts/files(/.*)?
>>>> system_u:object_r:file_context_t:s0
>>>> /etc/selinux/([^/]*/)?modules/semanage\.read\.LOCK      --
>>>> system_u:object_r:semanage_read_lock_t:s0
>>>> /etc/selinux/([^/]*/)?modules/semanage\.trans\.LOCK     --
>>>> system_u:object_r:semanage_trans_lock_t:s0
>>>> /etc/selinux/([^/]*/)?modules/(active|tmp|previous)(/.*)?
>>>> system_u:object_r:semanage_store_t:s0
>>>>
>>>>
>>>> You can setup a matching labels for /var/lib/selinux with the semanage
>>>> command.
>>>>
>>>> # semanage fcontext -a -t selinux_config_t '/var/lib/selinux(/.*)?'
>>>> ...
>>>>
>>>>
>>>>>
>>>> Thank you for clarification.
>>>> I will try to change suggested libselinux line to point into different
>>>> location and post the results.
>>>
>>>> Tim
>>>
>>> Why not just use a bind mount on a regular mount, and then you do not
>>> need to change the library at all?
>>> -----BEGIN PGP SIGNATURE-----
>>> Version: GnuPG v1.4.9 (GNU/Linux)
>>> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
>>>
>>> iEYEARECAAYFAklWO4MACgkQrlYvE4MpobPZsACg5YXltDIHUMA7001nNCdLO3C/
>>> jBUAoNwSx/nVhejh+OdSAES9D6wJktao
>>> =X1+b
>>> -----END PGP SIGNATURE-----
>>>
>> Sure, I will try mount --bind before modification of any source.
>>
>> Tim
>>
> Results on mount --bind
> 1) mount --bind /etc/selinnux /opt/mypolicy
> fails since /etc/selinnux is not a device.
> I think the reason is that /etc/selinnux is part of root filesystem,
> not separate filesystem. So mount can not handle it.
> 2) Straight modification of policy path in libselinux to point into
> writable filesystem also did not helped at boot.
> Reason: policy reading is done at very early stage - a way _before_
> the writable filesystem is mounted.
>
> Any ideas for that?
>
> Tim
>

"mount --bind" works for me:

[root@tlondon ~]# mkdir foobar
[root@tlondon ~]# mount --bind /etc/selinux foobar
[root@tlondon ~]# ls -l foobar
total 16
-rw-r--r-- 1 root root  483 2008-12-27 08:56 config
-rw------- 1 root root  133 2008-12-10 06:22 restorecond.conf
-rw-r--r-- 1 root root 1766 2008-12-04 13:12 semanage.conf
drwxr-xr-x 5 root root 4096 2008-12-27 08:57 targeted
[root@tlondon ~]#

I notice that you spelled '/etc/selinux' as '/etc/selinnux'.

That produces the following:
[root@tlondon ~]# mount --bind /etc/selinnux foobar
mount: special device /etc/selinnux does not exist
[root@tlondon ~]#

Does that help?

tom
-- 
Tom London

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
