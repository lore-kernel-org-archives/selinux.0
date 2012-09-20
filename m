Message-ID: <1348149606.13835.21.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: seandroid 4.1.1
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alexandra Test <testalexandrainstitute@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Thu, 20 Sep 2012 10:00:06 -0400
In-Reply-To: <CAKi3PuokYYQxCwf+SGga7UuguXBR14ZSneFMOfFQ-g0qX5btMA@mail.gmail.com>
References: 
	<CAKi3PupyLSM2UktjTaS8U-WKmiRSpRdSJApn2vRETfEx83qNfg@mail.gmail.com>
	 <1347988424.31966.56.camel@moss-pluto.epoch.ncsc.mil>
	 <CAKi3Puqw0r=d31S+8N5_=JDN4_bK3TH2EODogOfAxTFxvDsdpg@mail.gmail.com>
	 <1348145727.13835.5.camel@moss-pluto.epoch.ncsc.mil>
	 <CAKi3PuokYYQxCwf+SGga7UuguXBR14ZSneFMOfFQ-g0qX5btMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-09-20 at 15:57 +0200, Alexandra Test wrote:
> I don't have any denials.
> If I change in enforcing mode with the wifi still connected, the wifi
> works. 
> But if, in the enforcing mode, I disconnect it and try to reconnect
> it, it doesn't : he says "obtaining IP address", "connecting", "saved"
> at the end without being connected... 

No avc: or SELinux: messages in dmesg output when it fails?

I suppose it could be hidden by a dontaudit rule.  You could try
stripping those from your policy and see if you get anything.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
