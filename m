Message-ID: <53C68A6D.80500@tycho.nsa.gov>
Date: Wed, 16 Jul 2014 10:21:33 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Steve Lawrence <slawrence@tresys.com>,
 Dominick Grift <dominick.grift@gmail.com>
Subject: Re: [RFC] Source Policy, CIL, and High Level Languages
References: <53BD9646.6030303@tresys.com>
 <1404975079.31209.11.camel@x220.localdomain> <53C01CDD.80407@tresys.com>
 <53C409C3.3010602@tycho.nsa.gov> <53C40B13.9030907@tycho.nsa.gov>
 <53C40E8D.8070006@tycho.nsa.gov> <53C40F73.3030204@tresys.com>
 <53C41818.5000906@tycho.nsa.gov> <53C5875E.3050600@tresys.com>
 <53C68950.3050805@tycho.nsa.gov>
In-Reply-To: <53C68950.3050805@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Cc: SELinux List <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/16/2014 10:16 AM, Stephen Smalley wrote:
> On 07/15/2014 03:56 PM, Steve Lawrence wrote:
>> On 07/14/2014 01:49 PM, Stephen Smalley wrote:
>>> On 07/14/2014 01:12 PM, Steve Lawrence wrote:
>>>> Ah, interesting. We saw that problem a long time ago, but couldn't
>>>> reproduce it and it disappeared. Though I'm still unable to reproduce it
>>>> following your steps. I can still login and seusers is labeled
>>>> selinux_config_t. I'll keep looking into this.
>>>>
>>>> I've also rebased/pushed #integration onto #next.
>>>
>>> # Revert to stock F20 SELinux userspace and policy.
>>> yum reinstall checkpolicy* libsepol* libsemanage* libselinux*
>>> policycoreutils* selinux-policy-targeted
>>>
>>> # Clear prior source/CIL policy store.
>>> rm -rf /var/lib/selinux
>>>
>>> # Reboot to ensure systemd and friends are using the new policy.
>>> reboot
>>>
>>> # Reset selinux and cil to latest sources
>>> cd selinux
>>> git clean -fdx
>>> git fetch origin
>>> git reset --hard origin/integration
>>> cd ../cil
>>> git clean -fdx
>>> git fetch origin
>>> git reset --hard origin/master
>>>
>>> # Build and install new userspace
>>> cd ..
>>> ln -sf ../../cil selinux/libsepol/cil
>>> make -C selinux LIBDIR=/usr/lib64 SHLIBDIR=/lib64 install install-pywrap
>>> relabel
>>>
>>> # Convert
>>>  ./selinux/libsemanage/utils/semanage_migrate_etc_to_var.py
>>>
>>> Try to login on console or via ssh:  Unable to get valid context for sds.
>>>
>>> dmesg | grep systemd
>>> [  343.739985] systemd[1]: SELinux policy denies access.
>>> [  348.256030] systemd[1]: SELinux policy denies access.
>>> [  376.335248] systemd[1]: SELinux policy denies access.
>>> [  376.515343] systemd[1]: SELinux policy denies access.
>>>
>>> restorecon -R /etc/selinux/targeted
>>>
>>> Try to login again, hangs for a long time before finally succeeding.
>>>
>>> reboot
>>>
>>> Everything is happy.
>>>
>>> 100% reproducible, every time.
>>>
>>>
>>
>> Thanks for the steps. I think I found what causes the labeling problem,
>> but I'm not yet sure why. It looks like it has something to do with how
>> the migration script rebuilds policy. If you run the migration script
>> with the --norebuild flag, and then run semodule -B, everything is
>> rebuilt and the files in /etc/selinux are labeled correctly.
>>
>> I'm not yet convinced this is the same problem as the systemd issue (I
>> do get "unable to get valid context", but I still don't get "SELinux
>> policy denies access"). Let me know if you still see that after using
>> --norebuild/semodule -B.
> 
> Ok, if I do:
> ./libsemanage/utils/semanage_migrate_etc_to_var.py -n
> semodule -B
> 
> then /etc/selinux is labeled correctly and I can still login.
> However, running su hangs and I get the systemd error message again.

Also get this:
ERROR:dbus.proxies:Introspect error on :1.4:/org/freedesktop/login1:
dbus.exceptions.DBusException: org.freedesktop.DBus.Error.NoReply: Did
not receive a reply. Possible causes include: the remote application did
not send a reply, the message bus security policy blocked the reply, the
reply timeout expired, or the network connection was broken.

when trying to re-install the original selinux userspace packages.
With more errors from systemd in dmesg,
[14421.297045] systemd[1]: SELinux policy denies access.
[14451.711732] systemd[1]: SELinux policy denies access.
[14451.743787] systemd[1]: SELinux policy denies access.
[14512.551210] systemd[1]: SELinux policy denies access.
[14512.584126] systemd[1]: SELinux policy denies access.
[14543.063872] systemd[1]: SELinux policy denies access.
[14634.451680] systemd[1]: SELinux policy denies access.
[14634.469813] systemd[1]: SELinux policy denies access.
[14659.346867] systemd[1]: SELinux policy denies access.
[14659.665108] systemd[1]: SELinux policy denies access.
[14695.602174] systemd[1]: SELinux policy denies access.
