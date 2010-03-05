Message-ID: <4B91476E.2040004@redhat.com>
Date: Fri, 05 Mar 2010 13:03:26 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Dominick Grift <domg472@gmail.com>
CC: Eamon Walsh <ewalsh@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: MLS Now working in Fedora 12/RHEL6 in Full Desktop mode.
References: <4B91403D.6010402@redhat.com> <4B9145A6.9020905@gmail.com>
In-Reply-To: <4B9145A6.9020905@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 03/05/2010 12:55 PM, Dominick Grift wrote:
> On 03/05/2010 06:32 PM, Daniel J Walsh wrote:
>    
>> selinux-policy-3.6.32-99.fc12 on Fedora 12
>>      
> Should users be able to login using gdm/gui if they are not assigned a
> default level of s0?
>
> semanage login -m -s user_u -r s1-s1 joe
>
>    
I think you need to setup the homedir with this label.  Or use 
polyinstatiated homedirs.
The homedir is probably labeled s0 so it would not be allowed.

> I could not get that to work.
>
> Also attached is a modification that i implemented to get MLS to "work"
> on previous f13 policy versions:
>
>    
>> -- 
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
>> with
>> the words "unsubscribe selinux" without quotes as the message.
>>      
>    


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
