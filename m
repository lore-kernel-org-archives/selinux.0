Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Carsten Grohmann <carstengrohmann@gmx.de>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: privfd attribute
Date: Wed, 18 Sep 2002 19:50:01 +0200
References: <200209171901.TAA20518@jazzband.ncsc.mil>
In-Reply-To: <200209171901.TAA20518@jazzband.ncsc.mil>
MIME-Version: 1.0
Message-Id: <200209181950.01338.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 17 Sep 2002 21:02, Carsten Grohmann wrote:
> the privfd attribute is ofter use in the policy. But I don't understand why
> we create and use this attribute.
> And why don't we use it like e.g. the privlog attribute? Privlog is
> declared in attrib.te, get his rights in syslogd.te and often use in domain
> declarations. Is the same way for privfd not possible? This could simplify
> the rules. Or?

privlog is an attribute specifying that a process gets certain access (IE to 
/dev/log - but later it might be to some other form of logging).

privfd is an attribute used to grant access to a process.  Any domain that 
opens a file handle that lots of other domains need to access (example 
crond_t, login_t, sshd_t, newrole_t) gets it.

privlog and privfd are totally different types of attribute used for totally 
different things (at a conceptual level at least).

-- 
There is no point PGP/GPG signing an email unless the signature can be
verified.  If you post to a list then don't sign the message unless your
key is available on public key servers and has been signed by someone
who is in the web of trust, otherwise you just waste bandwidth and CPU.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
