Message-ID: <464B2F95.7090700@redhat.com>
Date: Wed, 16 May 2007 12:21:41 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: James Antill <jantill@redhat.com>
CC: Eamon Walsh <ewalsh@tycho.nsa.gov>, Ted X Toth <txtoth@gmail.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: In FC8 I would like to start playing with trusted X.
References: <4649FFA2.9060701@redhat.com> <1179326483.16624.21.camel@code.and.org>
In-Reply-To: <1179326483.16624.21.camel@code.and.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Antill wrote:
> On Tue, 2007-05-15 at 14:44 -0400, Daniel J Walsh wrote:
>   
>> Supposedly The SELinux XExtensions are in FC7 and beyond so time to 
>> start using them.
>>
>> But lets start simple ...
>>
>> Some of you are looking at using Trusted X for MLS, but I want to look 
>> at this from a targeted policy point of view.  What are the security 
>> goals of a normal Fedora user. 
>>
>> Lets establish two tangible goals.
>>
>> 1. Only the application with focus can get keyboard input.  So if I am 
>> on a web page that is asking me for a password (On Line Banking) Only 
>> Firefox can read the input.  Not Thunderbird.
>> Theoretically I could run this with all apps mostly unconfined.
>> firefox_t can capture input on firefox_t.  While unconfined_t can not.
>>     
>
>  This might go well, I'm not sure, and if it does would be a big plus :)
>
>   
>> 2. No apps except gimp can do a screen capture.  Again I want all apps 
>> mostly unconfined
>> My goal is to get  a policy that prevents any app from screen capture 
>> including
>> unconfined_t.  Bug gimp_t in the unconfined domain can.
>>     
>
>  You will need to include gnome-screenshot as well as gimp here though,
> or a lot of people will complain (PrintScreen). With those two, this
> might be able to work (None of the gnome-screensaver actions try to take
> shots now, IIRC).
>
>   

Ok now I was hoping the NSA guys would hop in and say.  Hey here is how 
you would do it.  :^)
Because I have no idea.  Any help would be appreciated.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
