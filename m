Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3SFT8Pa025744
	for <selinux@tycho.nsa.gov>; Tue, 28 Apr 2009 11:29:08 -0400
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3SFT7Fe011659
	for <selinux@tycho.nsa.gov>; Tue, 28 Apr 2009 15:29:07 GMT
Message-ID: <49F720B9.1000603@redhat.com>
Date: Tue, 28 Apr 2009 11:28:57 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: sixiaolin0 <sixiaolin067@126.com>
CC: selinux <selinux@tycho.nsa.gov>
Subject: Re: the system can't be started after I configure the
References: <2194562.1294281240931146322.JavaMail.coremail@bj126app30.126.com>
In-Reply-To: <2194562.1294281240931146322.JavaMail.coremail@bj126app30.126.com>
Content-Type: text/plain; charset=x-gbk; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 04/28/2009 11:05 AM, sixiaolin0 wrote:
> hello everyone:
>   After I had installed the refpolicy in my fedora 10 system,when I change the configure file pocicy form target to refpolicy ,the system can't start!
> I don't konw why!
> Waiting for your help!
Why would you switch from targeted to Refpolicy?  F10 policy is 
Refpolicy with a huge amount of patches and selection of the proper 
modules.  refpolicy is not built to run on F10.  You would need to 
become familiar with the way policy works and F10 in order to make it work.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
