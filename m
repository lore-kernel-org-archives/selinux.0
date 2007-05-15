Message-ID: <4649FFA2.9060701@redhat.com>
Date: Tue, 15 May 2007 14:44:50 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>, Ted X Toth <txtoth@gmail.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: In FC8 I would like to start playing with trusted X.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Supposedly The SELinux XExtensions are in FC7 and beyond so time to 
start using them.

But lets start simple ...

Some of you are looking at using Trusted X for MLS, but I want to look 
at this from a targeted policy point of view.  What are the security 
goals of a normal Fedora user. 

Lets establish two tangible goals.

1. Only the application with focus can get keyboard input.  So if I am 
on a web page that is asking me for a password (On Line Banking) Only 
Firefox can read the input.  Not Thunderbird.
Theoretically I could run this with all apps mostly unconfined.
firefox_t can capture input on firefox_t.  While unconfined_t can not.

2. No apps except gimp can do a screen capture.  Again I want all apps 
mostly unconfined
My goal is to get  a policy that prevents any app from screen capture 
including
unconfined_t.  Bug gimp_t in the unconfined domain can.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
