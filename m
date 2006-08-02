Message-ID: <44D0A28C.4000508@hp.com>
Date: Wed, 02 Aug 2006 09:03:08 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org, sds@tycho.nsa.gov,
        tjaeger@cse.psu.edu
Subject: Re: [PATCH 10/10] MLSXFRM-v02: Auto-labeling of child sockets
References: <36282A1733C57546BE392885C061859201466BEC@chaos.tcs.tcs-sec.com>
In-Reply-To: <36282A1733C57546BE392885C061859201466BEC@chaos.tcs.tcs-sec.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Venkat Yekkirala wrote:
>>Venkat Yekkirala wrote:
>>>This automatically labels the TCP, Unix stream, and dccp 
>>child sockets
>>>as well as openreqs to be at the same MLS level as the 
>>peer. This will
>>>result in the selection of appropriately labeled IPSec 
>>Security Associations.
>>>This also uses the sock's sid (as opposed to the isec sid) 
>>in SELinux enforcement
>>>of secmark in rcv_skb and postroute_last hooks.
>>>
>>>Signed-off-by: Venkat Yekkirala <vyekkirala@TrustedCS.com>
>>
>>NOTE: I dropped netdev from the cc line as this seems like more of a
>>SELinux issue and not a generic network problem.
>>
>>I'm in the process of merging the NetLabel patch into the MLSXFRM
>>patches in DaveM's net-2.6.19 tree and I'm noticing that in general
>>while the sock's sid is updated to match the incoming connection, the
>>associated socket's inode is still set to the parent 
>>socket/inode's sid
>>and not the child sock's sid.  As a result the inode's sid and sock's
>  
> Have you noticed it in the code or in actual execution?

I'm still in the process of merging my code, I haven't tried running it
yet - so this is purely from inspection of the code.

>>sid of accept()ed connections could be different leading to 
>>some strange
>>(and I believe improper) behavior ...
>>
>>Am I missing something here?  Am I thinking about this wrong?
> 
> While selinux_socket_accept() does set/initialize the child "socket's" sid
> with the parent's sid, this sid is replaced with the one from the
> child "sock" in selinux_sock_graft().
> 
> Again, are you noticing descrepancies at execution time or just browsing
> the patch? If the former, could you point to the code path?

I understand how the sk_security_struct->sid, if present, is used to set
the inode_security_struct->sid in selinux_socket_accept().  However, if
I understand the code correctly in the normal accept() case the
selinux_socket_accept() hook is called before a connection if taken of
the accept queue, meaning that socket->sk (and hence sk_security_struct)
do not yet exist.  The end result being that the socket's associated
inode_security_struct gets labeled with the parent's
inode_security_struct->sid and not the child's sk_security_struct->sid.

I might be wrong, but I'm looking at the code again as I type this and I
just don't see where the child socket's inode_security_struct->sid is
labeled based on the sk_security_struct->sid.  The problem would be
whenever {socket,file,inode}_has_perm() is called because these
functions use the inode_security_struct - I believe it would be
possibile for a process to read from a higher level connection as a result.

The solution I'm thinking of is rather simple, if we agree that this is
a problem I can post a quick patch.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
