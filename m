Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l87Hinlq005266
	for <selinux@tycho.nsa.gov>; Fri, 7 Sep 2007 13:44:49 -0400
Received: from nz-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l87Hildm016647
	for <selinux@tycho.nsa.gov>; Fri, 7 Sep 2007 17:44:48 GMT
Received: by nz-out-0506.google.com with SMTP id i1so370708nzh
        for <selinux@tycho.nsa.gov>; Fri, 07 Sep 2007 10:44:46 -0700 (PDT)
Message-ID: <7e0fb38c0709071044l15cbafa8g29cdacbba315d80b@mail.gmail.com>
Date: Fri, 7 Sep 2007 13:44:46 -0400
From: "Eric Paris" <eparis@parisplace.org>
To: "Kim Lawson-Jenkins" <lawson@itd.nrl.navy.mil>
Subject: Re: Kernel panic when using refpolicy
Cc: selinux@tycho.nsa.gov
In-Reply-To: <000c01c7f17a$f2047130$c301000a@PC05>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <000c01c7f17a$f2047130$c301000a@PC05>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

going to want more of the panic information.  Whole boot output would
be great.  That's just the generic death message.  My first guess is
that you are enforcing, but that it can't actually find the binary
policy to install at boot time.

Before the panic did you get a message about 'enforcing and can't find
policy?'   Sounds like the most likely cause.  Do have a policy.21 in
/etc/selinux/refpolicy/policy/policy.21

-Eric

On 9/7/07, Kim Lawson-Jenkins <lawson@itd.nrl.navy.mil> wrote:
>
> Hi,
>
> I'm running RHEL5.  I downloaded refpolicy-20070629.tar.bz2 and
> selinux-refpolicy-sources-20070629-1.noarch.rpm and installed the files for
> the reference policy.  When rebooting the system there was a fatal error -
> Kernel panic - not syncing: Fatal exception.
>
> There were many unknown Boolean errors for libsepol.load.booleans and there
> was the following error -
> libsepol.sepol_genbools: error while reading /etc/selinux/refpolicy/Booleans
>
> It looks like ifconfig was running when the kernel panic occurred.  To
> recover booted into single-user mode and changed the SELINUXTYPE in the file
> /etc/selinux/config from refpolicy to targeted.  I can easily repeat the
> problem by using the SELinux Management Tool to change the System Default
> Policy Type from targeted to refpolicy and rebooting.  I've looked at all of
> the documentation to see if I missed a step or downloaded an incorrect file
> but I can't find anything.  Can anyone give me some insight into what the
> problem may be?  Thanks in advance for a response.
>
> Kim
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
