Subject: Re: [selinux] Re: SElinux vs. Grsecruity vs. RSBAC (vs.
	TrustedBSD?)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: =?ISO-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>
Cc: Bennett Todd <bet@rahul.net>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1061889339.1665.1548.camel@kusturica>
References: <FAB2059733EB46409AD28AC957F663F70BEE5C@pusmde04.mt.pweh.com>
	 <20030825170259.GB4409@rahul.net>  <1061889339.1665.1548.camel@kusturica>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1061901864.23880.41.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 26 Aug 2003 08:44:24 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-08-26 at 05:15, Magosányi Árpád wrote:
> The drawbacks: lack of polyinstantiation support (once it did have
> it in the FLASK microkernel), and that network support is even more
> primitive than that of RSBAC. I'm afraid even Stephen is yet to realize
> how important the handling of security attributes in packet filter.

RSBAC didn't include network access controls until relatively recently,
and only developed them after SELinux was released with its layered set
of network access controls.  It is true that we have temporarily dropped
out the SELinux network access controls as part of preparing SELinux for
mainline integration due to the rejection of most of the LSM networking
hooks, but we will restore a base set of functionality that can be
supported using only the hooks that were accepted plus the NetFilter
hooks.

> It is too much connected to Redhat. It makes an unnecessary
> inconvenience for a lot of users; why the userspace changes are given
> as srpms instead of patches to the upstream?

The focus of SELinux is on the kernel security enhancements, which have
always been provided as patches to the upstream kernel.  The userland
patches have always been a secondary priority to us, and it was only
natural for us to work from the distribution that we happened to use for
development.  We do provide patches for each of the userspace changes
separate from the SRPMS, and people have successfully ported them to
other distributions.  We didn't view it as a priority to get the
userland patches accepted upstream until we first got the kernel changes
accepted, particularly as the API might have to change (and it did!). 
It now makes sense to seek acceptance upstream for the userland patches.

> It might be interesting to include TrustedBSD in the comparison, but I
> know very few of it. It seems that it is a DoD MAC implementation,
> cares about every aspect (like network, polyinstantiation, etc), and
> uses all the experience of engineers of "The Only Real Unix" :).
> Its drawbacks might be its inflexibility (in SELinux you write a new
> security server, and you have implemented a new model), and -for those
> who do not like them- that it is DoD MAC, and BSD.
> (I might err in the facts above about TrustedBSD).

There is a port of the SELinux module to the TrustedBSD MAC framework
called SEBSD.  See the mailing list archives for prior discussion of it.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
