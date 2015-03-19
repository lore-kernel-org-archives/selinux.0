Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t2JMcQQZ019410
 for <selinux@tycho.nsa.gov>; Thu, 19 Mar 2015 18:38:27 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.vivaldi.net (Postfix) with ESMTP id 47FFC800BC7
 for <selinux@tycho.nsa.gov>; Thu, 19 Mar 2015 22:38:24 +0000 (GMT)
Received: from mail.vivaldi.net ([127.0.0.1])
 by localhost (wagner.vivaldi.net [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yVOASpNL3CKt for <selinux@tycho.nsa.gov>;
 Thu, 19 Mar 2015 22:38:23 +0000 (GMT)
Received: from mail.vivaldi.net (localhost [127.0.0.1])
 (Authenticated sender: john.chludzinski)
 by mail.vivaldi.net (Postfix) with ESMTPA id EE70C800B52
 for <selinux@tycho.nsa.gov>; Thu, 19 Mar 2015 22:38:21 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Thu, 19 Mar 2015 23:38:21 +0100
From: John Chludzinski <john.chludzinski@vivaldi.net>
To: selinux@tycho.nsa.gov
Subject: Re: Trying to update sysadm module in CLIP
In-Reply-To: <e4247c48f0174b6f77f05c5b28bbcb9e@vivaldi.net>
References: <e4247c48f0174b6f77f05c5b28bbcb9e@vivaldi.net>
Message-ID: <b9a113715934c985dbeec5c2351f06cd@vivaldi.net>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I ran (when under the role sysadm_r and type sysadm_t):

$ id -Z

and got: Xsysadm_u:sysadm_r:sysadm_t:s0

So now I'm assuming the CLIP image is at "s0" sensitivity level.

Then I noticed that the build.conf file states: "The sensitivities will 
be s0 to s(MLS_SENS-1)".

So I built using:

$ make modules APPS_MODS="sysadm" TYPE="mls" MLS_SENS=1

to get an "s0" sensitivity level.

Tried to install and now I get: "duplicate declaration in module: 
type/attribute sysadm_userhelper_t".
(A "Whac-A-Mole" game!)

---John


On 2015-03-19 21:31, John Chludzinski wrote:
> First thing ... I'm a newbie to SELinux.
> 
> I'm trying to update the sysadm module in a CLIP image. I downloaded
> the SELinux policy code from: https://github.com/QuarkSecurity/CLIP.
> I modified the sysadm policy code and built (in
> ~/clip/packages/clip-selinux-policy/clip-selinux-policy) using:
> 
> $ make modules APPS_MODS="sysadm"
> 
> Then I tried to install in the CLIP image using:
> 
> $ semodule -i /mnt/hdd/SELinix/sysadm.pp
> 
> and got: "tried to link in a non-MLS module with an MLS base". (I
> assume this means the CLIP image I'm working with is MLS?)
> Next I built using:
> 
> $ make modules APPS_MODS="sysadm" TYPE="mls"
> 
> Tried to load/install the module and got: "sensitivy s10 not declared 
> by base."
> 
> Next I tried:
> 
> $ make modules APPS_MODS="auditadm sysadm" TYPE="mls" MLS_SENS=15
> 
> and !still! got "sensitivy s10 not declared by base".
> 
> Any suggestions/thoughts?
> 
> ---John
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to 
> Selinux-request@tycho.nsa.gov.
