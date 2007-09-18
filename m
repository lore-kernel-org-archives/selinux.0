Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8IF4BuJ003677
	for <selinux@tycho.nsa.gov>; Tue, 18 Sep 2007 11:04:11 -0400
Received: from mx2.sygneca.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8IF4AgF016747
	for <selinux@tycho.nsa.gov>; Tue, 18 Sep 2007 15:04:11 GMT
Received: from [192.168.1.101] (cpc3-bele5-0-0-cust269.belf.cable.ntl.com [82.18.189.14])
	(using SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.sygneca.com (Postfix) with ESMTP id 2BF48A42F8
	for <selinux@tycho.nsa.gov>; Tue, 18 Sep 2007 16:04:04 +0100 (BST)
Message-ID: <46EFE8D3.6060309@martinorr.name>
Date: Tue, 18 Sep 2007 16:03:47 +0100
From: Martin Orr <martin@martinorr.name>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: selinux@tycho.nsa.gov
Subject: Re: alsactl policy
References: <20070916201319.GA2705@tiberius.martinorr.name> <46EE8D70.2080804@redhat.com>
In-Reply-To: <46EE8D70.2080804@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 17/09/07 15:21, Daniel J Walsh wrote:
>>  type alsa_etc_rw_t;
>>  files_type(alsa_etc_rw_t)
> 
>> +type alsa_var_lib_t;
>> +files_type(alsa_var_lib_t)
>> +
>> +type alsa_state_t;
>> +files_type(alsa_state_t)
>> +
> We already have alsa_etc_rw_t for this.  So we could either change
> alsa_etc_rw_t to this context and typealias it or leave it as rw_t.
> Or alternatively just allow alsa to write to alsa_var_lib_t,

OK, I thought that alsa_etc_rw_t was for something else.  Since I don't have
any /etc/alsa/pcm directory, I didn't know what it was for.

> Fedora stores asound.state under etc.  Although it probably would be
> better in var/lib
> 
> I have opened a bugzilla for Fedora to write their asound.state file there.
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=293301

There is a bug in the upstream BTS to change this as well:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3128

Thanks for your reviewing time,

-- 
Martin Orr

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
