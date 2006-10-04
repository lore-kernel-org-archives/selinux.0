Subject: Re: newrole - adding capabilities for polyinstantiation
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: Michael C Thompson <thompsmc@us.ibm.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>,
        Steve Grubb <sgrubb@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200610040952.07843.russell@coker.com.au>
References: <451AEC39.2090409@us.ibm.com> <451C3A37.8080509@us.ibm.com>
	 <4522E6DA.1000200@us.ibm.com>  <200610040952.07843.russell@coker.com.au>
Content-Type: text/plain
Date: Wed, 04 Oct 2006 12:22:15 -0400
Message-Id: <1159978935.19176.133.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-10-04 at 09:52 +1000, Russell Coker wrote:
> On Wednesday 04 October 2006 08:40, Michael C Thompson <thompsmc@us.ibm.com> 
> wrote:
> > There are a few concerns which have arisen due to this polyinstantiation
> > and suid newrole work. One such concern is that with labeled networking,
> > using newrole to change your MLS level will not work as intended, since
> > the relabeled tty will not be able to talk to the socket. This would
> > limit using newrole to manipulate our MLS to the console, and would
> > leave newrole capable of only changing the role and type on network
> > connections.
> 
> What do you mean?
> 
> You have sshd talking to /dev/ptmx and the shell talking to /dev/pts/X.  
> If /dev/pts/X is relabeled to a different range then sshd will still keep 
> talking to /dev/ptmx without any change (in fact sshd can't conveniently know 
> about this change).

See the thread starting here:
http://www.redhat.com/archives/redhat-lspp/2006-July/msg00024.html

> 
> The only problems you have with network logins and newrole are if you do "exec 
> newrole" or if your connection is closed due to a network error.  In those 
> cases sshd may try to restore the context of a /dev/pts/X device that it is 
> not permitted to access.  Of course given that /dev/pts/X is going to 
> disappear this makes no real difference.
> 
> The only way I can think of network context being an issue is if you run the 
> following command:
> ssh user@host "newrole -r foo_r"
> 
> In that case sshd will not create a pty and will instead use a Unix domain 
> socket.  But I can't imagine any situation in which you would do that 
> (newrole typically requires an interactive session).
> 
> > However, even with this MLS level concern aside, is it expected that
> > using newrole to change your active role will also polyinstantiate
> > directories? If so, then newrole needs to be a setuid root program.
> 
> I believe that this is necessary.  What is the point of having 
> poly-instantiated directories if the standard commands used to change 
> security contexts don't use them?  Also if you have two shells open in role 
> foo_r which have different versions of /tmp because the initial logins were 
> from different contexts then it will be at best confusing and at worst a 
> security leak.
> 
> > If making newrole to be a setuid root program is considered
> > unacceptable, an alternative needs to be provided for users to specify
> > the desired role (and type) to assume upon login.
> 
> We already have that for ssh and console logins.  Doing it for X logins was 
> not viable in the past due to lack of PI.  But with a PI home directory it is 
> viable to allow the user to select a context through an XDM program.  With PI 
> directories my previous objections to context selection for an X login have
> become obsolete.
> 
> Also for an X session it's quite viable to ssh to localhost from an xterm to 
> create a session with a different context, and that is no more difficult than 
> running newrole.  I am not advocating doing this, just noting that it is 
> possible.
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
