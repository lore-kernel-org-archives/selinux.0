Message-ID: <1348234708.9436.12.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: seandroid 4.1.1
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alexandra Test <testalexandrainstitute@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Fri, 21 Sep 2012 09:38:28 -0400
In-Reply-To: <CAKi3Puq_+QXKKR+YoNJ1M0niBtdOGJY5JuRV9nP0cnjsAB3qEw@mail.gmail.com>
References: 
	<CAKi3PupyLSM2UktjTaS8U-WKmiRSpRdSJApn2vRETfEx83qNfg@mail.gmail.com>
	 <1347988424.31966.56.camel@moss-pluto.epoch.ncsc.mil>
	 <CAKi3Puqw0r=d31S+8N5_=JDN4_bK3TH2EODogOfAxTFxvDsdpg@mail.gmail.com>
	 <1348145727.13835.5.camel@moss-pluto.epoch.ncsc.mil>
	 <CAKi3PuokYYQxCwf+SGga7UuguXBR14ZSneFMOfFQ-g0qX5btMA@mail.gmail.com>
	 <1348149606.13835.21.camel@moss-pluto.epoch.ncsc.mil>
	 <CAKi3Puo9rREhxm_CTEYaRJtZJKf2XdK=EO0-jjDE+cQ12g-Zrg@mail.gmail.com>
	 <1348152509.13835.23.camel@moss-pluto.epoch.ncsc.mil>
	 <CAKi3Puq_+QXKKR+YoNJ1M0niBtdOGJY5JuRV9nP0cnjsAB3qEw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-09-21 at 10:05 +0200, Alexandra Test wrote:
> The output of 
> adb shell
> su
> dmesg
> 
> is 
> 
> "klogctl: Operation not permitted"

That suggests that su didn't work for you?  Earlier you indicated that
your su program is not the stock AOSP one but rather one from
Superuser.apk.  I'd recommend building a stock SE Android image without
Superuser.apk.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
