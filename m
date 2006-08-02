Message-ID: <44D0AEA6.6040107@hp.com>
Date: Wed, 02 Aug 2006 09:54:46 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org, sds@tycho.nsa.gov,
        tjaeger@cse.psu.edu
Subject: Re: [PATCH 10/10] MLSXFRM-v02: Auto-labeling of child sockets
References: <36282A1733C57546BE392885C061859201466C35@chaos.tcs.tcs-sec.com>
In-Reply-To: <36282A1733C57546BE392885C061859201466C35@chaos.tcs.tcs-sec.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Venkat Yekkirala wrote:
>>>>Am I missing something here?  Am I thinking about this wrong?
>>>
>>>While selinux_socket_accept() does set/initialize the child 
>>
>>"socket's" sid
>>
>>>with the parent's sid, this sid is replaced with the one from the
>>>child "sock" in selinux_sock_graft().
>>>
>>>Again, are you noticing descrepancies at execution time or 
>>
>>just browsing
>>
>>>the patch? If the former, could you point to the code path?
>>
>>I understand how the sk_security_struct->sid, if present, is 
>>used to set
>>the inode_security_struct->sid in selinux_socket_accept().  
>>However, if
>>I understand the code correctly in the normal accept() case the
>>selinux_socket_accept() hook is called before a connection if taken of
>>the accept queue, meaning that socket->sk (and hence 
>>sk_security_struct)
>>do not yet exist.
> 
> 
> Not true. The child "sock" will already have been created and tied to
> the request_sock before the request_sock gets onto the accept queue. Look
> at:
> tcp_v4_syn_recv_sock, inet_csk_reqsk_queue_add, reqsk_queue_add and
> finally at inet_accept.
> 

Hmmm.  I think we are having a bit of a disconnect here, perhaps I'm not
explaining myself very clearly so let me give it another shot.

Please look at net/socket.c:sys_accept() and pay attention to what
happens to the child socket 'newsock' ...

 1. The child 'newsock', 'struct socket' type, is allocated by a call to
    sock_alloc()
 2. 'newsock' inherits it's 'type' and 'ops' fields from it's parent,
    'struct socket' socket, 'sock'
 3. A new file descriptior is allocated for 'newsock', the file
    descriptior is called 'newfd'
 4. 'newfd' is associated with 'newsock'
 5. 'security_socket_accept()' is called
 6. ...

Unless I'm mistaken, nowhere in the first four steps does the
'newsock->sk' field get populated by a 'struct sock *' from the accept
queue of 'sock'.  The result is that when
'{security,selinux}_socket_accept()' is called the child's 'sk' field is
not yet valid meaning the inode associated with the child's socket will
be labeled with the parent socket's SID.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
