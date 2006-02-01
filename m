From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: labeling of compilers etc
Date: Thu, 2 Feb 2006 10:15:18 +1100
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux-dev@tresys.com,
   SELinux List <selinux@tycho.nsa.gov>
References: <200601291156.13076.russell@coker.com.au> <200602011922.23667.russell@coker.com.au> <43E0AEEF.3060602@redhat.com>
In-Reply-To: <43E0AEEF.3060602@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200602021015.30011.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 01 February 2006 23:51, Daniel J Walsh <dwalsh@redhat.com> wrote:
> >> Most of the applications that were named in this discussion would be
> >> blocked by a properly locked down domain anyways, by the name_connect
> >> check.
> >
> > What do you mean?  How does name_connect relate to executing code on a
> > USB device?
>
> YOu mentioned confined domains calling out to tools like wget, ftp ...
> which would be blocked by name_connect.

tunable_policy(`httpd_can_network_connect_db',`
        # allow httpd to connect to mysql/posgresql
        corenet_tcp_connect_postgresql_port(httpd_t)
        corenet_tcp_connect_mysqld_port(httpd_t)
')

tunable_policy(`httpd_can_network_relay',`
        # allow httpd to work as a relay
        corenet_tcp_connect_gopher_port(httpd_t)
        corenet_tcp_connect_ftp_port(httpd_t)
        corenet_tcp_connect_http_port(httpd_t)
        corenet_tcp_connect_http_cache_port(httpd_t)
')

If either of the above booleans are on then there are plenty of connection 
options open.  I suspect that most significant Apache installations would 
need database connections.  Until we get the ability to install netfilter 
rules based on SE Linux context we have the situation that allowing 
connection to a database server on the LAN also means allowing connection to 
the same port on the public Internet.  If there is no firewall to stop this 
(the fact that there are Linux worms operating in such manner suggests that 
such firewalls aren't common enough) then that becomes an attack vector.  
Usually when someone starts a bot-net they have full control over a server 
and can serve such data on any port.

Also Apache can create files in the /tmp directory.  Presumably whatever 
method is used to execute an interpreter can also be used to write some 
arbitrary data in files under /tmp, or just pipe the data to the interpreter.  
The plan I outlined would prevent such execution.  It would allow any process 
that is permitted to execute bin_t and shell_exec_t to run 
"bash /bin/igawk" (igawk being a randomly selected bin_t labeled script on my 
system), but it wouldn't be able to run "bash /sbin/adsl-connect" unless it 
had execute access to sbin_t even if it had read access.

My plan would also allow us to permit a domain to use system(3) without 
permitting the execution of shell code (apart from that which can be passed 
as a command-line parameter).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
