Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2S2e8Mg028699
	for <selinux@tycho.nsa.gov>; Thu, 27 Mar 2008 22:40:08 -0400
Received: from nospam.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2S2e4k8025288
	for <selinux@tycho.nsa.gov>; Fri, 28 Mar 2008 02:40:06 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Manoj Srivastava <srivasta@debian.org>
Subject: policy package names for Debian
Date: Fri, 28 Mar 2008 13:40:00 +1100
Cc: "SE-Linux, " <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200803281340.01991.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The policy names used in Fedora/RHEL (according to the SELINUXTYPE field 
in /etc/selinux/config) are "targeted", "strict", and "mls".

The names currently used in Debian are "refpolicy-targeted" 
and "refpolicy-strict".  For my work on MLS in Debian I have started with a 
package named "refpolicy-mls" (but hope to release it just as "mls").

I believe that the contents of /etc/selinux/config should match between 
distributions as much as possible.  It would be good if documentation for how 
to solve problems on Fedora would work for people using Debian.

Also the "refpolicy" part of the name doesn't seem to add any value.  Policy 
other than "refpolicy" is old and forgotten, and more importantly there is no 
possibility of switching between them.  If a user could choose to have 
either "refpolicy-targeted" or the old "targeted" then that would be a good 
reason for having the different name.  But as they have no choice it seems 
better to have shorter names everywhere (both in the config file and in the 
package name).

pn  postfix-policy <none>         (no description available)
un  selinux-policy <none>         (no description available)
ii  selinux-policy 0.0.20061018-5 Headers from the SELinux reference policy fo
pn  selinux-policy <none>         (no description available)
pn  selinux-policy <none>         (no description available)
pn  selinux-policy <none>         (no description available)
ii  selinux-policy 0.0.20061018-5 Targeted variant of the SELinux reference po

The package name "selinux-policy-refpolicy-targeted" is unreasonably long to 
type and is too long to be usable in a default operation of "dpkg -l" (see 
the above output from "dpkg -l" on an 80 column xterm).

Manoj, I suggest that we change the package names to selinux-pol-targeted, 
selinux-pol-strict, and selinux-pol-mls.  That saves typing and results in 
the above dpkg command giving useful data.

Currently anyone who is using SE Linux in Debian/Unstable will need to purge 
and reinstall their policy (while also rebooting their machine).  The process 
of purge and reinstall will handle the name in /etc/selinux/config, and the 
problems related to a reboot make the issue of a different policy package 
name trivial by comparison.

Manoj, what do you think?

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
