Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n0F1sREw017139
	for <selinux@tycho.nsa.gov>; Wed, 14 Jan 2009 20:54:27 -0500
Received: from an-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n0F1sQnW009459
	for <selinux@tycho.nsa.gov>; Thu, 15 Jan 2009 01:54:26 GMT
Received: by an-out-0708.google.com with SMTP id d11so360651and.39
        for <selinux@tycho.nsa.gov>; Wed, 14 Jan 2009 17:54:26 -0800 (PST)
Message-ID: <496E974E.1040806@gmail.com>
Date: Wed, 14 Jan 2009 17:54:22 -0800
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Paul Moore <paul.moore@hp.com>
CC: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: netlabel: UNLABELED ath9k not denying unlabeled traffic
References: <496D759A.7010401@gmail.com> <200901141508.58174.paul.moore@hp.com> <496E5A9D.3050105@gmail.com> <200901141736.43805.paul.moore@hp.com>
In-Reply-To: <200901141736.43805.paul.moore@hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:
> On Wednesday 14 January 2009 4:35:25 pm Justin P. Mattock wrote:
>   
>> Anyways heres what I'm trying to achieve:
>>
>> default looks like this:
>> Configured NetLabel domain mappings(1)
>> domain: DEFAULT
>>     protocol: UNLABELED
>>
>> I want to try and have three of these for the
>> different types of media:
>> (in theory)
>> Configured NetLabel domain mappings(3)
>> domain:radio
>>    protocol: UNLABELED
>> domain:T.V.
>>    protocol: UNLABELED
>> domain:web
>>    protocol: UNLABELED
>> (and if possible three different tags(either 1,2,5), but probably can
>> only do that with cipsov4);
>>     
>
>   
apologize for the slow response
(had to do some external activities);
> Actually, in your case you are probably always going to want to send 
> network traffic without any labels attached to the packets (no labeled 
> IPsec or CIPSO) so you can stick with the default domain mapping 
> configuration which sends all packets "unlabeled".  The part you should 
> be concerned about is the static/fallback configuration which assigns 
> network peer labels to packets which do not have labels attached to 
> them by the remote host.
>   
sure would be nice to use ipsec/cipsov4 with a internet radio.
(lock down that tcp line);
I'll have to look into making sure I have static/fallback
configured correctly.
> NOTE: the domain mapping configuration only controls how outbound 
> network traffic is labeled on-the-wire; it "maps" the 
> LSM/SELinux "domains" to a specific labeling protocol configuration, 
> e.g. all apache_t traffic should be labeled with CIPSO DOI 3 while all 
> firefox_t traffic should not be labeled at all.
>
>   
>> heres what I've come up with so far:
>>
>> netlabelctl -p map del default
>>
>> netlabelctl unlbl add domain:radio interface:wlan0 address:<myadd>
>> label:system_u:object_r:netlabel_peer_t:s0
>> netlabelctl unlbl add domain:radio interface:wlan0 address:<radioadd>
>> label:system_u:object_r:netlabel_peer_t:s0
>>
>> netlabelctl unlbl add domain:T.V. interface:wlan0 address:<myadd>
>> label:system_u:object_r:netlabel_peer_t:s0
>> netlabelctl unlbl add domain:T.V. interface:wlan0 address:<t.v.add>
>> label:system_u:object_r:netlabel_peer_t:s0
>>     
>
> I think what you mean to type is the following:
>
>  # netlabelctl unlbl add interface:wlan0 address:<radioadd> \
>        label:system_u:object_r:netlabel_peer_t:s0
>
> ... note there is no "domain" argument, that only exists 
> for "netlabelctl map ..." commands.
>
> NOTE: if you really want to get fancy you can create new SELinux domains 
> for each type of media and add NetLabel configurations for those new 
> domains.  Imagine you create a new "internet_radio_t" domain/type and 
> only allow the "netplayer_t" domain (yeah, I made that up but you get 
> the point) access to network traffic labeled with internet_radio_t.  
> You would then use the following command to label your incoming traffic 
> with NetLabel:
>
>  # netlabelctl unlbl add interface:wlan0 address:<radioadd> \
>        label:system_u:object_r:internet_radio_t:s0
>
> NOTE: you can also skip the "interface:wlan0" argument and just 
> use "default" instead if you want the configuration to apply to all 
> your network interfaces; although bear in mind that the "default" 
> configuration can be overridden by the interface specific 
> configurations.
>
>   
Alright, I thought you could use the map option for unlbl.

>> As for the new capabilities, I don't mind trying that out when
>> the time comes(but first I need to figure the this out before any
>> other ways);
>>     
>
> No problem, I understand.  Let me know if you have any more problems.
>
>   
>> here is what the error looks like:
>>
>> netlabel_tools-0.19# make
>> INFO: creating the version header file
>> .: 10: version_info: not found
>> make: *** [include/version.h] Error 2
>>     
>
> Huh, can you try the following:
>
>  1. Open the netlabel_tools-0.19/Makefile in your favorite editor
>  2. Change the ". version_info; \" line to "source ./version_info; \"
>  3. Save your changes
>  4. Try running "make" again
>
> Thanks.
>
>   
Thanks for the info,
Ill try this right away and let you know
if the package compiles.

regards;

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
