In-Reply-To: <Xine.LNX.4.44.0506081157030.29266-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0506081157030.29266-100000@thoron.boston.redhat.com>
Mime-Version: 1.0 (Apple Message framework v730)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B3D1ADA0-7A28-4AF1-807B-1701FDAFABFA@utulsa.edu>
Cc: brandon-pollet@utulsa.edu, SELinux@tycho.nsa.gov
From: Brandon Pollet <brandon@utulsa.edu>
Subject: Re: Dynamic Policy Enforcement in SELinux
Date: Wed, 8 Jun 2005 14:25:48 -0500
To: James Morris <jmorris@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Jun 8, 2005, at 11:09 AM, James Morris wrote:

> On Mon, 6 Jun 2005 brandon-pollet@utulsa.edu wrote:
>
>
>> My name is Brandon Pollet and I am a part of the Enterprise Security
>> Research Group at the University of Tulsa. I recently finished my
>> graduate thesis on Security Enhanced Linux Dynamic Policy Enforcement
>> and I wanted to share it with the community to get your feedback.  
>> I have
>> included a link to my thesis in dvi format but, if there is  
>> interest, I
>> can also provide a link for postscript or PDF. If you have any  
>> questions
>> or feedback please send it to the address below I would love to hear
>> what you all think. Thank you.
>>
>
> This scheme seems to place a large burden on the administrator, to  
> set up
> the rules in the first place and then to analyze and respond to  
> events.
>
> The burden would be amplified by having to manage this across a large
> network of systems.
>
> In terms of initial configuration, how does the administrator even  
> know
> what to care about?
>
> You mention that it's a potential DoS vector, although the later  
> examples
> provided don't seem to demonstrate clearly how the change in security
> posture of the system (e.g. disabling ssh access) to an
> attacker-controlled event (e.g. portscan) provides a good risk/benefit
> scenario.  Why is it better in this case to disable ssh?  Could be  
> a good
> way to lock the administrator out of the system while you break in via
> ftpd.
>
> How do you know what the attack signature means?
>
>
>
> - James
> -- 
> James Morris
> <jmorris@redhat.com>
>
>

While I understand your concerns about it being a burden on an  
administrator, the configuration of the rules is very easy and  
intuitive. You basically just set up a rule to deal with an intrusion  
or security alert that appears in the logs. Then the DPEA can switch  
between security postures when those events take place.

The example of shutting down ssh was to illustrate that the system  
can change the services that it makes available based on its  
environment. In that example the system was configured as a webserver  
with remote administration made available through ssh. When an event  
occurred that looked suspicious the system responded by locking out  
access to ssh to increase it's defenses. The great part about the  
DPEA is that you could configure it to change the system in any way  
the policy will allow you, so if you don't like the disable ssh  
action then you can make your own.

As for an admin knowing what to protect against I don't know that  
there is an easy answer to that question because every system and  
admin are different. For most of my examples I simply looked at my  
logs to see if there was anything suspicious, when there was I would  
make a rule that would respond to it. I'm sure that on a high-risk  
system where this functionality would be needed an admin could come  
up with the events he/she wanted to respond to.
Also, we are currently working on various systems that will make DPEA  
usage over a network an easy and secure process. The work to date has  
centered solely on host defense.

I appreciate this discussion, I hope I don't make it seem otherwise.  
One of the main reasons for putting this on the mailing list was to  
hear your concerns and ideas to make this program better. So keep  
them coming.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
