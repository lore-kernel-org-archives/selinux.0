Date: Fri, 5 Oct 2001 09:57:04 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: "Justin R. Smith" <jsmith@mcs.drexel.edu>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: Some questions
In-Reply-To: <1002286253.1080.18.camel@jsmith.org>
Message-ID: <Pine.GSO.4.33.0110050943410.29582-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 5 Oct 2001, Justin R. Smith wrote:

> I've installed the latest version of SELinux in permissive mode.
>
> 1. I've noticed no unusual messages in dmesg or /var/log/messages. Does
> this mean that my normal activities do not violate any of the new access
> restrictions? (So enabling secure mode would not disrupt any of the
> things I normally do)?

Possibly.  Please check the 'ps -e --context' output and verify that each
system process is running in the correct security context.  Also, please
verify that your security context is set properly when you login (run
'id' or 'ps --context').  And make sure that you aren't running a X
Display Manager, as I mentioned in my prior email to James Bishop.

> 2. If I toggle fully secure mode, can I reverse this remotely (i.e., ssh
> to the host, su, and execute the toggle command again)?

You don't need to 'su' - you need to run 'newrole -r sysadm_r'.  SELinux
doesn't care whether you are root.  It cares about your role and domain.
Yes, this should work remotely (unless you change the policy to prohibit
it).  You can test it while still in permissive mode - simply try it and
check /var/log/messages and the output of dmesg for any messages.

> 3. SSH no longer recognizes my authorized keys --- I must always enter a
> password to use it. I've regenerated the keys several times (putting the
> appropriate public keys in 'authorized_keys') without success. I know
> the sshd on my system was replaced by another. Does it function
> differently?

The utils Makefile only installs the modified sshd, not the rest of the
package, since we only modified sshd.  So if you were using a different
version of OpenSSH, you might have a compatibility problem.  The openssh
package provided with SELinux is the default one provided with RedHat 7.1
with the SELinux modifications.  If you are using a newer version of
OpenSSH, then I would suggest porting the SELinux patch forward to the
newer version (and please feed the resulting patch back to us).  If you are
using an older version of OpenSSH, then I would suggest doing a 'make
install' in the openssh-2.5.2p2-5 directory and then doing a 'make
relabel' in the utils directory.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
