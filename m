Subject: Re: Policy source and initial ramdisk
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: SELinux List <SELinux@tycho.nsa.gov>, Frank Mayer <mayerf@tresys.com>,
   david caplan <dac@tresys.com>, Russell Coker <russell@coker.com.au>
In-Reply-To: <1063747354.25176.44.camel@colossus.columbia.tresys.com>
References: <1063747354.25176.44.camel@colossus.columbia.tresys.com>
Content-Type: text/plain
Message-Id: <1063802230.20755.110.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 17 Sep 2003 08:37:10 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-09-16 at 17:22, Karl MacMillan wrote:
> It appears that users are required to call mkinitrd whenever the policy
> is modified. If this is the case it seems that users might be unaware
> that make install /etc/security/selinux/src/policy doesn't change the
> policy loaded during the next boot. Additionally, it is problematic for
> tools that modify the policy source. The quickest solution would be to
> modify the install target to call mkinitrd, but this has some issues
> (like reliably determining the name of the ramdisk image). Does anyone
> have any thoughts about the best way to approach this problem?

Chris PeBenito posted a patch to add an initrd target to the policy
Makefile, see
http://marc.theaimsgroup.com/?l=selinux&m=106013650824010&w=2.
Russell Coker suggested that it was better left as a distribution patch
due to differences in mkinitrd scripts.  However, it wasn't clear to me
whether the mkinitrd invocation itself is distribution-dependent.  

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
