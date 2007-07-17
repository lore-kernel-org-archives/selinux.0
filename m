Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6HC3mIK011745
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 08:03:48 -0400
Received: from wa-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6HC3lQA020965
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 12:03:47 GMT
Received: by wa-out-1112.google.com with SMTP id k22so1792794waf
        for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 05:03:46 -0700 (PDT)
Message-ID: <6bffcb0e0707170503lf20df59p7afdd676656f7234@mail.gmail.com>
Date: Tue, 17 Jul 2007 14:03:46 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "John D. Ramsdell" <ramsdell@mitre.org>
Subject: Re: Cannot run ldconfig in a home directory
Cc: selinux@tycho.nsa.gov
In-Reply-To: <ogtzm1vntsd.fsf@oolong.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <ogtzm1vntsd.fsf@oolong.mitre.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

On 17 Jul 2007 07:39:30 -0400, John D. Ramsdell <ramsdell@mitre.org> wrote:
> I am playing around with the source distribution of the audit package.
> I modified some code, but I don't want to install the modified version
> in the usual locations, just in case I break something.  So I
> configured the source distribution using:
>
>    $ ./configure --prefix=$HOME/opt/audit
>
> and then did the usual "make; make install".
>
> The audit package contains shared libraries, and the installation
> scripts run ldconfig using the -n option.  This option ensures
> ldconfig will not process the trusted directories (/usr/lib and /lib)
> or those specified in /etc/ld.so.conf, thus allowing it to be run
> by an unprivileged user; however, the current SELinux for Fedora 7
> prevents this usage of ldconfig.  Setroubleshoot reports:
>
> Summary:
> SELinux is preventing /sbin/ldconfig (ldconfig_t) "search" to home
> (home_root_t).
>
> Detailed Description:
> SELinux denied access requested by /sbin/ldconfig. It is not expected
> that this access is required by /sbin/ldconfig and this access may
> signal an intrusion attempt. It is also possible that the specific
> version or configuration of the application is causing it to require
> additional access.
>
> Obviously, it is easy enough for me to disable SELinux while playing
> with the audit sources, but it seems to that with this policy, if I
> were working on a machine I did not control, I wouldn't be able
> properly test an installation.

man audit2allow ;)

>
> John
>

Regards,
Michal

-- 
LOG
http://www.stardust.webpages.pl/log/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
