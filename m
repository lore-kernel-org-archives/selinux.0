Message-Id: <200209191024.KAA05161@jazzswing.ncsc.mil>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: Russell Coker <russell@coker.com.au>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: privfd attribute
Date: Thu, 19 Sep 2002 12:24:07 +0200
References: <200209171901.TAA20518@jazzband.ncsc.mil> <200209181950.01338.russell@coker.com.au>
In-Reply-To: <200209181950.01338.russell@coker.com.au>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Am Mittwoch, 18. September 2002 19:50 schrieb Russell Coker:
> privlog is an attribute specifying that a process gets certain access (IE
> to /dev/log - but later it might be to some other form of logging).
>
> privfd is an attribute used to grant access to a process.  Any domain
> that opens a file handle that lots of other domains need to access
> (example crond_t, login_t, sshd_t, newrole_t) gets it.
>
> privlog and privfd are totally different types of attribute used for
> totally different things (at a conceptual level at least).

I am not sure, if I understand the usage of the attributes right. 
After I declared an attribute, I can use it in a type declaration. 
And then I can use it in two ways:
1. I can write a allow rule like this
    allow myattribute exampledomain_conf_t:file r_file_perms;
   and all other domains which have this attribute in the domain
   declaration have grant access to this file without an specific
   rule.
   An Example of this this the privlog attribute.
2. I could it uses as an set of type and through this I can write simple
   rules
    allow mydomain_t myattribute:fd use;
   instead of
     allow mydomain_t { login_t sshd_t, newrole_t }:fd use;
   and it will by easier to add or remove new types.
   The privfd attribute is an Example of this.

Have I understand this correct?

Carsten

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
