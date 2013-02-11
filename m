Message-ID: <51193FDB.5030506@tycho.nsa.gov>
Date: Mon, 11 Feb 2013 14:00:43 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Brian_Iv=E1n_Mart=EDnez?= <xangelux@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: pam_selinux
References: <CACcxAnHapENU25rsrcjijfdVNdvp9yyGBvVDys=pBg_qssPLGg@mail.gmail.com>
In-Reply-To: <CACcxAnHapENU25rsrcjijfdVNdvp9yyGBvVDys=pBg_qssPLGg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 02/09/2013 02:21 PM, Brian Iván Martínez wrote:
> Hi, first time mailer here.
>
> Lately I've grown curious about SELinux and I would like to be able to
> install it on my Archlinux. There are packages in the AUR repo but those
> are from before glibc-2.16, with the update the packages broke. I have
> successfully build and installed libselinux and libsepol  but now it's
> turn for pam with selinux enabled which fails with the complain that it
> doesn't know rlim size in the pam_unix_passwd.c file.
>
> I posted this in the G+ group trying to figure out if is a bug in pam or
> in SELinux and the guys there told me to post it here.
>
> The AUR package I try to use to build pam is
> https://aur.archlinux.org/packages/selinux-pam/ .

Can you post the actual error output?  And provide more details about 
what versions you are using?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
