Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA09958
	for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2002 10:15:40 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA01699
	for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2002 15:14:51 GMT
Received: from sparcy.internal.lan (dsl092-233-010.phl1.dsl.speakeasy.net [66.92.233.10])
        by jazzband.ncsc.mil  with ESMTP id PAA01695 for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2002 15:14:50 GMT
Date: Fri, 18 Jan 2002 10:14:38 -0500 (EST)
From: Noah silva <nsilva@atari-source.com>
To: Justin Smith <jsmith@mcs.drexel.edu>
cc: selinux@tycho.nsa.gov
Subject: Re: ext3 file system
In-Reply-To: <1011303902.5928.2.camel@vorpal>
Message-ID: <Pine.LNX.4.21.0201181014110.4277-100000@sparcy.internal.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Can't you disable the visibility? I thought that was an option in
ext3.  Does SELinux prevent this from functioning in some way.

 -- noah silva 

On 17 Jan 2002, Justin Smith wrote:

> When trying to label files with the setfiles utilities, the process
> crashes when they encounter the .journal files. These are user-visible,
> but are not regular files (they are immutable in the sense that even
> root cannot change them in any way). The setfiles utilities issue a
> warning that they cannot write to .journal and quit.
> 
> Any ideas?
> 
> Perhaps there should be some way of exempting the .journal files from
> the labelling process. It is unfortunate that they are visible to users
> (since users cannot actually use them for anything).
> 
> --
> 
> 
> --
> You have received this message because you are subscribed to the selinux list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
