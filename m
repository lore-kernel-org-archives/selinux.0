Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0BMdn1J017172
	for <selinux@tycho.nsa.gov>; Fri, 11 Jan 2008 17:39:49 -0500
Received: from py-out-1112.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0BMdkMP027387
	for <selinux@tycho.nsa.gov>; Fri, 11 Jan 2008 22:39:46 GMT
Received: by py-out-1112.google.com with SMTP id a78so1460235pyh.32
        for <selinux@tycho.nsa.gov>; Fri, 11 Jan 2008 14:39:41 -0800 (PST)
Message-ID: <4787EF9D.4060800@gmail.com>
Date: Fri, 11 Jan 2008 16:37:17 -0600
From: Ted X Toth <txtoth@gmail.com>
MIME-Version: 1.0
To: Glenn Faden <Glenn.Faden@sun.com>
CC: Eamon Walsh <ewalsh@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: X avcs
References: <cadfc0e40712261301l3765f85fyc813a6ccfb262e3b@mail.gmail.com> <cadfc0e40712280854i586aae43ya9e602fd56a984ab@mail.gmail.com> <47754FCB.1070307@tycho.nsa.gov> <cadfc0e40712281326k31e9238ci8604298596ade04d@mail.gmail.com> <cadfc0e40801020711w1e3a3a2dv422280f1f9d9595d@mail.gmail.com> <477BEFF1.2090507@sun.com> <47867FCA.50408@tycho.nsa.gov> <47878130.5010000@gmail.com> <4787D5B7.9090606@sun.com>
In-Reply-To: <4787D5B7.9090606@sun.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Glenn Faden wrote:
> Ted X Toth wrote:
>> I'll look at implementing a dixPropertyLookup function. Do any other 
>> XACE hooks have value-return parameters, would it just be va_arg(ap, 
>> PropertyPtr*)?
>> What about the idea of an exception list of single-instance 
>> root-window properties?
>>
> We have already implemented the equivalent of a dixPropertyLookup 
> function called PolyProperty. The following URL is an OpenSolaris 
> source browser query to find the implementation and uses of that 
> function in Xorg.
>
> http://src.opensolaris.org/source/search?q=&defs=&refs=PolyProperty&path=&hist=&project=%2Ffox 
>
>
> --Glenn
>
I will look at this, thanks.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
