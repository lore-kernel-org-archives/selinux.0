Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9E5qQxB029099
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2008 01:52:26 -0400
Received: from wf-out-1314.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9E5p9wV008498
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2008 05:51:09 GMT
Received: by wf-out-1314.google.com with SMTP id 28so2982871wff.30
        for <selinux@tycho.nsa.gov>; Mon, 13 Oct 2008 22:52:25 -0700 (PDT)
Message-ID: <dd18b0c30810132252vaf0ccb1i1f5f878dcab741d8@mail.gmail.com>
Date: Mon, 13 Oct 2008 22:52:25 -0700
From: "Justin Mattock" <justinmattock@gmail.com>
To: russell@coker.com.au
Subject: Re: gdm ubuntu 8.10
Cc: "SE Linux" <selinux@tycho.nsa.gov>
In-Reply-To: <200810141458.32532.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <dd18b0c30810112056r5c107307jbcab88d07a382233@mail.gmail.com>
	 <dd18b0c30810121424k5aa67d2me25d451166279706@mail.gmail.com>
	 <dd18b0c30810132048s7b1d0263xea6d86bbd6dbee35@mail.gmail.com>
	 <200810141458.32532.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Oct 13, 2008 at 8:58 PM, Russell Coker <russell@coker.com.au> wrote:
> On Tuesday 14 October 2008 14:48, "Justin Mattock" <justinmattock@gmail.com>
> wrote:
>> So after using user_r(which I feel is more safe);
>> I'm noticing I can't login to sysadm_r.
>
> That is by design, role transitions to sysadm_r are only permitted from
> staff_r, system_r, and unconfined_r.
>
>> This role seems to be safe in a corporate environment,
>> but in my case I'm the only user on this machine as well as
>> the admin.
>
> Then staff_r may be a better choice for your logins.
>
> Of course there's nothing stopping you from using a ssh client in user_r to
> connect to a staff_r session (or sysadm_r if you set a boolean to allow
> sysadm_r ssh logins).
>
> --
> russell@coker.com.au
> http://etbe.coker.com.au/          My Blog
>
> http://www.coker.com.au/sponsorship.html Sponsoring Free Software development
>

At the moment I'm just booting the system into
the given context. ("I've been putting off starting SELinux
with a desktop-manager")
As for runing in user_r; seems to be a better choice
but if I have to do any compiling or editing I have to reboot and put
SELinux into permissive mode to do so.(unless its possible to run the
system in user_r
then use newrole to change to sysadm to make any kind of adjustments).
As for ssh, I did notice a few weeks ago
that my machine I was ssh'ing into was put into user_r by default.
If I had no way of disabling the policy on the local machine it would of been
next to impossible to make any kind of adjustments, making the argument
of running in staff_r probably the right choice for capturing any kind
of debug logs and
so forth, in a safe and secure environment.


-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
