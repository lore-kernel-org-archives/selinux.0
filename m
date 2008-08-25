Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7PDM4ub026697
	for <selinux@tycho.nsa.gov>; Mon, 25 Aug 2008 09:22:04 -0400
Received: from mail.wrs.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7PDLaGa006991
	for <selinux@tycho.nsa.gov>; Mon, 25 Aug 2008 13:21:36 GMT
Message-ID: <48B2B1BA.5040907@windriver.com>
Date: Mon, 25 Aug 2008 09:20:58 -0400
From: Vikram Ambrose <Vikram.Ambrose@windriver.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: PAM security transitions
References: <48AF21C3.9020506@windriver.com> <200808231150.37055.russell@coker.com.au>
In-Reply-To: <200808231150.37055.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> On Saturday 23 August 2008 06:29, Vikram Ambrose 
> <Vikram.Ambrose@windriver.com> wrote:
>   
>> I've been messing around with various modules and installations and I've
>> come across a strange PAM problem. Without any SELinux support in
>> pam.d/login, root's shell gets system_r:local_login_t
>>     
>
> Yes, ages ago it was decided not to maintain patches for the various terminal 
> login programs and to instead use a PAM module.
>
>   
>> But then using: pam_selinux.so close/open, root's shell gets
>> root:staff_r:system_chkpwd_t
>>     
>
> I think that was a policy bug, it's fixed if you use all the latest versions.
>
> What version of the policy is running on the machines in question?
>
>   
Strange, that box is running the latest. Refpolicy svn-2787 and Selinux 
svn-2950

Could you tell me a little more about that bug, and how it came about?

Vikram

-- 
Vikram Ambrose | Linux Products Division | WindRiver Corporation


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
