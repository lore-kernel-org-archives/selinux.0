Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p0FCm84w021682
	for <selinux@tycho.nsa.gov>; Sat, 15 Jan 2011 07:48:09 -0500
Received: from mail-iw0-f195.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p0FCm6RO020455
	for <selinux@tycho.nsa.gov>; Sat, 15 Jan 2011 12:48:07 GMT
Received: by iwn41 with SMTP id 41so1141866iwn.6
        for <selinux@tycho.nsa.gov>; Sat, 15 Jan 2011 04:48:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4D3057AC.3040903@redhat.com>
References: <4D01F7A4.90708@ak.jp.nec.com>
	<4D2FEAE9.8080201@ak.jp.nec.com>
	<4D3057AC.3040903@redhat.com>
Date: Sat, 15 Jan 2011 21:48:06 +0900
Message-ID: <AANLkTi=vHcJBGpUKQa0VZDtnFJGQ8Ozgmt4mhihYH-r+@mail.gmail.com>
Subject: Re: [refpolicy] [PATCH] New database object classes
From: Kohei KaiGai <kaigai@kaigai.gr.jp>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: KaiGai Kohei <kaigai@ak.jp.nec.com>, refpolicy@oss1.tresys.com,
        selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>> How about getting inclusion of this patch?
>>
>> These new object classes and corresponding rules are necessary
>> to run SE-PostgreSQL based on the upcoming v9.1.
>>
 :
> KaiGai, I believe we have your patches in Fedora and RHEL6, If not
> please ping me to add them.

I'm not certain about the latest RHEL6 policy, because I don't know
the way to reference its repository.
However, these new object classes are not included within the latest
Fedora policy right now. I checked it using "fedpkg co selinux-policy".
Do I see the same tree with you, don't I?

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
