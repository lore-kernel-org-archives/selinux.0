Subject: Re: Changes to policycoreutils.
From: Stephen Smalley <sds@tycho.nsa.gov>
Reply-To: sds@tycho.nsa.gov
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Russell Coker <russell@coker.com.au>, James Morris <jmorris@namei.org>,
        Valdis.Kletnieks@vt.edu, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1142869863.16487.57.camel@moss-spartans.epoch.ncsc.mil>
References: <441B2C7B.7050307@redhat.com>
	 <200603180532.k2I5Wuhe004158@turing-police.cc.vt.edu>
	 <441C3B52.7060702@redhat.com>
	 <1142862355.16487.7.camel@moss-spartans.epoch.ncsc.mil>
	 <441EC183.6000404@redhat.com>
	 <1142869863.16487.57.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 20 Mar 2006 12:25:31 -0500
Message-Id: <1142875531.16487.93.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-03-20 at 10:51 -0500, Stephen Smalley wrote:
> restorecond, restorecon, and setfiles could benefit from a rewrite to
> follow the more paranoid conventions of other programs that walk the
> file tree (e.g. look at coreutils programs like rm -r logic, which has
> been modified a number of times in response to security-related issues).
> To date, restorecon and setfiles have simply relied on policy to
> prevent:
> - untrustworthy domains from creating hard links to files that they
> shouldn't be able to access in the first place, and
> - restorecon/setfiles from following untrustworthy symlinks.
> 
> And we originally only expected setfiles to be applied upon
> installation, not for normal runtime operation.
> 
> But the code itself could provide stronger safeguards against the
> threat, particularly now that you are automating the invocation of
> restorecon-like functionality in response to user events.  Again, look
> to what has been done already in coreutils and elsewhere.  There are
> also recently added new syscalls to help reduce races in walking the
> file tree (i.e. openat and friends) - possibly there should be some for
> lsetxattr as well so that lsetfileconat() could be implemented?
> 
> Under strict policy, the policy restrictions over creating hard links
> and over following sym links help counter the risk.  Under targeted
> policy, users are unconfined by TE, so there is no direct benefit to a
> malicious user in tricking restorecond into relabeling a file to a
> different type.  But now that users are supposed to be limited by MCS
> restrictions in -targeted, you have to consider the risk that a
> malicious user might try to use this avenue to get MCS categories
> dropped from some target file so that he can access it.

BTW, on the FreeBSD side, they appear to have ported/rewritten the
setfiles logic in their setfmac utility,
http://www.freebsd.org/cgi/cvsweb.cgi/src/usr.sbin/setfmac/setfmac.c

They chose to use fts(3) rather than nftw(3) to walk the file tree, and
use fts_accpath to access the file from the current directory.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
