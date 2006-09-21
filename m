Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8LFfPfR016065
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 11:41:25 -0400
Received: from smtp109.sbc.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k8LFeuRL019885
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 15:40:56 GMT
In-Reply-To: <1158850172.11048.2.camel@twoface.columbia.tresys.com>
References: <45116881.3060406@redhat.com> <1158846352.3920.33.camel@sgc.columbia.tresys.com> <45129CD0.5040507@argus-systems.com> <1158850172.11048.2.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F50BFB1B-5CE6-459C-B0F7-5A9496C483DC@nall.com>
Cc: "Mikel L. Matthews" <mikel@argus-systems.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
From: Joe Nall <joe@nall.com>
Subject: Re: Latest diffs
Date: Thu, 21 Sep 2006 10:40:53 -0500
To: Joshua Brindle <jbrindle@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sep 21, 2006, at 9:49 AM, Joshua Brindle wrote:

> On Thu, 2006-09-21 at 09:08 -0500, Mikel L. Matthews wrote:
>>
>> We have customers that use all of our 1024 categories and want more.
>> They have requested 10,000 categories.

Wow, and I though I was out on the fringes :) Admin must be ugly.

> That is because they are probably using categories as an integrity
> mechanism which is entirely inappropriate for SELinux since TE  
> should be
> used for integrity and mls should only be used for confidentiality. I
> seriously doubt that a reasonable system could have 10000 useful
> categories.

I can't comment on 10K, but 256 is not enough. Imagine a system that
exchanges data with countries, alliances and has dissemination controls
and compartments local to the country the system is in. There are ~243
countries in ISO 3166, there are between 10 and 20 alliances you might
want to exchange data with, there are another dozen common dissemination
controls (eg NOFORN) and there are quite a few compartments. You can get
over 300 bits pretty easily just using bits for confidentiality.

I'm happy with 1024 because it means we will not have to maintain
policy diffs (for this) and explain them to our accreditors.

joe

http://en.wikipedia.org/wiki/ISO_3166-1_alpha-3
http://www.afei.org/news/ddms.pdf (Table C4.T1)
http://metadata.dod.mil/mdr/irs/DDMS/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
