Subject: Re: Future of selinux/lsm
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: selinux@servalens.com
Cc: SELinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>
In-Reply-To: <2700.165.247.144.4.1070315301.squirrel@webmail.servalens.com>
References: <2700.165.247.144.4.1070315301.squirrel@webmail.servalens.com>
Content-Type: text/plain
Message-Id: <1070376706.14253.21.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 02 Dec 2003 09:51:46 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-12-01 at 16:48, selinux@servalens.com wrote:
> I read that LSM was being pulled from the 2.6 kernel. Is this true?

Not as far as I know.  There was a discussion on lkml a while back where
one particular kernel developer said that he would submit patches to
remove LSM if there were no in-tree users (i.e. security modules) of the
security hooks by 2.6-test.  But SELinux was reworked for mainline
inclusion, and was added to the mainline kernel as of 2.6.0-test3 and
later, thereby addressing his objection to leaving LSM in the mainline
kernel.

> The choice would be maintaining a patched 2.4x kernel or going bleeding
> edge with a 2.6 kernel.

Just FYI, 2.6 kernel RPMS are available from Arjan van de Ven of RH,
under http://people.redhat.com/arjanv/2.5/.  His kernels have SELinux
support enabled (although you won't notice it until you load a policy). 

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
