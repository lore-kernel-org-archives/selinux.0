MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: To domain transition or not?
Date: Mon, 9 Jun 2008 12:50:43 -0700
Message-ID: <0794F277152EF94AA637E3AECF5CB70FB9E9D0@blums0042.bluelnk.net>
References: <0794F277152EF94AA637E3AECF5CB70FB9E986@blums0042.bluelnk.net> <1213032271.9375.101.camel@moss-spartans.epoch.ncsc.mil>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]
On
> Behalf Of Stephen Smalley
> Sent: Monday, June 09, 2008 10:25 AM
> To: Clarkson, Mike R (US SSA)
> Cc: selinux@tycho.nsa.gov
> Subject: Re: To domain transition or not?
> 
> 
> On Mon, 2008-06-09 at 10:14 -0700, Clarkson, Mike R (US SSA) wrote:
> > I have a general question, followed by a couple more specific
questions.
> > When creating domains for programs that use linux cmds like ping or
> > hostname, which have their own domains, I'm faced with the choice
having
> > those programs run in my domain or in the domain of the linux cmd.
What
> > is the better approach?
> 
> Depends on whether it is useful to separate them in terms of data or
> privileges.  If the program requires additional permissions (as ping
> does) that would allow the caller to perform actions beyond what it
can
> do just by running the program if the caller directly possessed those
> permissions, then running the program in its own domain is beneficial.
> 
> > Take "ping" for example. We have a program (MonitorSvcUtil) that
uses
> > ping and runs in a domain I've created called monitorsvcutil_t.
> > Depending on whether I use the netutils_exec_ping or
> > netutils_domtrans_ping interface, I can have our program execute
ping in
> > the monitorsvcutil_t domain, or do a domain transition into the
ping_t.
> > I would think the latter approach would be better, since ping is
then
> > running in a domain specifically designed for it and I can avoid
having
> > to give the monitorsvcutil_t domain the privileges needed to run
ping.
> 
> Agreed.
> 
> > When I try the latter approach I'm wondering why I run into the
> > following denials:
> >
> > type=AVC msg=audit(1213025579.772:9476): avc:  denied  { read write
}
> > for  pid=2238 comm="ping" path="socket:[6024549]" dev=sockfs
ino=6024549
> > scontext=root:staff_r:ping_t:s0-s4:c0.c255
> > tcontext=root:staff_r:monitorsvcutil_t:s0-s4:c0.c255
tclass=tcp_socket
> >
> > type=AVC msg=audit(1213025579.030:9446): avc:  denied  { append }
for
> > pid=2233 comm="ping"
> > path="/opt/nl/nltmp/clarkson/NLdata/.mbdev2_2008Jun09_1527_1415.txt"
> > dev=sda8 ino=684396 scontext=root:staff_r:ping_t:s0-s4:c0.c255
> > tcontext=root:object_r:nl_tmp_data_t:s0 tclass=file
> >
> > The first denial surprises me because I would have thought that the
ping
> > program would be creating its own TCP socket and thus I would not
expect
> > the socket to be labeled with the monitorsvcutil_t type.
> >
> > The second denial surprises me because the ping program does not
have
> > anything to do with the ".mbdev2_2008Jun09_1527_1415.txt" file. This
> > seems to indicate that once the ping process completes and returns
to
> > the MonitorSvcUtil process, the domain remains ping_t rather than
> > returning to monitorsvcutil_t.
> 
> 
> No, this shows that your MonitorSvcUtil program is leaking open file
> descriptors when it runs ping, and SELinux is correctly checking them
> upon inheritance across execve and closing them if unauthorized.  Bug
in
> your program - you should be marking the descriptors as close-on-exec
> and/or closing them all before exec'ing ping.

I have to admit that I'm not familiar with close-on-exec. Is there a c++
interface for it? How about Java? Any recommendations on where to find
information on it? I did not get much from a google search.

So do these AVC denials simply indicate that ping is receiving open file
descriptors that would ALLOW ping to append to a nl_tmp_data_t file and
read/write to a monitorsvcutil_t tcp_socket? As opposed to ping actually
attempting to do an append or read/write. If that's the case then I
could simply add a dontaudit to the policy for these AVC denials.

Thanks

> 
> --
> Stephen Smalley
> National Security Agency
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing
list.
> If you no longer wish to subscribe, send mail to
majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
