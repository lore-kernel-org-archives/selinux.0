Subject: Re: avc: denied null
From: Dominick Grift <domg472@gmail.com>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux@tycho.nsa.gov,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <4A1374D5.6080504@tycho.nsa.gov>
References: <1242641994.470.5.camel@notebook2.grift.internal>
	 <1242651013.29973.197.camel@localhost.localdomain>
	 <1242651553.1057.0.camel@notebook2.grift.internal>
	 <4A1374D5.6080504@tycho.nsa.gov>
Content-Type: text/plain
Date: Wed, 20 May 2009 13:08:36 +0200
Message-Id: <1242817716.14664.3.camel@notebook2.grift.internal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-05-19 at 23:11 -0400, Eamon Walsh wrote:

> I found the cause of the "x_device" null avc's.  It was a bad hook call.
> 
> I'm still stumped on the GLXMakeCurrent null avc's though.  I can't
> reproduce the problem here running glxinfo/glxgears.  I suspect it
> depends on the video driver / acceleration architecture being used.

For what it is worth, that particular system has nvidia geforce 8600M GT and is using the proprietary blob (kmod-nvidia)

Thanks


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
