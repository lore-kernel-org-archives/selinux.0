Message-ID: <4B7D8806.4070107@gmail.com>
Date: Thu, 18 Feb 2010 10:33:42 -0800
From: "Justin P. mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Alan Rouse <alan.rouse@ericsson.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: SELinux Policy in OpenSUSE 11.2
References: <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>	 <1266347411.5252.107.camel@moss-pluto.epoch.ncsc.mil>	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5587DD@EUSAACMS0703.eamcs.ericsson.se>	 <1266349121.5252.131.camel@moss-pluto.epoch.ncsc.mil>	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5588F8@EUSAACMS0703.eamcs.ericsson.se>	 <4B7B21A2.3080006@gmail.com> <4B7B97D4.7020005@gmail.com>	 <5A5E55DF96F73844AF7DFB0F48721F0F529A558C9F@EUSAACMS0703.eamcs.ericsson.se>	 <1266425895.4945.105.camel@moss-pluto.epoch.ncsc.mil>	 <5A5E55DF96F73844AF7DFB0F48721F0F529A780180@EUSAACMS0703.eamcs.ericsson.se>	 <1266433081.4945.112.camel@moss-pluto.epoch.ncsc.mil>	 <5A5E55DF96F73844AF7DFB0F48721F0F529A780232@EUSAACMS0703.eamcs.ericsson.se>	 <1266436724.4945.122.camel@moss-pluto.epoch.ncsc.mil>	 <4B7C4D0C.7050204@gmail.com> <1266438101.4945.133.camel@moss-pluto.epoch.ncsc.mil> <4B7C7A48.4030506@gmail.com> <5A5E55DF96F73844AF7DFB0F48721F0F529A7806D6@EUSAACMS0703.eamcs.ericss!
 on.se>
In-Reply-To: <5A5E55DF96F73844AF7DFB0F48721F0F529A7806D6@EUSAACMS0703.eamcs.ericsson.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 02/18/2010 07:17 AM, Alan Rouse wrote:
> Justin wrote:
>> In any case I looked for there refpolicy source and could not see/find.
>
> http://software.opensuse.org/search?baseproject=openSUSE%3A11.2&p=1&q=selinux-policy
>
> Download selinux-policy-2.20081210-3.1.src.rpm from that page.
>
>
>

cool thanks..
I used refpolicy-20081014.tar.bz2
which is pretty much similar to what they have.

I'll see if I can get into the correct context
and then go from there.

only concern is the "targeted" issue

A) did they plan for this i.g. a symlink or something
as an extra way for something.

B) libselinux is really going out of whack, and defaulting to
targeted.

I can update the userspace tools, but kind of wanted to avoid
adding anything(leave it as pure to the distro as can be).
but then again maybe it needs it.

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
