Date: Thu, 10 Jan 2008 15:27:00 -0800
From: Glenn Faden <Glenn.Faden@sun.com>
Subject: Re: X avcs
In-reply-to: <47867FCA.50408@tycho.nsa.gov>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: Xavier Toth <txtoth@gmail.com>, SE Linux <selinux@tycho.nsa.gov>
Message-id: <4786A9C4.4050204@sun.com>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
References: <cadfc0e40712261301l3765f85fyc813a6ccfb262e3b@mail.gmail.com>
 <cadfc0e40712280854i586aae43ya9e602fd56a984ab@mail.gmail.com>
 <47754FCB.1070307@tycho.nsa.gov>
 <cadfc0e40712281326k31e9238ci8604298596ade04d@mail.gmail.com>
 <cadfc0e40801020711w1e3a3a2dv422280f1f9d9595d@mail.gmail.com>
 <477BEFF1.2090507@sun.com> <47867FCA.50408@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eamon Walsh wrote:
> Glenn Faden wrote:
>> This is my first posting to this alias, so let me start by 
>> introducing myself. I'm a Distinguished Engineer in the Solaris 
>> security organization, and I'm the original architect for Sun's 
>> multilevel X11 server. I have worked on this problem since 1990, and 
>> have designed three multilevel desktops (Open Look, CDE, and GNOME)
>>
>> One of the biggest challenges in adding fine-grained policy to the 
>> X11 server is to make the policy transparent to existing X11 clients. 
>> Probably the most critical design decision we made was with respect 
>> to root window resources. By default, all root window properties are 
>> polyinstantiated by both label and uid. For SELinux, the equivalent 
>> policy would be polyinstantiation by security context (not just MLS 
>> label). An exception list of single-instance root-window properties 
>> is enumerated in a policy file.
>> We have found that the list of exceptions is much smaller than the 
>> list that should be polyinstantiated.
>>   
>
> Hello.  I am not opposed to the idea of polyinstantiated properties.  
> Although our approach has always been to attempt to fix applications 
> to work within the secure environment first, it looks like this is a 
> case where polyinstantiated is needed.
"Fixing" applications to work in a secure environment implies that they 
are currently broken. It seems that the policy is broken if it prevents 
commonly used applications from working. Isn't the purpose of policy 
development to improve the safety of existing applications?
> Our long-term goal is to make applications aware of and responsive to 
> the security environment, particularly applications that could 
> themselves be multi-level such as e-mail, web, office.
Certainly the environment should support multilevel applications, but I 
these are exceptions. Virtually all applications should work without 
modification at a single level.

--Glenn

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
