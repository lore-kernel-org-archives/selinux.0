Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q8BL9m74015602
	for <selinux@tycho.nsa.gov>; Tue, 11 Sep 2012 17:09:48 -0400
Received: from [192.168.1.16] (151.76.17.86) by cp-out7.libero.it (8.5.133)
        id 50434E5E01811A21 for selinux@tycho.nsa.gov; Tue, 11 Sep 2012 23:09:45 +0200
Message-ID: <504FA898.3030105@trentalancia.com>
Date: Tue, 11 Sep 2012 23:09:44 +0200
From: Guido Trentalancia <guido@trentalancia.com>
MIME-Version: 1.0
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: Assertion `new_role != ((void *)0) && new_role->flavor == 1'
 when installing modules
References: <20120909191000.74e83c73@fornost.bigon.be> <1347280786.2480.3.camel@moss-pluto.epoch.ncsc.mil> <20120911011349.0ecc2f99@eldamar.bigon.be> <20120911063822.GA4390@telmora.telvanni> <20120911121903.6ba2825d@eldamar.bigon.be> <20120911222938.5a21a150@fornost.bigon.be>
In-Reply-To: <20120911222938.5a21a150@fornost.bigon.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/09/2012 22:29, Laurent Bigonville wrote:
> Le Tue, 11 Sep 2012 12:19:03 +0200,
> Laurent Bigonville <bigon@debian.org> a écrit :
>
>
>> The patch here: http://marc.info/?l=selinux&m=132636024218187&w=2
>> fixed the segfault when loading the policy with Stephen patch.
>>
>> BUT, it seems that the initial assertion is not completely fixed.
>
> OK, I was wrong. I didn't saw that checkpolicy was statically linked
> against libsepol. So, Stephen's patch in conjunction with the patch
> above are actually fixing my issues with both semodule and checkpolicy.

It's a problem with changes in libsepol/src/expand.c, it can happen 
independently of MLS/MCS or standard policy.

It seems to me that latest changes were:

commit dbc9a61819ea9a6b61bb29a2765b319ac974a775 (Aug 2 2011 18:03:53)

But I do not know much about it, as I had no time to look at it any closer.

Syncing with Reference Policy might help.

Hopefully there will be a human readable error in release instead of 
assertion...

Guido


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
