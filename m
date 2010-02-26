Message-ID: <4B880E8D.5070602@tycho.nsa.gov>
Date: Fri, 26 Feb 2010 13:10:21 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: updated libselinux pkgconfig does not work correctly on lib64
 machines.
References: <4B857CDE.7010303@redhat.com> <4B857F6B.7050503@redhat.com> <4B872798.4010702@manicmethod.com>
In-Reply-To: <4B872798.4010702@manicmethod.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 02/25/2010 08:44 PM, Joshua Brindle wrote:
> Daniel J Walsh wrote:
>   
>> On 02/24/2010 02:24 PM, Daniel J Walsh wrote:
>> Ignore the first patch it was missing pc.in files. 
>>     
> I am completely new to libtool. Does this seem reasonable Eamon?
>   


I don't see any reference to "lib64" anywhere in our Makefiles even with
the patch.  We have "lib" hard-coded, and I just checked a 64-bit
machine and our stuff is in /usr/lib instead of /usr/lib64.  Is that
what this patch is trying to solve?


-- 

Eamon Walsh 
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
