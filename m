Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n37GP1lT003242
	for <selinux@tycho.nsa.gov>; Tue, 7 Apr 2009 12:25:01 -0400
Received: from mail-ew0-f177.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n37GP0bv021066
	for <selinux@tycho.nsa.gov>; Tue, 7 Apr 2009 16:25:00 GMT
Received: by ewy25 with SMTP id 25so3239484ewy.18
        for <selinux@tycho.nsa.gov>; Tue, 07 Apr 2009 09:24:59 -0700 (PDT)
Subject: Re: Is there strict policy for fedora 10?
From: Dominick Grift <domg472@gmail.com>
To: sixiaolin0 <sixiaolin067@126.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <17972721.991111239117863388.JavaMail.coremail@bj126app30.126.com>
References: 
	 <17972721.991111239117863388.JavaMail.coremail@bj126app30.126.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 07 Apr 2009 18:24:58 +0200
Message-Id: <1239121498.5002.7.camel@notebook2.grift.internal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-04-07 at 23:24 +0800, sixiaolin0 wrote:
> 
> 
> hello everyone!
>   I want to ask  if there is strict policy for FC10.

The strict policy module and the targeted policy module merged.
You can now enjoy the strict functionality in Fedoras'
selinux-policy-targeted.

>  
>   And could you tell me where and  how I can see the policy file
> without using a policy tools?

You can download the source RPM, prepare it and view it with your
favorite editor

wget
http://kojipkgs.fedoraproject.org/packages/selinux-policy/3.5.13/55.fc10/src/selinux-policy-3.5.13-55.fc10.src.rpm

tar -xzvf selinux-policy-3.5.13-55.fc10.src.rpm

cp selinux-policy-3.5.13-55.fc10.src/*patch .; cp
selinux-policy-3.5.13-55.fc10.src/*.tgz .

tar -xzvf seref*.tgz

patch -p0 <*.patch

cd serefpolicy*


> thank you very much!
>   
> 
> 
> 
> ______________________________________________________________________
> 网易邮箱，中国第一大电子邮件服务商


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
