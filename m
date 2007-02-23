Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1NGVXaB019227
	for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2007 11:31:33 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l1NGWq0Z019266
	for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2007 16:32:52 GMT
Subject: Re: Is the usercanread attribute still needed?
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Ryan Bradetich <rbradetich@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <e739902b0702201951p813ad71vefb0dd0069448a07@mail.gmail.com>
References: <e739902b0702181633md9e8fa9y55e74a5520cf7a60@mail.gmail.com>
	 <1172004294.20576.236.camel@sgc.columbia.tresys.com>
	 <e739902b0702201944t104d6915raff5949c8e579885@mail.gmail.com>
	 <e739902b0702201951p813ad71vefb0dd0069448a07@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 23 Feb 2007 16:33:07 +0000
Message-Id: <1172248387.15371.66.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> On 2/20/07, Ryan Bradetich <rbradetich@gmail.com> wrote:
> > Hello Chris,
> >
> > Thanks much for your reply!
> > I have attached an updated patch that leaves the attribute definition
> > in the files.te file.
> >
> > Just out of curiosity, what is the policy for obsoleting these attributes?
> > At next policy file rev?

It has to stay around for "a reasonable transition time".  Since this is
a fairly widely used interface, it'll probably have to stay for a few
releases.

Please resend the patch to the list.

> > On 2/20/07, Christopher J. PeBenito <cpebenito@tresys.com> wrote:
> > > Since modules are statically compiled, we can't completely remove the
> > > attribute yet, otherwise it might cause some policies to fail to link if
> > > it is still required.  However, the typeattribute could be removed from
> > > files_config_file().

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
