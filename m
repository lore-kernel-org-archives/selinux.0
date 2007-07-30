Message-ID: <46AE07F5.1090101@kaigai.gr.jp>
Date: Tue, 31 Jul 2007 00:47:01 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Paul Howarth <paul@city-fan.org>
Cc: KaiGai Kohei <kaigai@ak.jp.nec.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov, fedora-selinux-list@redhat.com
Subject: Re: Guideline for RPM packages
References: <46681714.3030009@kaigai.gr.jp> <1181227502.11979.24.camel@moss-spartans.epoch.ncsc.mil> <46681ED6.1010408@kaigai.gr.jp> <46A861F6.10709@ak.jp.nec.com> <46AE00BD.80900@city-fan.org>
In-Reply-To: <46AE00BD.80900@city-fan.org>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Howarth wrote:
> KaiGai Kohei wrote:
>>>>> If I remember correctly, someone posted a guideline to make
>>>>> a RPM package which contains binary security policy, several
>>>>> weeks ago.
>>>>>
>>>>> If you know the URL, would you tell me the location?
>>>> There is a draft guide at:
>>>> http://fedoraproject.org/wiki/PackagingDrafts/SELinux/PolicyModules
>>> Thanks, so much!
>> I have a comment for the Policy Module Packaging Guideline.
>>
>> The document says every *.pp files should be installed for any sort of policies
>> (targeted, strict, mls) in the %post section.
>> However, it can cause a problem when a part of policies are not installed yet.
>>
>> When we try to install an application including policy package on the system
>> which has only targeted policy, installation of *.pp files for strict/mls will
>> be failed no need to say.
>> If we want to install selinux-policy-strict or -mls later, the oraphan *.pp files
>> are not linked automatically because "/usr/bin/semodule -i" is not invoked.
>> It will cause a simple problem, but a bit difficult to find out.
>>
>> I have an idea that uses "%triggerin" to invoke "/use/bin/semodule -i" to link
>> orphan *.pp files on instllation of selinux-policy-* packages later, as follows:
>>
>> ----------------
>>   %triggerin -- selinux-policy-targeted
>>   if [ $0 -eq 1 ]; then
>>       /usr/sbin/semodule -s targeted -i %{_datadir}/selinux/targeted/mymodule.pp &> /dev/null || :
>>   fi
>>   %triggerin -- selinux-policy-strict
>>   if [ $0 -eq 1 ]; then
>>       /usr/sbin/semodule -s strict -i %{_datadir}/selinux/strict/mymodule.pp &> /dev/null || :
>>   fi
>>   %triggerin -- selinux-policy-mls
>>   if [ $0 -eq 1 ]; then
>>       /usr/sbin/semodule -s mls -i %{_datadir}/selinux/mls/mymodule.pp &> /dev/null || :
>>   fi
>> ----------------
>>
>> If the application is installed on the system which already has selinux-policy-strict,
>> "%triggerin -- selinux-policy-strict" will be invoked just when the application is
>> installed, so there is no degrading.
> 
> Looks sane to me though it would be nice if there was some way of
> expressing this once rather than duplicate it for each policy type.
> Can't think of any way of doing that though.

I tried to find a way to describe it once without a duplication,
but I could not get a good idea.

If we can describe them like as "%triggerin -- selinux-policy-*", it's better.
Please tell me, if anyone knows more appropriate way to describe.

Thanks,
--
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
