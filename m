Message-ID: <4631F19C.2090508@redhat.com>
Date: Fri, 27 Apr 2007 08:50:36 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: policycoreutils patch
References: <4630C59F.1070106@redhat.com> <1177615134.3405.43.camel@localhost.localdomain>
In-Reply-To: <1177615134.3405.43.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> On Thu, 2007-04-26 at 11:30 -0400, Daniel J Walsh wrote:
>   
>> This patch moves audit2why to /usr/bin to match audit2allow, since both
>> can be used from userspace.  Also moves sepolgen-ifget to /usr/sbin,
>> since this is not to be run by normal users.
>>
>>     
>
> sepolgen-ifgen can be run by a normal user and the output saved to an
> arbitrary file. audit2allow also has flags for reading the interface
> information from a non-default flag. So I think it should stay
> in /usr/bin.
>
> I merged the audit2why change to trunk, stable, and policyrep.
>
> Karl
>
>
>   
I guess the argument would be just because it can be run by a normal 
user,  should it be placed in /usr/bin?  I look at apps that are almost 
never run by normal users and tend to put them in /usr/sbin.  But 
overall I don't really care.  The only problem is that I have 
selinux-policy-devel package executes it in /usr/sbin.   So moving it 
back to /usr/bin would be a hassle.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
