Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2OHKIDQ025213
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2008 13:20:18 -0400
Received: from rv-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2OHKFFR012584
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2008 17:20:15 GMT
Received: by rv-out-0910.google.com with SMTP id k15so1425244rvb.54
        for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2008 10:20:11 -0700 (PDT)
Message-ID: <50771f160803241020q829f988s2c1441ca3fde5032@mail.gmail.com>
Date: Mon, 24 Mar 2008 14:20:11 -0300
From: "cinthya aranguren" <cinthya.aranguren@gmail.com>
To: casey@schaufler-ca.com
Subject: Re: Removing DAC.
Cc: selinux@tycho.nsa.gov
In-Reply-To: <613578.78683.qm@web36601.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <50771f160803230854n18bd2a07q34eb154fc016f351@mail.gmail.com>
	 <613578.78683.qm@web36601.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Mar 23, 2008 at 2:25 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>
>
> --- cinthya aranguren <cinthya.aranguren@gmail.com> wrote:
>
> > Hi,
> >
> > Is there any way to avoid o remove DAC controls ? I'd like to have only one
> > security scheme in my system. I mean a pure SElinux system. not DAC + MAC.
> > only MAC.
>
> No.
>
> Well, not today.
>
> The LSM, which is the interface that SELinux uses to plug into
> the rest of the kernel is explicity designed to allow additional
> restrictions but not replacement or override of existing
> restrictions. In the early days of LSM both restrictive models,
> like what we have today, and authoritiative models, which would
> allow replacement of traditional DAC where considered. The
> authoritative model was rejected based on how easy it would be
> for proprietary modules that had nothing to do with security to
> exploit the interface.
>
> I am currently putting some work into separating the LSM into
> a pair of interface sets, one for the privilege model and one
> for the additional restrictions. Once in place it could be
> possible to create a privilege scheme that reports to the
> traditional DAC that everyone has DAC override, and leave it
> to SELinux (or whatever restrictive model you might prefer)
> to make the only decision.
>
> That work is not done, nor is there any assurance that it
> might be accepted when it is. Since it would result in a
> system where the privilege module and the access restriction
> module could team up to provide an authoritative model
> it is within reason that the arguments that blocked an
> authoritative LSM could be raised again with the same result.
>


Thanks for the reply...

Thats means it's imposible to separate DAC from MAC. There is no way
to have only one security scheme.


> Now I'll ask the 37 cent question:
>
> Why would you want to do that?
>
>

Just because i'm trying to simplify the security management of a linux
instalation. I'd like to use  MAC security, but i realize  this means
still have DAC. I can't get rid of this. I have to admin the DAC
burden plus MAC.
May be I'm thinking in a oversimplified reality.



>
> Casey Schaufler
> casey@schaufler-ca.com
>


Cinthya.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
