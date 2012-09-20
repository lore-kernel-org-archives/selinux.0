Message-ID: <1348153961.13835.26.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: seandroid 4.1.1
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Radzykewycz, T (Radzy)" <radzy@windriver.com>
Cc: Alexandra Test <testalexandrainstitute@gmail.com>,
        "selinux@tycho.nsa.gov"
	 <selinux@tycho.nsa.gov>
Date: Thu, 20 Sep 2012 11:12:41 -0400
In-Reply-To: <33006C99F5A5194A9B7A7715DFA3E383651A15A2@ALA-MBA.corp.ad.wrs.com>
References: 
	<CAKi3PupyLSM2UktjTaS8U-WKmiRSpRdSJApn2vRETfEx83qNfg@mail.gmail.com>
	 <1347988424.31966.56.camel@moss-pluto.epoch.ncsc.mil>
	 <CAKi3Puqw0r=d31S+8N5_=JDN4_bK3TH2EODogOfAxTFxvDsdpg@mail.gmail.com>
	 <1348145727.13835.5.camel@moss-pluto.epoch.ncsc.mil>
	 <CAKi3PuokYYQxCwf+SGga7UuguXBR14ZSneFMOfFQ-g0qX5btMA@mail.gmail.com>
	 <1348149606.13835.21.camel@moss-pluto.epoch.ncsc.mil>
	 <CAKi3Puo9rREhxm_CTEYaRJtZJKf2XdK=EO0-jjDE+cQ12g-Zrg@mail.gmail.com>
	 <33006C99F5A5194A9B7A7715DFA3E383651A15A2@ALA-MBA.corp.ad.wrs.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-09-20 at 14:48 +0000, Radzykewycz, T (Radzy) wrote:
> Try using “adb shell dmesg” or “adb shell –c dmesg” or “adb shell su –
> c dmesg” or “adb shell su 0 –c dmesg”

With 4.1/master, dmesg will only work for root, which is why you have to
su first.

This is controlled by /proc/sys/kernel/dmesg_restrict, which is set to 1
by the init.rc file in 4.1 and master.  Only for kernels which support
it, of course, which would be 2.6.38 and later.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
