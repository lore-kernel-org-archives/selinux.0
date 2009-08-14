MIME-version: 1.0
Content-type: text/plain; CHARSET=US-ASCII; format=flowed
Date: Fri, 14 Aug 2009 10:28:34 -0700
From: Glenn Faden <Glenn.Faden@sun.com>
Subject: Re: [PATCH 1/2 -v3] Namespacing of security/selinux
In-reply-to: <1250263220.3629.34.camel@moss-pluto.epoch.ncsc.mil>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Thomas Liu <tliu@redhat.com>, selinux@tycho.nsa.gov, jmorris@namei.org,
        eparis@parisplace.org
Message-id: <4A859EC2.2030807@sun.com>
References: <1246906718.2460.12.camel@Ares>
 <1246909386.28321.148.camel@moss-pluto.epoch.ncsc.mil>
 <1246968394.28321.171.camel@moss-pluto.epoch.ncsc.mil>
 <1247003355.2149.2.camel@Ares>
 <1250263220.3629.34.camel@moss-pluto.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2009-07-07 at 17:49 -0400, Thomas Liu wrote:
>   
>> This includes namespacing of all items originally labeled
>> security_ with sel_.
>>
>> In addition, the functions sel_netif_sid and security_netif_sid
>> have been renamed because the namespacing would cause a conflict.
>>
>> sel_netif_sid has been renamed to sel_netif_sid_by_index, and
>> security_netif_sid has been renamed to sel_netif_sid_by_name
>>     
>
> This patch has a minor reject against the current security-testing tree.
>
> However, I'm having second thoughts about the renaming idea.  There are
> a rather large number of documents, not to mention the userspace API,
> that talk about security_compute_av() and friends, and thus I'm a bit
> hesitant to render them all obsolete.
>   
Changing the namespace from security_ to sel_ or selinux_ makes it more 
difficult for Solaris and other non-linux systems which may be 
supporting Flask, to be compatible at the library level with policy 
management applications.

--Glenn

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
