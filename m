Message-ID: <20041126185018.56868.qmail@web51503.mail.yahoo.com>
Date: Fri, 26 Nov 2004 10:50:18 -0800 (PST)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Re: Issue on getting security context of socket and message
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SELinux@tycho.nsa.gov, fedora-selinux-list@redhat.com
In-Reply-To: <1100014761.408.112.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1484574452-1101495018=:56376"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-1484574452-1101495018=:56376
Content-Type: text/plain; charset=us-ascii

On Tue, 09 Nov 2004 at 10:39, Stephen Smalley wrote:
> In the kernel, you can obtain the security context of a socket via the
> security field of its associated inode.  Look at socket_has_perm() 
> and selinux_socket_sock_rcv_skb() in security/selinux/hooks.c for 
> examples. 

I'm now trying to do something on integrating IPsec with SELinux. Now I need to get the security context of a socket and the socket itself.
Would you please tell me further that when an outbound packet is going to be send, How can we get the struct socket itself (i.e. the socket that is related to the outbound packet. it refers that when we want to send the packet, we should first set up the socket )? 
 
And, in kernel-space, How can we transfer a SID to a security context? Is there any function can we use to achieve it?
 
Thank you.
 


--
Best Regards,
Park Lee <parklee_sel@yahoo.com> 
 






__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-1484574452-1101495018=:56376
Content-Type: text/html; charset=us-ascii

<DIV>On Tue, 09 Nov 2004 at 10:39, Stephen Smalley wrote:</DIV>
<DIV>&gt; In the kernel, you can obtain the security context of a socket via the</DIV>
<DIV>&gt; security field of its associated inode.&nbsp; Look at socket_has_perm() </DIV>
<DIV>&gt; and selinux_socket_sock_rcv_skb() in security/selinux/hooks.c for </DIV>
<DIV>&gt; examples. <BR></DIV>
<DIV>I'm now trying to do something on integrating IPsec with SELinux. Now I need to get the security context of a socket and the socket itself.</DIV>
<DIV>Would you please tell me further that when an outbound packet is going to be send, How can we&nbsp;get the struct socket&nbsp;itself&nbsp;(i.e. the socket that is&nbsp;related to the outbound packet. it refers that when we want to send the packet, we should first set up the socket )? </DIV>
<DIV>&nbsp;</DIV>
<DIV>And, in&nbsp;kernel-space, How can we transfer a SID to a security context? Is there any&nbsp;function&nbsp;can we use to achieve it?</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thank you.</DIV>
<DIV>&nbsp;</DIV><BR><BR><DIV>
<DIV>
<DIV>
<DIV>
<DIV>
<DIV>--<BR>Best Regards,<BR>Park Lee &lt;<A href="http://us.f515.mail.yahoo.com/ym/Compose?To=parklee_sel@yahoo.com&amp;YY=1156&amp;order=down&amp;sort=date&amp;pos=0"><FONT color=#003399>parklee_sel@yahoo.com</FONT></A>&gt; </DIV>
<DIV>&nbsp;</DIV></DIV></DIV></DIV></DIV></DIV><p>__________________________________________________<br>Do You Yahoo!?<br>Tired of spam?  Yahoo! Mail has the best spam protection around <br>http://mail.yahoo.com 
--0-1484574452-1101495018=:56376--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
