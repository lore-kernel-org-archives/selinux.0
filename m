Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHlINH015539
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:47:18 -0400
Received: from wa-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHlH2p010222
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:47:17 GMT
Received: by wa-out-1112.google.com with SMTP id v27so1300062wah
        for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 10:47:17 -0700 (PDT)
Message-ID: <6c18a4f0705301047pf0cd360i434bf5d85cdf38e5@mail.gmail.com>
Date: Wed, 30 May 2007 19:47:16 +0200
From: "Bernd Bartmann" <bernd.bartmann@gmail.com>
To: "Daniel J Walsh" <dwalsh@redhat.com>
Subject: Re: Centos 5 OpenVPN / SElinux
Cc: "CentOS mailing list" <centos@centos.org>, selinux@tycho.nsa.gov
In-Reply-To: <465DB770.8050903@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <6c18a4f0705301003xc08b41dsd871345a20197cd@mail.gmail.com>
	 <465DB770.8050903@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 5/30/07, Daniel J Walsh <dwalsh@redhat.com> wrote:
> Easiest thing to do is update policy with these two rules.
>
> # grep openvpn /var/log/audit/audit.log | audit2allow -M myopenvpn
> # semodule -i myopenvpn.pp
>
> This will add the following rules:
> allow openvpn_t pppd_t:fd use;
> allow openvpn_t self:process execstack;
>
> The pppd_t:fd is probably a leaked file descriptor and could probably be
> dontaudited.
> The execstack is potentially a problem in openvpn_t.  This is probably a
> coding problem and should be reported as a bug/

Daniel, do you mean a bug in SElinux or OpenVPN?

Best regards,
Bernd.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
