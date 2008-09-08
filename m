Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m88CqRmY025028
	for <selinux@tycho.nsa.gov>; Mon, 8 Sep 2008 08:52:27 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m88CqRGU005085
	for <selinux@tycho.nsa.gov>; Mon, 8 Sep 2008 12:52:27 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m88CqRgT008253
	for <selinux@tycho.nsa.gov>; Mon, 8 Sep 2008 08:52:27 -0400
Message-ID: <48C52008.7090709@redhat.com>
Date: Mon, 08 Sep 2008 08:52:24 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Murray McAllister <mmcallis@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: user guide draft: "Targeted Policy" review
References: <48BE3FB4.8020003@redhat.com> <1220447961.6034.54.camel@moss-spartans.epoch.ncsc.mil> <48C0CBF9.4090008@redhat.com> <48C140CB.7090108@redhat.com> <48C209DA.4040901@redhat.com>
In-Reply-To: <48C209DA.4040901@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Murray McAllister wrote:
> Daniel J Walsh wrote:
>> Murray McAllister wrote:
>>> Stephen Smalley wrote:
>>>> On Wed, 2008-09-03 at 17:41 +1000, Murray McAllister wrote:
> 
>>> When a confined subject is compromised by an attacker, depending on
>>> SELinux policy configuration, the attacker's access is to resources and
>>> the possible damage they can do is limited.
>>>
>> If a confined ...
> 
> Changed.
> 
>>>>> Unconfined Subjects
>>>>>
>>>>> Unconfined subjects run in the unconfined_t domain type. This means
>>>>> that SELinux policy rules do not apply, and only DAC permissions are
>>>>> used.
>> Only unconfined login users run as unconfined_t, init programs run in
>> the unconfined domain initrc_t, unconfined inetd processes run in the
>> inetd_child_t domain.  Unconfined kernel processes run in kernel_t.
>> There are about 20 unconfined domains in Fedora 10.
> 
> How about:
> 
> Unconfined subjects run in unconfined domains, for example, init
> programs run in the unconfined initrc_t domain, unconfined kernel
> subjects run in the kernel_t domain, and unconfined Linux users run in
> the unconfined_t domain. For unconfined subjects, SELinux policy rules
> are applied, but policy rules exist that allow subjects running in
> unconfined domains almost all access. Subjects running in unconfined
> domains almost always fall back to using DAC rules exclusively. If an
> unconfined subject is compromised, SELinux does not prevent the attacker
> from gaining access to system resources and data, but of course, DAC
> rules are still used. SELinux is a security enhancement above DAC rules
> - it does not replace them.

I don't think you need the "almost always"


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
