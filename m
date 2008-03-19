Subject: Re: unix_domain_sockets in mls
From: Stephen Smalley <sds@tycho.nsa.gov>
To: B Topscher <bryan@jennandbryan.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <8b4cbe570803190704u56b1181ta9502561324dd7f4@mail.gmail.com>
References: <8b4cbe570803190704u56b1181ta9502561324dd7f4@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 19 Mar 2008 10:43:18 -0400
Message-Id: <1205937798.6466.223.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-03-19 at 10:04 -0400, B Topscher wrote:
> FWD from a coworker:
> 
> 
> I'm a policy newbie, writing a custom module to allow streaming data
> through unix domain sockets on an mls system.
> 
>  
> 
> My problem is that, no matter what I do, I can't seem to transition
> either the type or the level of the unix_stream_socket.

Transitions would apply to the socket file, not to the socket itself.
They are two distinct objects with distinct labels - the file is merely
a way of referencing the Unix/local socket, much as a port is merely a
way of referencing a TCP socket.

Sockets always inherit the context of their creator unless the task used
the setsockcreatecon() interface of libselinux.  Except for new
connection sockets, which have a mixed model - they inherit the type
from the server but the MLS level from the client in order to reflect
back the client's level for level preservation.

> My three processes have the following contexts:
> 
> system_u:servA_r:servA_t:s4:c1
> 
> system_u:levmA_r:levmA_t:s4-s4:c1,c100
> 
> system_u:FCM_r:FCM_t:s4:c100
> 
>  
> 
> Ideally, servA should be able to talk to levmA on a unix_stream_socket
> at running at s4:c1, levmA should be able to read from s4:c1 and
> writeinrange (via a custom mls attribute and a modification of the
> mlsconstraints) to s4:c100. Another perfectly acceptable solution
> would be to set the levmA unix_stream_socket to levmA's clearance
> level (s4:c1,c100). What's important here is that I do not want to
> allow the servA_t context to "write-down".  That should be reserved
> only to the levm process.
> 
>  
> 
> What I'm seeing is that, regardless of the permissions on the
> sock_file, when levmA connects to the servA unix_stream_socket, the
> target context takes the servA_t type, but keeps the mls level of the
> levmA process. The AVC message is as follows:
> 
> type=AVC msg=audit(1205874819.221:1476): avc:  denied  { write } for
> pid=3303 comm="ServA" name="[59950]" dev=sockfs ino=59950
> scontext=system_u:servA_r:servA_t:s4:c1
> tcontext=system_u:servA_r:servA_t:s4-s4:c1,c100
> tclass=unix_stream_socket

This isn't related to the socket file.  What appears to be happening
here is that the server accepted a connection from the client, and the
new connection socket was labeled with the type of the server and the
level of the client, which is correct.  Then when the server tries to
write on that connection, it gets denied due to the mismatch in MLS
ranges - the server is only running at s4:c1 while the client is ranged.

Transitions aren't going to help with this issue.

> 
>         Was caused by:
> 
>                 Constraint violation.
> 
>                 Check policy/constraints.
> 
>                 Typically, you just need to add a type attribute to
> the domain to satisfy the constraint.
> 
>  
> 
> It's failing because that ranged tcontext s4-s4:c1,c100 makes it a
> "write-down" operation (s4:c1 to s4). I have found nothing that can
> actually affect the context of the target unix_stream_socket. What am
> I missing?
> 
>  
> 
> Here are some of the relevant snippets of the policy:
> 
>  
> 
> #from the .te file.  
> 
> levm_bidir(high, levmA, h2l, s4, c1, servA, s4, c100, FCM)
>                                     
> 
> levm_bidir(high, levmA, h2l, s4, c100, FCM, s4, c1, servA)
> 
>  
> 
> #from the .if file. Lots of superfluous transition statements to see
> if anything can affect the unix_stream_socket
> 
>     allow $2_t self:unix_stream_socket { create_stream_socket_perms
> connectto }; 
> 
>     allow $2_t $9_t:unix_stream_socket { create_stream_socket_perms
> connectto };            
> 
>     allow $9_t self:unix_stream_socket { create_stream_socket_perms
> connectto };             
> 
>     filetrans_add_pattern($2_t, $9_dir_t, $9_t, file)
> 
>     filetrans_add_pattern($2_t, $9_dir_t, $9_t, sock_file)
> 
>     filetrans_add_pattern($2_t, $9_t, $2_t, unix_stream_socket)
> 
>     filetrans_add_pattern($2_t, $9_dir_t, $2_t, unix_stream_socket)
> 
>     range_transition $2_t $9_dir_t:file $7:$8;
> 
>     range_transition $2_t $9_dir_t:sock_file $7:$8;
> 
>     range_transition $2_t $9_t:unix_stream_socket $7:8;
> 
>     range_transition $2_t $2_t:unix_stream_socket $7:8;
> 
>     range_transition $9_t $9_t:unix_stream_socket $7:8;
> 
>  
> 
> Best regards,
> 
>  
> 
> Tim 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
