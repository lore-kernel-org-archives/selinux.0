Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m52HEUTi015992
	for <selinux@tycho.nsa.gov>; Mon, 2 Jun 2008 13:14:30 -0400
Received: from yx-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m52HETxv010931
	for <selinux@tycho.nsa.gov>; Mon, 2 Jun 2008 17:14:30 GMT
Received: by yx-out-1718.google.com with SMTP id 3so84963yxi.84
        for <selinux@tycho.nsa.gov>; Mon, 02 Jun 2008 10:14:29 -0700 (PDT)
Message-ID: <dd18b0c30806021014w1e3de465ve8448f3a7a13be53@mail.gmail.com>
Date: Mon, 2 Jun 2008 17:14:29 +0000
From: "Justin Mattock" <justinmattock@gmail.com>
To: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>
Subject: Re: changing role to user_r
Cc: selinux@tycho.nsa.gov
In-Reply-To: <0794F277152EF94AA637E3AECF5CB70FB9E3C3@blums0042.bluelnk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <dd18b0c30805302311n7daac8e9ob6d818860e545b08@mail.gmail.com>
	 <0794F277152EF94AA637E3AECF5CB70FB9E3C3@blums0042.bluelnk.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Jun 2, 2008 at 4:38 PM, Clarkson, Mike R (US SSA)
<mike.clarkson@baesystems.com> wrote:
> Which SELinux user are you logging in as?
>
> When you type "semanage user -l", does that user list user_r as one of
> its available roles? If not, you won't be able to change to user_r
>
>> -----Original Message-----
>> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]
> On
>> Behalf Of Justin Mattock
>> Sent: Friday, May 30, 2008 11:11 PM
>> To: selinux@tycho.nsa.gov
>> Subject: changing role to user_r
>>
>> Hello, I'm running an experiment with SELinux and seem to be at a crux
>> with changing roles:
>> newrole -r user_r
>> I get a permission denied, the allow rule is this: allow newrole_t
>> user_t:process transition;
>> I don't have a problem changing to sysadm_r any thoughts on what I'm
>> missing?
>>
>> --
>> Justin P. Mattock
>>
>> --
>> This message was distributed to subscribers of the selinux mailing
> list.
>> If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov
>> with
>> the words "unsubscribe selinux" without quotes as the message.
>
>

initially I log in as sysadm_r, and then change roles for particular
applications.
as for policy style I'm not using binary, I'm using monolithic

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
