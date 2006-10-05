From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Klaus Weidner <klaus@atsec.com>
Subject: Re: newrole - adding capabilities for polyinstantiation
Date: Thu, 5 Oct 2006 10:45:35 +1000
Cc: Michael C Thompson <thompsmc@us.ibm.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>,
        Steve Grubb <sgrubb@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
References: <451AEC39.2090409@us.ibm.com> <200610040952.07843.russell@coker.com.au> <20061004202041.GC10204@w-m-p.com>
In-Reply-To: <20061004202041.GC10204@w-m-p.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200610051045.41833.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 05 October 2006 06:20, Klaus Weidner <klaus@atsec.com> wrote:
> > You have sshd talking to /dev/ptmx and the shell talking to /dev/pts/X.
> > If /dev/pts/X is relabeled to a different range then sshd will still keep
> > talking to /dev/ptmx without any change (in fact sshd can't conveniently
> > know about this change).
>
> But that's not supposed to work, see:
>
> 	https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=200110
>
> and the thread that Stephen Smalley also referred to:
>
> 	http://www.redhat.com/archives/redhat-lspp/2006-July/msg00024.html
>
> The communication between the master and slave ends of the pty violates
> the MLS policy, and makes it easy for unprivileged users to violate the
> policy restrictions.

How is ssh supposed to work then?

Currently the sshd code for selecting roles is being discussed.  I never 
expected the sshd upstream people to include that at the first pass and 
considered that they might refuse to ever include it.  This is not a big deal 
IMHO as patching base SE Linux support in the openssh source tree to have 
more features is less work and less risk than patching in SE Linux support 
where previously there was none.

If sshd role selection support is maintained and if it's then extended to 
support a selection of MLS/MCS ranges then what restrictions will be placed 
on the range selected?  Is the aim to make sshd use labeled networking 
features to enforce a range that matches the client end?  If so then newrole 
should be prevented on ssh sessions (IE all pty sessions).

If the ssh client should be permitted to select the role and range then there 
is little extra vulnerability in also permitting the newrole program to 
perform the operations being discussed as the user could always cat the file 
from one ssh session and then proxy it to a cat command in another session at 
a different level.  This issue may still apply if the ssh client can not 
select the level as the user may have multiple Unix accounts on the server 
that have different levels.

It seems to me that the minimal solution to this problem of data relabeling is 
to prevent newrole from accessing regular pty devices (*) and to prevent ssh 
logins unless the labeled networking functionality is enabled, the client 
process is at the same level, and the client computer has the same level of 
integrity and the same meanings for MLS levels.

(*) This can be achieved by having more types for tty devices, we have 
user_devpts_t for ptys created by the user and we could have 
user_system_devpts_t for ptys created for the user by sshd or similar 
programs.  Then newrole could operate on ptys created by sshd but not on 
those created by the user.  This also means that newrole in an xterm would be 
impossible, but given the issues related to capturing data from an xterm this 
is a good thing.  It would be quite easy to have the default policy have such 
types and have a boolean to determine whether newrole_t can access 
user_devpts_t.

When we get SE-X going we could have an X enabled version of newrole that 
spawns an xterm in the new context.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
