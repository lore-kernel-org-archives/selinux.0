Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k86I4wGC017283
	for <selinux@tycho.nsa.gov>; Wed, 6 Sep 2006 14:05:00 -0400
Received: from M4.sparta.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k86I4YkO027016
	for <selinux@tycho.nsa.gov>; Wed, 6 Sep 2006 18:04:35 GMT
Received: from Beta5.sparta.com (beta5.sparta.com [157.185.63.21])
	by M4.sparta.com (8.13.5/8.13.5) with ESMTP id k86I4uAn027544
	for <selinux@tycho.nsa.gov>; Wed, 6 Sep 2006 13:04:56 -0500
Received: from nemo.columbia.ads.sparta.com (nemo.columbia.sparta.com [157.185.80.75])
	by Beta5.sparta.com (8.12.11/8.13.1) with ESMTP id k86I4u2T027629
	for <selinux@tycho.nsa.gov>; Wed, 6 Sep 2006 13:04:56 -0500
Mime-Version: 1.0 (Apple Message framework v752.2)
In-Reply-To: <4B7876D7-978C-4EDA-ABCA-DE8AB4CA9F6F@sparta.com>
References: <4B7876D7-978C-4EDA-ABCA-DE8AB4CA9F6F@sparta.com>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <16A7CD41-31E3-4079-8F6D-E3217991500C@sparta.com>
From: Todd Miller <Todd.Miller@sparta.com>
Subject: Re: current selinux-usr incompatible with refpolicy-20060307?
Date: Wed, 6 Sep 2006 09:19:07 -0400
To: SE Linux <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I just tried a current checkout of refpolicy from the tresys svn and  
it works with the current userland tools so I'll just use that...

  - todd

On Sep 5, 2006, at 4:57 PM, Todd Miller wrote:

> In trying to build refpolicy-20060307 on an FC5 machine using an  
> selinux userland with the following svn tags: checkpolicy_1_30_11  
> libselinux_1_30_27 libsemanage_1_6_15 libsepol_1_12_26  
> policycoreutils_1_30_28 I get this error:
>
> /usr/bin/checkpolicy policy.conf -o policy.21
> /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> libsepol.expand_terule_helper: duplicate TE rule for initrc_t  
> insmod_exec_t:process insmod_t
> libsepol.expand_module: Error during expand
> Error while expanding policy
> make: *** [policy.21] Error 1
>
> The selinux userland components that ship with FC5 are able to  
> build the policy.conf into a binary file without problems.  Is  
> there a newer version of refpolicy that folks are using for  
> development?
>
> Thanks!
>
>  - todd
>
> --
> This message was distributed to subscribers of the selinux mailing  
> list.
> If you no longer wish to subscribe, send mail to  
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
