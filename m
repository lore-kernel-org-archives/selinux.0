Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o179vbmQ016125
	for <selinux@tycho.nsa.gov>; Sun, 7 Feb 2010 04:57:37 -0500
Received: from mail-pz0-f179.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o179vQ1t022085
	for <selinux@tycho.nsa.gov>; Sun, 7 Feb 2010 09:57:26 GMT
Received: by pzk9 with SMTP id 9so519009pzk.30
        for <selinux@tycho.nsa.gov>; Sun, 07 Feb 2010 01:57:35 -0800 (PST)
Message-ID: <4B6E8EF5.3010608@gmail.com>
Date: Sun, 07 Feb 2010 01:59:17 -0800
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Elko Kuric <elkokuric@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: Selinux in enforcing mode prevent network interface to be 	configured
 at boot for Debian stable ( 5.0)
References: <bf30b281002070012q1d9a33ffsc90781d217e05f9b@mail.gmail.com>	 <4B6E7CE0.1050107@gmail.com> <bf30b281002070131l4821a6abg45a3cbc3d01a08e6@mail.gmail.com>
In-Reply-To: <bf30b281002070131l4821a6abg45a3cbc3d01a08e6@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Thanks for mail. I have installed following packages
>
> dpkg -l | grep ii | grep selinux
>
> ii  libselinux1                       2.0.65-5                 SELinux
> shared libraries
> ii  python-selinux                    2.0.65-5                 Python
> bindings to SELinux shared libraries
> ii  selinux-basics                    0.3.5                    SELinux
> basic support
> ii  selinux-policy-default            2:0.0.20080702-6         Strict
> and Targeted variants of the SELinux policy
> ii  selinux-utils                     2.0.65-5                 SELinux
> utility programs
>
>
> I expected some issues with setting up some specific services (
> dns/mail ... ), but here I just want to get network
> functional once I set selinux to "enforcing " policy.
>
> Elko
>

what does audit2allow -d say?

if nothing the do a
sudo /usr/sbin/semodule -DB
(reboot)
then what does audit2allow say?
should give you some allow rules
if so add them to your policy.

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
