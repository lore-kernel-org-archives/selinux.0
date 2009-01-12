Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n0CKuDwI005124
	for <selinux@tycho.nsa.gov>; Mon, 12 Jan 2009 15:56:13 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id n0CKrNwX020632
	for <selinux@tycho.nsa.gov>; Mon, 12 Jan 2009 20:53:27 GMT
Message-ID: <496BAE67.7000307@manicmethod.com>
Date: Mon, 12 Jan 2009 15:56:07 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Now that F11 has started, I am putting in the compression support.
References: <49144E3F.8080904@redhat.com> <4967A44B.1080903@manicmethod.com> <496B9389.2050108@redhat.com>
In-Reply-To: <496B9389.2050108@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Joshua Brindle wrote:
>> Daniel J Walsh wrote:
>>> -----BEGIN PGP SIGNED MESSAGE-----
>>> Hash: SHA1
>>>
>>> libsemanage patch to add compression.
>>>
>>> Uses bzip compression, all pp files in active/previous stored in
>>> compressed state.  Added new interfaces to be user by policycoreutils to
>>> specify file rather then memory map.
>>>
>>> Also uses link instead of copy whenever possible to save disk space.
>>> Seeing about a 10 fold savings on policy footprint.
>> resend
>>

Merged in libsemanage 2.0.31 with some additional fixes we discussed 
offline.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
