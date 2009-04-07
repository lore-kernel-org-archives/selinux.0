Message-ID: <49DB5185.4070801@kaigai.gr.jp>
Date: Tue, 07 Apr 2009 22:13:41 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: SE Linux <selinux@tycho.nsa.gov>, Eamon Walsh <ewalsh@tycho.nsa.gov>
Subject: Re: [ANN] SELinux userspace release
References: <49D64FEC.3030909@manicmethod.com> <49D80318.4040902@kaigai.gr.jp> <49DA3733.3050904@manicmethod.com>
In-Reply-To: <49DA3733.3050904@manicmethod.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> KaiGai Kohei wrote:
>> Joshua Brindle wrote:
>>> The SELinux userspace project has updated a release. As usual you can 
>>> find it at http://userspace.selinuxproject.org/trac/wiki/Releases.
>>>
>>> This is primarily a bug fix release. The added features are policy 
>>> module module compression support and AVC caching for compute_create 
>>> results.
>>>
>>> This release does not include an updated release of the stable_1_0 
>>> branch, which has not been updated since the last release.
>>>
>>> For git users this release has been tagged 20090403 in the repository 
>>> on userspace.selinuxproject.org.
>>
>> Joshua, when the following features will be available in the libselinux?
>>
>>  - Expose avc_netlink_loop() for applications.
>>    http://marc.info/?l=selinux&m=123838949914769&w=2
>>
>>  - Permissive domains in userspace.
>>    http://marc.info/?l=selinux&m=123855044416037&w=2
>>
>>  - selabel_lookup(3) support for database objects.
>>    http://marc.info/?l=selinux&m=123840173526150&w=2
>>
> 
> These patches are being reviewed by Eamon AFAIK so once he acks them or 
> merges them.

OK, I'll wait for a while more.

In addition, I've forgottn to note the patch.
- A new API: security_deny_unknown()
   http://marc.info/?l=selinux&m=123863254719835&w=2

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
