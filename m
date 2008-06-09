Subject: Re: To domain transition or not?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <0794F277152EF94AA637E3AECF5CB70FB9E986@blums0042.bluelnk.net>
References: <0794F277152EF94AA637E3AECF5CB70FB9E986@blums0042.bluelnk.net>
Content-Type: text/plain
Date: Mon, 09 Jun 2008 13:24:31 -0400
Message-Id: <1213032271.9375.101.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-06-09 at 10:14 -0700, Clarkson, Mike R (US SSA) wrote:
> I have a general question, followed by a couple more specific questions.
> When creating domains for programs that use linux cmds like ping or
> hostname, which have their own domains, I'm faced with the choice having
> those programs run in my domain or in the domain of the linux cmd. What
> is the better approach?

Depends on whether it is useful to separate them in terms of data or
privileges.  If the program requires additional permissions (as ping
does) that would allow the caller to perform actions beyond what it can
do just by running the program if the caller directly possessed those
permissions, then running the program in its own domain is beneficial.  

> Take "ping" for example. We have a program (MonitorSvcUtil) that uses
> ping and runs in a domain I've created called monitorsvcutil_t.
> Depending on whether I use the netutils_exec_ping or
> netutils_domtrans_ping interface, I can have our program execute ping in
> the monitorsvcutil_t domain, or do a domain transition into the ping_t.
> I would think the latter approach would be better, since ping is then
> running in a domain specifically designed for it and I can avoid having
> to give the monitorsvcutil_t domain the privileges needed to run ping.

Agreed.

> When I try the latter approach I'm wondering why I run into the
> following denials:
> 
> type=AVC msg=audit(1213025579.772:9476): avc:  denied  { read write }
> for  pid=2238 comm="ping" path="socket:[6024549]" dev=sockfs ino=6024549
> scontext=root:staff_r:ping_t:s0-s4:c0.c255
> tcontext=root:staff_r:monitorsvcutil_t:s0-s4:c0.c255 tclass=tcp_socket
> 
> type=AVC msg=audit(1213025579.030:9446): avc:  denied  { append } for
> pid=2233 comm="ping"
> path="/opt/nl/nltmp/clarkson/NLdata/.mbdev2_2008Jun09_1527_1415.txt"
> dev=sda8 ino=684396 scontext=root:staff_r:ping_t:s0-s4:c0.c255
> tcontext=root:object_r:nl_tmp_data_t:s0 tclass=file
> 
> The first denial surprises me because I would have thought that the ping
> program would be creating its own TCP socket and thus I would not expect
> the socket to be labeled with the monitorsvcutil_t type.
> 
> The second denial surprises me because the ping program does not have
> anything to do with the ".mbdev2_2008Jun09_1527_1415.txt" file. This
> seems to indicate that once the ping process completes and returns to
> the MonitorSvcUtil process, the domain remains ping_t rather than
> returning to monitorsvcutil_t.


No, this shows that your MonitorSvcUtil program is leaking open file
descriptors when it runs ping, and SELinux is correctly checking them
upon inheritance across execve and closing them if unauthorized.  Bug in
your program - you should be marking the descriptors as close-on-exec
and/or closing them all before exec'ing ping.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
