From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "C.J. Adams-Collier KF7BMP" <cjac@colliertech.org>
Subject: Re: SELinux on Wheezy
Date: Fri, 10 Feb 2012 00:08:41 +1100
Cc: Stephen Smalley <sds@tycho.nsa.gov>, "SE-Linux" <selinux@tycho.nsa.gov>
References: <1328502407.14110.7074.camel@calcifer> <1328732265.19254.95.camel@moss-pluto> <1328736760.5174.11.camel@foxtrot.cjac.ntr.f5net.com>
In-Reply-To: <1328736760.5174.11.camel@foxtrot.cjac.ntr.f5net.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201202100008.42229.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 9 Feb 2012, "C.J. Adams-Collier KF7BMP" <cjac@colliertech.org> wrote:
> Okay.  Do these ever get purged under any other circumstances?

Generally no.  The only case where modules are automatically removed is when 
you upgrade the policy package and you have obsolate modules installed.  This 
is generally to prevent upgrades from failing.

> I noted
> that when I booted without selinux enabled and then with it enabled, the
> filesystem was re-labeled.  Does anything else get triggered in this
> situation?  Specifically, do policies get removed?

No.  That will never happen.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
