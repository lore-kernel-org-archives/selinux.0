Message-ID: <511951CC.1000607@tycho.nsa.gov>
Date: Mon, 11 Feb 2013 15:17:16 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Brian_Iv=E1n_Mart=EDnez?= <xangelux@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: systemd selinux
References: <CACcxAnHapENU25rsrcjijfdVNdvp9yyGBvVDys=pBg_qssPLGg@mail.gmail.com> <51193FDB.5030506@tycho.nsa.gov> <CACcxAnH-j-A0SkZvsbV7OLpD8o9CfeOu_UmyYTdcKEmjXpxyTQ@mail.gmail.com> <511946AB.10802@tycho.nsa.gov> <CACcxAnHzphj13zgYvkVOu-kptpf5zwR2YN6aY6AtpQ6WwPvAmA@mail.gmail.com>
In-Reply-To: <CACcxAnHzphj13zgYvkVOu-kptpf5zwR2YN6aY6AtpQ6WwPvAmA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 02/11/2013 02:31 PM, Brian Iván Martínez wrote:
> yes, I have a /usr/lib/pkgconfig/libselinux.pc , mm I'm using a 64bit
> system, does that matter?

Don't think so.  I think that is just a difference between Arch and 
Fedora - 32-bit in /usr/lib32 and 64-bit in /usr/lib vs 32-bit in 
/usr/lib and 64-bit in /usr/lib64.

What does:
$ pkg-config --print-errors libselinux
$ echo $?

display?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
