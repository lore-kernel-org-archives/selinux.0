From: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: overlayfs+selinux error: OPNOTSUPP
Date: Wed, 23 Sep 2015 13:23:31 +1000
Cc: Matthew Cengia <mattcen@cyber.com.au>, selinux@tycho.nsa.gov,
 Matthew Cengia <mattcen@gmail.com>
References: <20150921022517.GH22582@cyber.com.au>
 <56006BBA.4070602@tycho.nsa.gov>
In-Reply-To: <56006BBA.4070602@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Message-Id: <201509231323.31482.russell@coker.com.au>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 22 Sep 2015 06:42:34 AM Stephen Smalley wrote:
> At this point, I have to ask:  which is easier, patching systemd to do
> what you want, loading policy earlier (in general, the earlier you load
> SELinux policy, the better), or patching the kernel.

Patching the kernel is unreasonably difficult and not something you want to 
maintain going forward (note that I maintained the SE Linux kernel patch 
package in Debian for some years before it was accepted upstream - I've had 
practice at such things and it wasn't much fun).

What changes to systemd are you referring to?  If you mean making it possible 
to mount /tmp noexec I don't think that's a good idea.  While I think the risk 
of breakage is low (it's a constrained environment where general purpose use 
isn't the aim) the benefits also seem minimal.  As an aside the default SE 
Linux policy permits regular users to execute files they create in /tmp but 
that could be changed.  It seems likely that Matthew will end up making a 
custom policy anyway.

Regarding loading policy earlier, I thought we had already established that 
loading policy in the initrd was generally a bad idea.  It makes the initrd 
bigger (which can cause problems in some situations) and it requires that the 
initrd be changed whenever significant changes are made to the policy (which 
realistically means changing the initrd every time you change the policy to be 
certain).  Loading the policy in the initrd is probably the best solution to 
this use of an overlayfs system but I think it should be considered as an 
unusual solution to an unusual problem rather than something that's generally 
good.

To load the policy in the initrd you need to copy 
/etc/selinux/default/policy/policy.* and /usr/sbin/load_policy to the initrd 
and first mount /proc and the selinuxfs before loading the policy.  It will be 
a little fiddly to setup (as does anything involving the initrd) but not any 
great challenge.

Also it's unlikely that systemd has been tested in a situation where an initrd 
loads the policy.  In case anyone wonders, I think it should be considered a 
bug if systemd or SysVInit fails to work when the policy was loaded in the 
initrd.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/
