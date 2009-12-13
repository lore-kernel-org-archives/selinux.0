Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nBDKNOEj004424
	for <selinux@tycho.nsa.gov>; Sun, 13 Dec 2009 15:23:27 -0500
Received: from mail-pz0-f174.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id nBDKMH53011538
	for <selinux@tycho.nsa.gov>; Sun, 13 Dec 2009 20:22:17 GMT
Received: by pzk4 with SMTP id 4so1694670pzk.32
        for <selinux@tycho.nsa.gov>; Sun, 13 Dec 2009 12:23:23 -0800 (PST)
Message-ID: <4B254D52.1080602@gmail.com>
Date: Sun, 13 Dec 2009 12:23:46 -0800
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Guido Trentalancia <guido@trentalancia.com>
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: avc's generated causes the system to freeze up
References: <dd18b0c30912111344j65436d86h85f8d74e752e19af@mail.gmail.com>	 <1260722550.2858.13.camel@tesla.lan>  <4B252E41.6070501@gmail.com> <1260733223.2858.23.camel@tesla.lan>
In-Reply-To: <1260733223.2858.23.camel@tesla.lan>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/13/09 11:40, Guido Trentalancia wrote:
> Have you tried tuning auditd and its dispatcher which could be audispd ?
>
> So for example, try feeding audispd with the following options:
>
> q_depth: increase it from its default value (which is 80 on Redhat's
> recent auditd)
> priority_boost = 0
>
> Finally, if things don't improve, you could also try:
>
> overflow_action = suspend
>
> Other than this I don't know how to help. Good luck.
>
>

well right now I dont really use auditd i.g.
the libraries are there but the daemon is off.
(I am not using fedora/redhat).

In any case it's not a worry because I can go ahead and add the
allow rules,  moreover the main issue is the spamming
of log message which might/could result in some buffer thing
reason for wanting info if there is a mechanism
like printk_ratelimit etc.. for Xorg.0.log

Justin P. Mattock




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
