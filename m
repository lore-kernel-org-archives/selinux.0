Message-ID: <41643515.4010608@redhat.com>
Date: Wed, 06 Oct 2004 14:10:29 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Shouldn't this avc message be dontaudited?
References: <416419A5.6030809@redhat.com> <1097085479.11370.55.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1097085479.11370.55.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Wed, 2004-10-06 at 12:13, Daniel J Walsh wrote:
>  
>
>>How come I am getting this avc message
>>
>>Oct  6 11:58:44 localhost kernel: audit(1097078324.850:0): avc:  denied  
>>{ name_bind } for  pid=2471 exe=/usr/sbin/nscd src=953 
>>scontext=user_u:system_r:nscd_t tcontext=system_u:object_r:rndc_port_t 
>>tclass=tcp_socket
>>
>>When I have this rule?
>>
>>dontaudit nscd_t reserved_port_t:{ tcp_socket udp_socket } name_bind;
>>    
>>
>
>Different types - reserved_port_t (covers any otherwise unspecified
>reserved ports) vs. rndc_port_t.  Why would nscd try binding to this
>port anyway?
>
>  
>
I don't know.  I am seeing this avc on a targeted policy machine.

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
