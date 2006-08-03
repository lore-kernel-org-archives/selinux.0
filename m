Message-ID: <44D21454.2080507@redhat.com>
Date: Thu, 03 Aug 2006 11:20:52 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Patch to fix segfault in libselinux
References: <44D0B287.1040500@redhat.com> <1154615738.32479.38.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1154615738.32479.38.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2006-08-02 at 10:11 -0400, Daniel J Walsh wrote:
>   
>> * Tue Aug  1 2006 Jeremy Katz <katzj@redhat.com> - 1.30.19-5
>> - only build non-fpic objects with -mno-tls-direct-seg-refs
>>
>> * Tue Aug  1 2006 Jeremy Katz <katzj@redhat.com> - 1.30.19-4
>> - build with -mno-tls-direct-seg-refs on x86 to avoid triggering
>>   segfaults with xen (#200783)  
>>     
>
> What's really at fault here, libselinux or xen?
>
>   
libselinux in a threaded environment.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
