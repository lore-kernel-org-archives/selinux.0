Message-ID: <44D0B3F3.9010007@hp.com>
Date: Wed, 02 Aug 2006 10:17:23 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org, sds@tycho.nsa.gov,
        tjaeger@cse.psu.edu
Subject: Re: [PATCH 10/10] MLSXFRM-v02: Auto-labeling of child sockets
References: <36282A1733C57546BE392885C061859201466C5E@chaos.tcs.tcs-sec.com>
In-Reply-To: <36282A1733C57546BE392885C061859201466C5E@chaos.tcs.tcs-sec.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Venkat Yekkirala wrote:
>>Hmmm.  I think we are having a bit of a disconnect here, 
>>perhaps I'm not
>>explaining myself very clearly so let me give it another shot.
>>
>>Please look at net/socket.c:sys_accept() and pay attention to what
>>happens to the child socket 'newsock' ...
>>
>> 1. The child 'newsock', 'struct socket' type, is allocated 
>>by a call to
>>    sock_alloc()
>> 2. 'newsock' inherits it's 'type' and 'ops' fields from it's parent,
>>    'struct socket' socket, 'sock'
>> 3. A new file descriptior is allocated for 'newsock', the file
>>    descriptior is called 'newfd'
>> 4. 'newfd' is associated with 'newsock'
>> 5. 'security_socket_accept()' is called
>> 6. ...
>>
>>Unless I'm mistaken, nowhere in the first four steps does the
>>'newsock->sk' field get populated by a 'struct sock *' from the accept
>>queue of 'sock'.  The result is that when
>>'{security,selinux}_socket_accept()' is called the child's 
>>'sk' field is
>>not yet valid meaning the inode associated with the child's 
>>socket will
>>be labeled with the parent socket's SID.
> 
> The sequence you mention is 100% correct. But you need to look past the
> above.
> Like I mentioned yesterday, this sid is replaced with the one from the
> child "sock" in selinux_sock_graft().

Thanks, that is what I was missing.  I misunderstood your comment
yesterday about sock_graft().  Sorry for the confusion on my part.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
