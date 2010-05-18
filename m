Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o4I92oCo004654
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2010 05:02:50 -0400
Received: from mail-pv0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o4I929ke013462
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2010 09:02:10 GMT
Received: by pvf33 with SMTP id 33so266194pvf.12
        for <selinux@tycho.nsa.gov>; Tue, 18 May 2010 02:02:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTinUIhCQPkHUe9YKRfE7JSktW84bhUjGkL1spibb@mail.gmail.com>
References: <BAY111-W21E4613ED1D1458B53C3A6ABE10@phx.gbl>
	 <AANLkTinUIhCQPkHUe9YKRfE7JSktW84bhUjGkL1spibb@mail.gmail.com>
Date: Tue, 18 May 2010 14:02:48 +0500
Message-ID: <AANLkTinQAB13RzO7cHsFBkbiVvfsXJiIMjmHSWXMXxV-@mail.gmail.com>
Subject: Re: How to cross install policy store?
From: Shaz <shazalive@gmail.com>
To: TaurusHarry <harrytaurus2002@hotmail.com>,
        selinux-mailing-list <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

2010/5/18 waqar afridi <afridi.waqar@gmail.com>:
> Try to create Virtual Memory...
>
> 2010/5/18 TaurusHarry <harrytaurus2002@hotmail.com>
>>
>> HI SELinux experts,
>>
>> I am trying to use SELinux on an ARM board with limited RAM <=128m, if I
>> use semodule tool to create policy store on the target it will be terminated
>> by kernel OOM killer. Normally semodule tool will install the policy store
>> on the host, is it possible to cross-install the policy store to the target
>> rootfs image on the host?

We are doing the same but cross compiled the libraries and building
the policy natively on the device/board. Memory is a big problem. We
moved ahead with creating swap memory but still lots of issues.

Now we are trying to reduce the modules to be built. Still having
problems .... policy.kern does not exist ... weird stuff! We are
planning to document our efforts once we go through the policy build
and runtime tests.

-- 
Shaz

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
