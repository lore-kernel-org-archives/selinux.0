Message-ID: <43DE893A.7030203@cornell.edu>
Date: Mon, 30 Jan 2006 16:46:34 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: Desktop integration
References: <43DE6244.5010100@cornell.edu> <43DE6578.9050302@redhat.com>
In-Reply-To: <43DE6578.9050302@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>>
>> The read interface will be easy (hopefully), but the write interface 
>> is not clear. I think we want to aim for user-friendly selinux. For 
>> categories, one possibility is to enumerate the translation strings 
>> from setrans.conf, and have checkboxes for each that the user can 
>> click (I like this idea). Another way to deal with this is a text 
>> box, where we can enter translated or untranslated categories and/or 
>> ranges.
> seobject.py currently does this, but of course it is written in python.
>
> It basically does a getcon on the process and then takes it MLSRange 
> potion and translates it into reachable contexts
>
> s0-s0:c1.c5  = s0. s0:c1, s0:c2, s0:c3, s0:c4, s0:c5.
> It then attempts to translate each one of these to show the user which 
> categories he can create files in.
You're right, I'm not making any sense.. was confused, thinking of a 
different issue.
Should we add a utility function in libselinux that does this kind of 
expand/translate processing?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
