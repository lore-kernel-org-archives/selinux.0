In-Reply-To: <1118230686.26902.3.camel@moss-spartans.epoch.ncsc.mil>
References: <1118094711.42a4c577888fb@cc.utulsa.edu> <1118230686.26902.3.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0 (Apple Message framework v730)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1190D375-C080-4A5F-BA97-538F1469D59B@utulsa.edu>
Cc: brandon-pollet@utulsa.edu, SELinux@tycho.nsa.gov
From: Brandon Pollet <brandon@utulsa.edu>
Subject: Re: Dynamic Policy Enforcement in SELinux
Date: Wed, 8 Jun 2005 13:57:44 -0500
To: Stephen Smalley <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Jun 8, 2005, at 6:38 AM, Stephen Smalley wrote:

> On Mon, 2005-06-06 at 16:51 -0500, brandon-pollet@utulsa.edu wrote:
>
>> My name is Brandon Pollet and I am a part of the Enterprise  
>> Security Research Group at the
>> University of Tulsa. I recently finished my graduate thesis on  
>> Security Enhanced Linux
>> Dynamic Policy Enforcement and I wanted to share it with the  
>> community to get your
>> feedback. I have included a link to my thesis in dvi format but,  
>> if there is interest, I can also provide a link for postscript or  
>> PDF. If you have any questions or feedback please send it to the  
>> address below I would love to hear what you all think. Thank you.
>>
>> Dynamic Policy Enforcement in SElinux
>>
>> http://personal.utulsa.edu/~brandon-pollet/DynamicPolicy-BP.dvi
>>
>
> - Conditional policy support was actually developed by Tresys
> Technology, and then integrated into the mainline SELinux.
>
> - Will you be releasing your code?  If so, under what license?
>
> -- 
> Stephen Smalley
> National Security Agency
>
>

Thanks for pointing out the error in credit for Conditional Policy I  
have corrected that and the change is reflected in the pdf version  
linked to below. I have every intention to make the code available to  
the community but before I can make any promises I have to make sure  
that I am allowed to distribute it.

I have also been asked about the status of this work and I currently  
have a version of this software running on a Fedora Core 3 box,  
mainly for testing purposes.

I have included a link to a pdf version of my Thesis to make viewing  
it easier. I have also included the paper's Abstract below.

http://personal.utulsa.edu/~brandon-pollet/DynamicPolicy-BP.pdf



Abstract
The need for manageable computer security has never been greater. The
constant deluge of viruses, worms, and program vulnerabilities makes  
it extremely
difficult to maintain a secure and usable system. Systems that are  
not configured and
updated correctly to defend against the latest threats can quickly be  
compromised.
This environment warrants a need for systems that can reconfigure  
themselves in the
face of security threats. The Dynamic Policy Enforcement Agent (DPEA)  
provides a
new way of configuring, modifying, and maintaining the security  
policy of a SELinux
system. Monitoring its environment, both for internal and external  
threats, the
DPEA is able to modify the security level of a system to respond to  
any situation.
The DPEA strives to provide the long sought after capabilities of a  
self-defending
system while requiring only a limited amount of resources and access.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
