Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m52GLq4o005511
	for <selinux@tycho.nsa.gov>; Mon, 2 Jun 2008 12:21:52 -0400
Received: from wr-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m52GLoxv013222
	for <selinux@tycho.nsa.gov>; Mon, 2 Jun 2008 16:21:51 GMT
Received: by wr-out-0506.google.com with SMTP id c30so312718wra.21
        for <selinux@tycho.nsa.gov>; Mon, 02 Jun 2008 09:21:50 -0700 (PDT)
Message-ID: <dd18b0c30806020921t532fc16fk3b6b70c21c7f83a7@mail.gmail.com>
Date: Mon, 2 Jun 2008 16:21:30 +0000
From: "Justin Mattock" <justinmattock@gmail.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: changing role to user_r
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1212408586.31546.69.camel@gorn>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <dd18b0c30805302311n7daac8e9ob6d818860e545b08@mail.gmail.com>
	 <1212408586.31546.69.camel@gorn>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Jun 2, 2008 at 12:09 PM, Christopher J. PeBenito
<cpebenito@tresys.com> wrote:
> On Sat, 2008-05-31 at 06:11 +0000, Justin Mattock wrote:
>> Hello, I'm running an experiment with SELinux and seem to be at a crux
>> with changing roles:
>> newrole -r user_r
>> I get a permission denied, the allow rule is this: allow newrole_t
>> user_t:process transition;
>> I don't have a problem changing to sysadm_r any thoughts on what I'm missing?
>
> Sounds like your user is staff_u or root.  Neither users are allowed
> user_r.
>
> --
> Chris PeBenito
> Tresys Technology, LLC
> (410) 290-1411 x150
>
>

Yeah after reading some post's about xserver, I decided to see if I
could startx in staff_r, everything was fine except for changing to
user_r to use firefox, and so forth. Keep in mind this was just a test
to see, Overall I don't have a problem keeping what I have now.
And it also makes sense about what you had said "Neither users are allowed".
regards

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
