Subject: Re: [RFC] selinux-support (1.0.1) available
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1111704432.27644.62.camel@localhost.localdomain>
References: <1111704432.27644.62.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Mar 2005 09:08:17 -0500
Message-Id: <1111759697.15280.53.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-03-24 at 23:47 +0100, Lorenzo Hernández García-Hierro
wrote:
> I'm glad to announce the public availability of the selinux-support
> (meta-)package which accomplishes the goal of installing the user-land
> tools for Security-Enhanced Linux support and few configuration-related
> files that will be used in a near future during the deployment of
> SELinux within Ubuntu Linux.
> 
> The packages depending on selinux-support (which are subsequently
> installed when installing it) are:
> 
> 	* selinux-doc
> 	* slat
> 	* selinux-utils
> 	* libselinux1
> 	* libselinux1-dev
> 	* policycoreutils
> 	* libsepol1
> 	* checkpolicy
> 	* selinux-policy-default
> 
> It also provides the Python bindings for libselinux, coming from the
> Hardened Gentoo project and available in the Gentoo CVS:
> http://www.gentoo.org/cgi-bin/viewcvs.cgi/dev-python/python-selinux

Can you explain the purpose of this package?  I'm not sure I understand
what you mean, or why the above packages would depend on it.  What is
the purpose of the /etc/selinux.conf file in this package, and how does
it compare to the already existing /etc/selinux/config file that is
being used by libselinux and various scripts?  Do you expect this to
remain Ubuntu-specific?

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
