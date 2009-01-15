Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n0FM0wtk001267
	for <selinux@tycho.nsa.gov>; Thu, 15 Jan 2009 17:00:58 -0500
Received: from mail-ew0-f13.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n0FLw9Tl002004
	for <selinux@tycho.nsa.gov>; Thu, 15 Jan 2009 21:58:09 GMT
Received: by ewy6 with SMTP id 6so1604863ewy.18
        for <selinux@tycho.nsa.gov>; Thu, 15 Jan 2009 14:00:55 -0800 (PST)
Message-ID: <dd18b0c30901151400t68dfc54cu67a378ba71a2edc9@mail.gmail.com>
Date: Thu, 15 Jan 2009 14:00:55 -0800
From: "Justin Mattock" <justinmattock@gmail.com>
To: "Paul Moore" <paul.moore@hp.com>
Subject: Re: netlabel: UNLABELED ath9k not denying unlabeled traffic
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200901151246.38396.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <496D759A.7010401@gmail.com> <200901141736.43805.paul.moore@hp.com>
	 <496EA2EC.7030602@gmail.com> <200901151246.38396.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jan 15, 2009 at 9:46 AM, Paul Moore <paul.moore@hp.com> wrote:
> On Wednesday 14 January 2009 9:43:56 pm Justin P. Mattock wrote:
>> Paul Moore wrote:
>> > On Wednesday 14 January 2009 4:35:25 pm Justin P. Mattock wrote:
>> >> here is what the error looks like:
>> >>
>> >> netlabel_tools-0.19# make
>> >> INFO: creating the version header file
>> >> .: 10: version_info: not found
>> >> make: *** [include/version.h] Error 2
>> >
>> > Huh, can you try the following:
>> >
>> >  1. Open the netlabel_tools-0.19/Makefile in your favorite editor
>> >  2. Change the ". version_info; \" line to "source ./version_info;
>> > \" 3. Save your changes
>> >  4. Try running "make" again
>> >
>> > Thanks.
>>
>> O.k. changed . version like how you had posted.
>> The package compiled like a charm.
>
> Great, I'll change the Makefile(s) in SVN ... I don't quite understand
> the reason (what is your /bin/sh?  I'm guessing not bash?) but at least
> we now have a solution :)
>
> --
> paul moore
> linux @ hp
>

hmm..
under ps auxZ
I see:
2896 tty1 S+ 0:00 /bin/bash /usr/bin/startx
then open aterm for navigating.

Thankfully it works(this people can install
it a test it out.)

regards;

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
