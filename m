Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9GEf8rT012689
	for <selinux@tycho.nsa.gov>; Sat, 16 Oct 2004 10:41:08 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9GEdti9013561
	for <selinux@tycho.nsa.gov>; Sat, 16 Oct 2004 14:39:55 GMT
Message-ID: <41713302.5080301@redhat.com>
Date: Sat, 16 Oct 2004 10:41:06 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>
CC: selinux@tycho.nsa.gov, ackermal@jmu.edu
Subject: Re: SELinux Testing Software/Scripts
References: <A52BEA1D8EE8634B9196A136333637B130F1@maat.darkhonor.net>
In-Reply-To: <A52BEA1D8EE8634B9196A136333637B130F1@maat.darkhonor.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Alex Ackerman wrote:

> This may sound like an odd request, but I am currently working on my 
> master’s thesis on the topic of SELinux integration into the 
> workplace. Part of the analysis involves testing the security 
> containment capabilities of SELinux; i.e., making sure that SELinux 
> functions as advertised when dealing with events of escalating 
> privilege. Does anyone on this list have any recommendations on 
> scripts or programs which can test these capabilities? My test 
> platforms are Fedora Core 3 (once released) and Red Hat Enterprise 
> Linux v4.0 Beta 1. My current thinking would be to downgrade certain 
> packages (httpd, etc) to a known vulnerable state and test, but would 
> like to know how the members on the list test their systems. Any help 
> would be appreciated. I can be reached at ackermal at jmu dot edu or 
> alex at darkhonor dot com if you would like to discuss this off-list. 
> Thank you for any assistance.
>
> Alex Ackerman
>
> James Madison University
>
>------------------------------------------------------------------------
>
>--
>fedora-selinux-list mailing list
>fedora-selinux-list@redhat.com
>http://www.redhat.com/mailman/listinfo/fedora-selinux-list
>
I don't have any test scripts but i think rolling back the packages to 
one with a known vulerability would work, but since one goal of a hacker 
is to get a root shell, you could use runcon with a shell script to 
simulate what would happen if a hacker was successfull.

runcon -t httpd_t /bin/sh

Of course I can only get this to work in permissive mode. Setting it to 
enforcing kills the shell since it can not access the tty.
Also get an error "execvp: Permission denied" in enforcing.

Dan


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
