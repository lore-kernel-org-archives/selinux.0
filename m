Subject: Re: overlayfs+selinux error: OPNOTSUPP
To: Russell Coker <russell@coker.com.au>
References: <20150921022517.GH22582@cyber.com.au>
 <56006BBA.4070602@tycho.nsa.gov> <201509231323.31482.russell@coker.com.au>
Cc: Matthew Cengia <mattcen@cyber.com.au>, selinux@tycho.nsa.gov,
 Matthew Cengia <mattcen@gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <5602D266.5060004@tycho.nsa.gov>
Date: Wed, 23 Sep 2015 12:25:10 -0400
MIME-Version: 1.0
In-Reply-To: <201509231323.31482.russell@coker.com.au>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/22/2015 11:23 PM, Russell Coker wrote:
> On Tue, 22 Sep 2015 06:42:34 AM Stephen Smalley wrote:
>> At this point, I have to ask:  which is easier, patching systemd to do
>> what you want, loading policy earlier (in general, the earlier you load
>> SELinux policy, the better), or patching the kernel.
> 
> Patching the kernel is unreasonably difficult and not something you want to 
> maintain going forward (note that I maintained the SE Linux kernel patch 
> package in Debian for some years before it was accepted upstream - I've had 
> practice at such things and it wasn't much fun).

If my theory on why he is encountering EOPNOTSUPP on open(2) on
overlayfs+squashfs is correct, then he has to either patch the kernel
(but we are only talking about a one-line patch, and one that I would
consider taking upstream too) or he has to move up policy loading to the
initrd.  That's all I'm suggesting there.

> What changes to systemd are you referring to?  If you mean making it possible 
> to mount /tmp noexec I don't think that's a good idea.  While I think the risk 
> of breakage is low (it's a constrained environment where general purpose use 
> isn't the aim) the benefits also seem minimal.  As an aside the default SE 
> Linux policy permits regular users to execute files they create in /tmp but 
> that could be changed.  It seems likely that Matthew will end up making a 
> custom policy anyway.

Yes, that is what I meant; he identified noexec XDG_RUNTIME_DIR as his
motivating reason for even enabling SELinux.  If that's his only goal,
then it is a lot easier to do a one-line patch to systemd than to work
through all the details of getting SELinux working with
overlayfs+squashfs _and_ having to create a custom policy, don't you
think?  Now, I'm all for him enabling SELinux; I just wanted him to
understand the potential cost up front.

> Regarding loading policy earlier, I thought we had already established that 
> loading policy in the initrd was generally a bad idea.  It makes the initrd 
> bigger (which can cause problems in some situations) and it requires that the 
> initrd be changed whenever significant changes are made to the policy (which 
> realistically means changing the initrd every time you change the policy to be 
> certain).  Loading the policy in the initrd is probably the best solution to 
> this use of an overlayfs system but I think it should be considered as an 
> unusual solution to an unusual problem rather than something that's generally 
> good.

I'll stand by my statement.  The earlier policy is loaded, the better.
The later you load policy, the greater the potential for processes,
files, and other objects to be mislabeled and to need retroactive fixing
via restorecon or similar means.  Also, as in this particular situation,
SELinux behavior when no policy is loaded may lead to surprising
results, as that doesn't get much testing.  I understand the reasons why
the distributions tend to defer policy load to the real root, but I
suspect the optimal approach even there would actually be to load an
initial bootstrap policy from the initrd (which hopefully can remain
fairly small and stable) and then reload a more complete, more
frequently updated policy from the real root.  Certainly less potential
for surprises there.

> To load the policy in the initrd you need to copy 
> /etc/selinux/default/policy/policy.* and /usr/sbin/load_policy to the initrd 
> and first mount /proc and the selinuxfs before loading the policy.  It will be 
> a little fiddly to setup (as does anything involving the initrd) but not any 
> great challenge.
> 
> Also it's unlikely that systemd has been tested in a situation where an initrd 
> loads the policy.  In case anyone wonders, I think it should be considered a 
> bug if systemd or SysVInit fails to work when the policy was loaded in the 
> initrd.

If you unpack the initramfs image on modern Fedora, the /init in the
initramfs is in fact systemd, and it already has the support for loading
policy. A cursory look at the code suggests that it supports loading
policy from the initrd and from the real root, and correctly handles the
case where policy only exists in one or the other as well as the case
where it exists in both.  But YMMV.
