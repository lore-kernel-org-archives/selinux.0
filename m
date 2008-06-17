Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5HIT3S7014437
	for <selinux@tycho.nsa.gov>; Tue, 17 Jun 2008 14:29:03 -0400
Received: from yw-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5HIT2eu026674
	for <selinux@tycho.nsa.gov>; Tue, 17 Jun 2008 18:29:03 GMT
Received: by yw-out-1718.google.com with SMTP id 6so3349071ywa.84
        for <selinux@tycho.nsa.gov>; Tue, 17 Jun 2008 11:28:58 -0700 (PDT)
Message-ID: <48580267.7000309@gmail.com>
Date: Tue, 17 Jun 2008 13:28:55 -0500
From: Ted X Toth <txtoth@gmail.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: gnome-screensav AVCs
References: <cadfc0e40806170746p6de7c1b7m6c27ca74ae0ca183@mail.gmail.com>	 <1213717150.11146.88.camel@gorn>	 <cadfc0e40806170855hf95edf4vdefe9b9710cadfb6@mail.gmail.com> <1213723428.11146.93.camel@gorn>
In-Reply-To: <1213723428.11146.93.camel@gorn>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Tue, 2008-06-17 at 10:55 -0500, Xavier Toth wrote:
>   
>> On Tue, Jun 17, 2008 at 10:39 AM, Christopher J. PeBenito
>> <cpebenito@tresys.com> wrote:
>>     
>>> On Tue, 2008-06-17 at 09:46 -0500, Xavier Toth wrote:
>>>       
>>>> I'm seeing AVCs related to netlink_audit_socket when the screen saver
>>>> dialog is run. gnome-screensaver-dialog opens a pam session which uses
>>>> pam_unix which in turn runs the unix_chkpwd helper. I'm thinking that
>>>> gnome-screensaver-dialog is going to need some policy including
>>>> possibly authlogin_common_auth_domain_template.
>>>>         
>>> I'm not 100% clear, is the auditing happening from unix_chkpwd or the
>>> screensaver proper?
>>>
>>>       
>> I'm sure that it is unix_chkpwd that is auditing and not
>> gnome-screensaver-dialog.
>>     
>
> Is gnome-screensaver-dialog not running the user domain?
I believe this is true.

>   I would have
> expected that it was, and that when unix_chkpwd is run, that it
> transitions to *_unix_chkpwd_t, which should be able to send audit
> messages.
>
>   
You know policy better than I, where is the policy for this?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
