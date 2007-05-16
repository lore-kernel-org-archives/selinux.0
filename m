Message-ID: <464A5732.2080603@manicmethod.com>
Date: Tue, 15 May 2007 20:58:26 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Eamon Walsh <ewalsh@tycho.nsa.gov>, Ted X Toth <txtoth@gmail.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: In FC8 I would like to start playing with trusted X.
References: <4649FFA2.9060701@redhat.com>
In-Reply-To: <4649FFA2.9060701@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> Supposedly The SELinux XExtensions are in FC7 and beyond so time to 
> start using them.
>
> But lets start simple ...
>
> Some of you are looking at using Trusted X for MLS, but I want to look 
> at this from a targeted policy point of view.  What are the security 
> goals of a normal Fedora user.
> Lets establish two tangible goals.
>
> 1. Only the application with focus can get keyboard input.  So if I am 
> on a web page that is asking me for a password (On Line Banking) Only 
> Firefox can read the input.  Not Thunderbird.
> Theoretically I could run this with all apps mostly unconfined.
> firefox_t can capture input on firefox_t.  While unconfined_t can not.
>

how many apps are you planning on confining for this goal? There are 
very important ones (like gnome-agent) and less important ones (firefox 
passwords that are stored on disk can be read by unconfined anyway)

> 2. No apps except gimp can do a screen capture.  Again I want all apps 
> mostly unconfined
> My goal is to get  a policy that prevents any app from screen capture 
> including
> unconfined_t.  Bug gimp_t in the unconfined domain can.
>

I think you might run into some resistance here, there are dozens of 
programs that do screen captures (screensavers, any of the many screen 
capture programs, vnc server, etc)

And I bet (though I'm not sure) that an unconfined program could run 
gimp with the right command options to take a screen capture and save it 
to a file that would be accessible by said program.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
