Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA05982
	for <selinux@tycho.nsa.gov>; Sat, 26 Oct 2002 17:39:55 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA00293
	for <selinux@tycho.nsa.gov>; Sat, 26 Oct 2002 21:38:01 GMT
Received: from tomts9-srv.bellnexxia.net (tomts9.bellnexxia.net [209.226.175.53])
        by jazzband.ncsc.mil  with ESMTP id VAA00288 for <selinux@tycho.nsa.gov>; Sat, 26 Oct 2002 21:38:00 GMT
Message-ID: <3DBB09DF.2020303@sympatico.ca>
Date: Sat, 26 Oct 2002 17:32:15 -0400
From: Chris Albert <christopher.albert@sympatico.ca>
MIME-Version: 1.0
To: Russell Coker <russell@coker.com.au>
CC: selinux@tycho.nsa.gov
Subject: Re: expect
References: <200210262252.30567.russell@coker.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>I want to run an expect script as:
>script program param1 param2 ...
>
>Then have the script spawn "program param1 param2" (sort of like "$@" in a 
>bash script).  How do I do this?  Expect wants to combine all the parameters 
>into a single parameter that contains spaces. How can I solve this?
>
>Also I want to do it for a varying number of parameters (so having an entry 
>for each parameter isn't going to work).
>
>The aim of this is to provide the open_init_pty functionality.  The version I 
>posted to the list before will work for the basic SE functionality (IE 
>Slackware type support).  But for Debian support (and for full RPM support 
>when someone implements it) we need to have open_init_pty run dpkg to install 
>packages (and we can install multiple packages at the same time).
>
>  
>
Russel,
Is is as you woud ex... imagine-- argv.

$expect script param1 param2 ... paramn

All the parameters are found in the list 'argv' , so if in script
...
set argc [llength $argv]
for (set i 0) {$i < $argc} {incr i} {
                puts "arg $i: [lindex $argv  $i]"
}

...

Then the script will spit out:

...

arg 0: param1
arg 1: param2
...
arg n: paramn
...

As in D.Libes' "Exploring Expect" (Oreilly)

Chris




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
