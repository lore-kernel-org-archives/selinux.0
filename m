Message-ID: <3C4C3BCB.40203@pcez.com>
Date: Mon, 21 Jan 2002 08:03:23 -0800
From: Shaun Savage <savages@pcez.com>
MIME-Version: 1.0
To: Tom <tom@lemuria.org>
CC: Lonnie Cumberland <lonnie@outstep.com>, SELinux@tycho.nsa.gov
Subject: Re: restricted guest domain accounts
References: <1129.192.168.1.12.1011589591.squirrel@mail.outstep.com> <20020121091553.A28411@lemuria.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I hear the people wanting a  guest user.  I will try to make a user that 
can login but that is all. Then let you change the policy.  You may have 
to change the context of some programs to system_u:object_r:guest_bin_t 
   this allows the guest account to access the guest_bin_t object but 
not bin_t objects.  

Shaun


Tom wrote:

>On Mon, Jan 21, 2002 at 12:06:31AM -0500, Lonnie Cumberland wrote:
>
>>If I now go along the lines that I will not isolate the users to
>>their home directories but instead use the most secure OS for the job
>>then I once again arrive back at SELinux which I am starting to like
>>more and more.
>>
>
>I have a very similiar problem. I need a remote-access server with
>multiple "public" access options (internet, analog and ISDN dialups)
>into a highly sensitive backend network. obviously, I *expect* it to be
>a target not only for the usual script kiddie rounds, but also for
>specific attacks from people who know at least the rough setup, maybe
>even insiders. the data stored on the backend is such that it may be of
>private interest to even the people who work with it (but obviously
>can't copy it overtly during worktime).
>
>so for now - because as usual nobody really realizes that remote access
>into your own backend means a little more than a convenience, and
>there's of course a tight deadline - I'm using a locked-down, minimalistic 
>Debian system.
>however, I would just love to lock it down much more. that's where
>SELinux comes into play, because I believe here I can really put a
>policy into play that says "after successful login, you are allowed to
>execute exactly THESE three programs."
>as a matter of fact, I wouldn't mind blocking a selection of system
>calls that I know won't be needed. :)
>
>
>>What I am not looking to do is to humbly ask for some help from the
>>list to create a guest domain so that I can add new users to and they
>>will have very restricted abilities on the server. A simple example
>>would be great if someone might have one to share with me.
>>
>
>yes, please. I need a similiar example. I still have trouble
>understanding the flask concept details. I do believe I have the basics
>down (after 3rd reading), but I don't feel confident writing a policy,
>yet.
>
>




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
