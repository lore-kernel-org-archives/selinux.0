Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1AFE7Rb009623
	for <selinux@tycho.nsa.gov>; Tue, 10 Feb 2004 10:14:07 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i1AFCRQk004446
	for <selinux@tycho.nsa.gov>; Tue, 10 Feb 2004 15:12:27 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i1AFCQYo004443
	for <selinux@tycho.nsa.gov>; Tue, 10 Feb 2004 15:12:26 GMT
Subject: Re: Announce: Updated SELinux conditional policy extensions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   Selinux Dev <selinux-dev@tresys.com>
In-Reply-To: <1074114393.10070.42.camel@colossus.columbia.tresys.com>
References: <1074114393.10070.42.camel@colossus.columbia.tresys.com>
Content-Type: text/plain
Message-Id: <1076426021.5910.131.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 10 Feb 2004 10:13:42 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-01-14 at 16:06, Karl MacMillan wrote:
> A new release of the conditional policy extensions to SELinux is
> available from our website:
> 
> http://www.tresys.com/selinux/index.html
> 
> Patches are also attached to this email. The conditional policy
> extensions to SELinux allow runtime modification of the security policy
> without having to load a new policy. Using boolean variables and
> expressions, it is possible to define sections of policy that are
> conditionally applied. Please see the website for more information.
> 
> This release includes modifications to the linux kernel, checkpolicy,
> libselinux, and the default policy and allows the creation and loading
> of conditional policies. Any testing or feedback would be greatly
> appreciated.

Just to let people know (if they haven't already noticed), we have
merged the Tresys conditional policy extensions into our internal tree
for inclusion in our next release, and we have pushed the merged code
into the sourceforge CVS tree for linux-2.6 and selinux-usr.  The
extensions change the binary policy format and increment the policy
version, so please note the following:

- checkpolicy will still generate the old format if passed a -c option
(dropping any booleans and conditional blocks with a warning in that
case), and a POLICYCOMPAT definition has been added to the policy
Makefile that can be uncommented to cause generation of a policy.15 file
for kernels that do not include the Tresys patch (i.e. a vanilla
kernel.org kernel or a Fedora Core development kernel).  Hence, if you
update to the new checkpolicy but are using a kernel without the Tresys
patch, then you will want to uncomment the definition for your policy
builds.

- The patched kernel will accept either policy version, but at present,
/sbin/init will only try to load the version obtained via
/selinux/policyvers, which will be 16.  We may want to change the
SysVinit-selinux patch to retry with the prior policy version if it
cannot find the current version, so that if someone updates their kernel
to one that includes the Tresys patch but does not update their policy
to the newer version, the system will still load the old policy and
function as expected.

- The extensions are only implemented for the 2.6-based SELinux. 2.4
SELinux users will need to uncomment the POLICYCOMPAT definition in the
policy Makefile.  More about the 2.4-based SELinux in a separate message
to follow.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
