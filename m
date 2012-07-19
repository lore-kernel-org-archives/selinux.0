Message-ID: <1342704292.31048.17.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: seapp_contexts boolean support
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Thu, 19 Jul 2012 09:24:52 -0400
In-Reply-To: <CAFftDdoGP=DTE7Z+y3haF=7FtKZ6iopDBxMctUZ2-NzzSRBB_A@mail.gmail.com>
References: 
	<CAFftDdoGP=DTE7Z+y3haF=7FtKZ6iopDBxMctUZ2-NzzSRBB_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-07-18 at 18:28 -0700, William Roberts wrote:
> I was thinking of adding support to enable seboolean control over
> seapp_contexts. We have had to make a weird change to seapp_contexts
> for CTS and it would be nice if that only got pulled in and used when
> the CTS boolean is enabled.
> 
> 
> I was thinking is could work like this:
> 
> 
> seapp_contexts would have an additional option, sebool, you could set
> this to the name of the seboolean, such as CTS.
> 
> 
> When the code that parses the seapp_contexts file
> (selinux_android_setcontext) could check the sebool flag first, and if
> it matches, apply the existing rules to it, else, throw it away as a
> possible match.
> 
> 
> Would anyone find this useful, and if so I can code it
> up tomorrow after I submit the Settings app patches to Garrett.

So you mean adding a new input selector to seapp_contexts so that we can
write entries like this:
sebool=android_cts domain=cts_app levelFromUid=true
and have it only match if android_cts is set to true?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
