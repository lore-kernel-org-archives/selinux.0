Message-ID: <1382205821.3041.37.camel@d30>
Subject: Re: Update to CIL
From: Dominick Grift <dominick.grift@gmail.com>
To: James Carter <jwcart2@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>,
        Steve Lawrence
 <slawrence@tresys.com>,
        Richard Haines <richard_c_haines@btinternet.com>,
        dwalsh <dwalsh@redhat.com>
Date: Sat, 19 Oct 2013 20:03:41 +0200
In-Reply-To: <1382189566.3041.34.camel@d30>
References: <52617C02.4060500@tycho.nsa.gov> <1382126564.3041.13.camel@d30>
	 <1382189566.3041.34.camel@d30>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2013-10-19 at 15:32 +0200, Dominick Grift wrote:

> Been playing with this today and so far so good except for a few things:
> 
> Not sure if its due to my incompetence or due to the line i removed
> ( see above) from cil.c, login programs (pam) is not able to get a valid
> context for my users. I believe i set all the associations up properly

i think libselinux is broken (again) in Fedora:

https://www.youtube.com/watch?v=eKbzSCGL3V4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
