Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nBEHF0rT005131
	for <selinux@tycho.nsa.gov>; Mon, 14 Dec 2009 12:15:00 -0500
Received: from mail-fx0-f226.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id nBEHHLJE029161
	for <selinux@tycho.nsa.gov>; Mon, 14 Dec 2009 17:17:21 GMT
Received: by fxm26 with SMTP id 26so3651233fxm.19
        for <selinux@tycho.nsa.gov>; Mon, 14 Dec 2009 09:14:57 -0800 (PST)
Message-ID: <4B2672A6.50906@gmail.com>
Date: Mon, 14 Dec 2009 09:15:18 -0800
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Guido Trentalancia <guido@trentalancia.com>
CC: SE-Linux <selinux@tycho.nsa.gov>, xorg <xorg@freedesktop.org>,
        refpolicy@oss1.tresys.com
Subject: Re: avc's generated causes the system to freeze up
References: <dd18b0c30912111344j65436d86h85f8d74e752e19af@mail.gmail.com>	 <1260722550.2858.13.camel@tesla.lan>  <4B252E41.6070501@gmail.com>	 <1260733223.2858.23.camel@tesla.lan>  <4B254D52.1080602@gmail.com>	 <1260784575.2853.17.camel@tesla.lan>  <4B2663A2.6090608@gmail.com> <1260807309.2853.55.camel@tesla.lan>
In-Reply-To: <1260807309.2853.55.camel@tesla.lan>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/14/09 08:15, Guido Trentalancia wrote:
> Auditctl should operate at kernel-level. But this topics are all
> off-theme from SELinux. You shouldn't post audit questions to a SELinux
> mailing list.
>
>


Probably should be refpolicy, and Xorg
because this pertains to
XACE, but you took these cc's off the e-mail!

Anyways, as for auditd keep in mind this has todo with
Xorg.0.log, nothing todo with anything
in /var/log/messages, or any other log message
that auditd reads(and remember I don't have auditd turned on).

So lets try again:

I'm running X.Org X Server 1.7.99.2
after building the latest refpolicy
and defining my allow rules(all of them as possible),
I seem to have some of them show up later in time.
(which is normal).

The problem that I have is on some occasions these
denials that show up long after I have defined as many
allow rules as possible, seem to be spamming my
Xorg.0.log, until I define them into the policy
with audit2allow.

my question is, is there a mechanism similar to printk_ratelimit
for Xorg.0.log so when this happens my Xorg.0.log
does not become spammed with one avc denial
causing my system to freeze up, until the avc denial has
done registering all of it's denials or I allow it into the policy?


Justin P. mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
