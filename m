Date: Fri, 1 Sep 2006 14:47:59 -0500
From: Joy Latten <latten@austin.ibm.com>
Message-Id: <200609011947.k81JlxUF020293@faith.austin.ibm.com>
To: latten@us.ibm.com, vyekkirala@TrustedCS.com
Subject: RE: ipsec and getpeercon()
Cc: jbrindle@tresys.com, paul.moore@hp.com, sds@tycho.nsa.gov,
        selinux@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Yes, that is coming from netlabel. In selinux_socket_getpeersec_stream()
if the socket is tcp_socket class, we call the cipso routine
first, selinux_netlbl_socket_getpeersec_stream(). I have not
thoroughly examined the cipso code, but at a glance I assumed
if cipso is enabled and its maps set up, this will come back with
something. If it doesn't come back with anything, I assumed
that meant cipso is either disabled or its maps not set up. 
According to code, if nothing comes back from cipso, then 
selinux_socket_getpeer_stream() is called which will look 
for a xfrm on the dst. And if there is one, then use the security
context from the xfrm. Otherwise, return error.


hmmm... this makes me wonder if Joshua had cipso enabled and that is why
it looks like getpeercon was not honoring the ipsec labels... 

Joy

>Actually this must be coming out of netlabel. In selinux_netlbl_sock_graft()
>I see
> 
>        sksec->nlbl_state = NLBL_REQUIRE;
>        sksec->peer_sid = sksec->sid;
>        sksec->sclass = isec->sclass;
> 
>        /* Try to set the NetLabel on the socket to save time later, if we
>fail
>         * here we will pick up the pieces in later calls to
>         * selinux_netlbl_inode_permission(). */
>        selinux_netlbl_socket_setsid(sock, sksec->sid);
>
>and selinux_netlbl_socket_getpeersec_stream returns peer_sid set above and
>the xfrm version of getpeersec never gets invoked.
>
>-----Original Message-----
>From: Joy Latten [mailto:latten@us.ibm.com]
>Sent: Friday, September 01, 2006 11:05 AM
>To: Venkat Yekkirala
>Cc: Joshua Brindle; paul.moore@hp.com; Stephen Smalley;
>selinux@tycho.nsa.gov
>Subject: RE: ipsec and getpeercon()
>
>
>
>Venkat Yekkirala <vyekkirala@TrustedCS.com> wrote on 09/01/2006 08:16:32 AM:
>
>> > Ok, aside from the bug I'm apparently experiencing (Joy is 
>> > looking in to
>> > it) I think I have misunderstood what getpeercon() is suppose 
>> > to do over
>> > ipsec. I was under the impression it would act like getpeercon() over
>> > unix stream sockets and get the context of the application on 
>> > the other
>> > side of the socket but that is apparently not what getpeercon() for
>> > ipsec does.
>> 
>> It should indeed return the peer's context when using ipsec as well.
>> I would consider the current behaviour as a bug. Joy is looking but
>> I will try to take a look as well.
>
>Ok, I looked at the code, and yes, in the hook, if the socket class is
>tcp_socket, 
>the dst for the socket is examined for a xfrm (in other words, an SA). If
>there is a 
>xfrm, the context in the xfrm is used. Otherwise, we return -ENOPROTOOPT. 
>
>So yes, it is assumed that the context in the SA associated with the
>destination 
>is the peer's context. I have always viewed labeled SAs as meaning, I want
>to restrict 
>access to this socket/traffic stream to this context. 
>  
>Joy 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
