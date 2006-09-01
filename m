Message-ID: <44F895EF.5070706@hp.com>
Date: Fri, 01 Sep 2006 16:19:59 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Joy Latten <latten@austin.ibm.com>
Cc: latten@us.ibm.com, vyekkirala@TrustedCS.com, jbrindle@tresys.com,
        sds@tycho.nsa.gov, selinux@tycho.nsa.gov
Subject: Re: ipsec and getpeercon()
References: <200609011947.k81JlxUF020293@faith.austin.ibm.com>
In-Reply-To: <200609011947.k81JlxUF020293@faith.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joy Latten wrote:
> Yes, that is coming from netlabel. In selinux_socket_getpeersec_stream()
> if the socket is tcp_socket class, we call the cipso routine
> first, selinux_netlbl_socket_getpeersec_stream(). I have not
> thoroughly examined the cipso code, but at a glance I assumed
> if cipso is enabled and its maps set up, this will come back with
> something. If it doesn't come back with anything, I assumed
> that meant cipso is either disabled or its maps not set up. 
> According to code, if nothing comes back from cipso, then 
> selinux_socket_getpeer_stream() is called which will look 
> for a xfrm on the dst. And if there is one, then use the security
> context from the xfrm. Otherwise, return error.
>  
> hmmm... this makes me wonder if Joshua had cipso enabled and that is why
> it looks like getpeercon was not honoring the ipsec labels... 
> 

A simple 'dmesg | grep NetLabel' will answer that question.

I'll work on this and post something next week.  Unfortunately, the fix
is not immediately obvious.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
