Message-ID: <4A1374D5.6080504@tycho.nsa.gov>
Date: Tue, 19 May 2009 23:11:17 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Dominick Grift <domg472@gmail.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SELinux@tycho.nsa.gov,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: avc: denied null
References: <1242641994.470.5.camel@notebook2.grift.internal>	 <1242651013.29973.197.camel@localhost.localdomain> <1242651553.1057.0.camel@notebook2.grift.internal>
In-Reply-To: <1242651553.1057.0.camel@notebook2.grift.internal>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dominick Grift wrote:
> On Mon, 2009-05-18 at 08:50 -0400, Stephen Smalley wrote:
>   
>> rpm -q -f /usr/bin/Xorg /etc/selinux
>>     
>
> xorg-x11-server-Xorg-1.6.1-11.fc11.x86_64
> selinux-policy-3.6.12-36.fc11.noarch
>   

I found the cause of the "x_device" null avc's.  It was a bad hook call.

I'm still stumped on the GLXMakeCurrent null avc's though.  I can't
reproduce the problem here running glxinfo/glxgears.  I suspect it
depends on the video driver / acceleration architecture being used.


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
