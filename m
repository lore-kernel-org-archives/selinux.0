Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA03061
	for <selinux@tycho.nsa.gov>; Thu, 19 Dec 2002 17:43:19 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id gBJMhJI28656
	for <selinux@tycho.nsa.gov>; Thu, 19 Dec 2002 22:43:19 GMT
Received: from khaipur.xiat.org (adsl-66-125-68-98.dsl.anhm01.pacbell.net [66.125.68.98])
        by jazzband.ncsc.mil  with ESMTP id gBJMhHf28652 for <selinux@tycho.nsa.gov>; Thu, 19 Dec 2002 22:43:18 GMT
Date: Thu, 19 Dec 2002 14:41:27 -0800
From: Paul Krumviede <pwk@acm.org>
To: Russell Coker <russell@coker.com.au>, selinux@tycho.nsa.gov
Subject: Re: [ISN] Music file flaws could threaten traders
Message-ID: <18223383.1040308887@localhost>
In-Reply-To: <200212192307.20386.russell@coker.com.au>
References: <200212192307.20386.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--On Thursday, 19 December, 2002 23:07 +0100 Russell Coker 
<russell@coker.com.au> wrote:

> This type of thing could affect Linux in the same way as it affects
> Windows.

i'm not so sure. the bugtraq posting about the windows XP bug
indicated that it could be exploited even without downloading
a file to the user's computer. if using explorer, the file had to be
on the local machine, but didn't need to be "played" to allow
an exploit. i don't think that either case is relevant to selinux
(but would like to know if i'm wrong).

i haven't looked at the winamp report yet.

-paul

> Currently we have "risky" programs such as netscape, games, and IRC
> clients in  their own domains that have types for read-only and for
> read-write files (and  no ability to run gpg or other important programs).
>
> The problem about doing the same for audio/video programs such as players
> for  avi, mp3, and vob files is that their typical use involves
> downloading files  from the net to play immediately so that denying them
> read access to  user_home_t files will give a large decrease in
> functionality.  I believe  that there are two major categories of SE
> Linux users, those who will never  run such A/V programs on Linux, and
> those who won't use any security software  that gets in the way of their
> entertainment.
>
> So I think that having a domain for A/V programs such as $1_av_t that has
> read  access to $1_home_t and can create files with the type $1_home_av_t
> may not  be as tightly secured as we might like, but the people who are
> concerned  about that won't use it anyway.
>
> On Thu, 19 Dec 2002 09:58, InfoSec News wrote:
>> http://news.com.com/2100-1001-978403.html?tag=fd_top
>>
>> By Robert Lemos
>> Staff Writer, CNET News.com
>> December 18, 2002, 5:12 PM PT
>>
>> A security firm on Wednesday warned that people using Windows XP or
>> popular music player WinAmp could fall prey to a vulnerability,
>> enabling a modified music file to take control of a person's PC.
>
> --
> http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
> http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
> http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> http://www.coker.com.au/~russell/  My home page
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with the words "unsubscribe selinux" without quotes as the message.
>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
