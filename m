Message-ID: <54B3F66C.70206@tycho.nsa.gov>
Date: Mon, 12 Jan 2015 11:29:32 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Vincent Brillault <gentoo+selinux@lerya.net>, selinux@tycho.nsa.gov,
 Paul Moore <paul@paul-moore.com>
Subject: Re: RFC: https://bugzilla.redhat.com/show_bug.cgi?id=1174405
References: <1420837553.31986.2.camel@gmail.com>
 <CAB9W1A3Y_+gZv=ZWGTGvuk_z8P_Ys7SVNAUz8wRCS1EDW_dcJg@mail.gmail.com>
 <CAHZ_AjsxSJ3adY-UeMfik9xzOczk1411hk_ckSRPNbBOFSkwbA@mail.gmail.com>
 <14ad1cb43d8.2806.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <1420883781.24061.22.camel@gmail.com>
 <CAB9W1A2Ro0mTqOwJOBL=9S9SaE0C_sXw3MUKpGP4L9VQObokYw@mail.gmail.com>
 <20150110171950.GA23358@bigboy.network2>
 <20150110174300.GA28262@bigboy.network2>
 <CAB9W1A1rLu_5XnMXqn0kbR0yhD-D39RmBTF12=1Kz320Hv5iEA@mail.gmail.com>
 <20150110191517.GA30004@bigboy.network2>
 <20150110203949.GA6331@Fea.lerya.net>
In-Reply-To: <20150110203949.GA6331@Fea.lerya.net>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/10/2015 03:39 PM, Vincent Brillault wrote:
> Hi,
> 
> I'm not sure I understand the "performance" impact considerations.
> Indeed, if we were to try to control the binding to 'ephemeral' ports
> individually, the looping that Stephen proposed would definitely have a
> huge impact if all port are denied (as the kernel will have to loop over
> all of them to find out that all bindings are denied).

Yes, that was what I meant.

> However, does considering all these ports individually make sense?
> If we can consider them as a group, not individually, I believe that we
> could control 'ephemeral' bindings with almost no performance hit.
> For example, we could create a permission 'ephemeral_bind' in addition
> to bind and named_bind:
> - bind controls the ability to invoke the bind system calls
> - named_bind controls the ability to bind a given non ephemeral port
> - ephemeral_bind would controls the ability to bind any 'ephemeral' port
> 
> Would that make sense?
> 
> I'm not a kernel/selinux developper, so I can't judge the amount of work
> needed to implement such a solution, but I don't think that this issue
> can be discarded for 'performance' reasons.

You can bind to a port in the local port range in three different ways:

1) Call bind(2) with the port number explicitly specified.  That case we
could trivially check via SELinux today if we wanted to do so just by
removing the range check from selinux_socket_bind.  But it would leave
the check trivially bypassable by using one of the other two means until
you hit the desired port number, which is why we did not impose this
check in the first place (in addition to the fact that such ports can
have no security semantics since they are "randomly" assigned on demand).

2) Call bind(2) with a zero port number specified.  In that case, the
port is automatically selected by the ipv4 code after we have already
passed the selinux_socket_bind() hook call, so we cannot apply a check
based on the specific port number unless we hook the ipv4 (and ipv6)
code, in multiple places no less, which I don't see as maintainable.  We
could apply your generic ephemeral_bind check from selinux_socket_bind()
in this case but this will still be bypassable using the third way below.

3) Call sendto()/sendmsg() or connect() on an unbound socket.  In that
case, the port is automatically selected by the ipv4 code after we have
already passed the selinux_socket_sendmsg() or selinux_socket_connect()
hook call.  We'd either have to dig down into the inet_sk state within
those hooks to see if the socket was unbound or place a hook down in the
ipv4 code (and the ipv6 code) if we wanted to even apply your
ephemeral_bind check.  The former is possible but seems a bit of a
layering violation while the latter seems unmaintainable.

Now, let's say we implement this ephemeral_bind permission check.  What
domains that currently are allowed to create UDP or TCP sockets do you
think will need this permission?  I'll wager they all do, because they
will be creating sender UDP sockets for DNS lookups and other purposes
that will just be using the local port range.  So what did you gain?
