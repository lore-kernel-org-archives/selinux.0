Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l78HNwLV019773
	for <selinux@tycho.nsa.gov>; Wed, 8 Aug 2007 13:23:58 -0400
Received: from rv-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l78HNvSH023458
	for <selinux@tycho.nsa.gov>; Wed, 8 Aug 2007 17:23:57 GMT
Received: by rv-out-0910.google.com with SMTP id k15so171482rvb
        for <selinux@tycho.nsa.gov>; Wed, 08 Aug 2007 10:23:56 -0700 (PDT)
Message-ID: <7b740b700708081023g2da83502wb8bc42691ca7c4ea@mail.gmail.com>
Date: Wed, 8 Aug 2007 22:23:56 +0500
From: "shahbaz khan" <shazalive@gmail.com>
To: Mark <elihusmails@gmail.com>
Subject: Re: only allow 1 port for listening
Cc: selinux@tycho.nsa.gov, fedora-selinux-list@redhat.com
In-Reply-To: <9f066ee90708080840q627adbbavb9e83b45a9f017e8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1733_10043160.1186593836173"
References: <9f066ee90708080840q627adbbavb9e83b45a9f017e8@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_1733_10043160.1186593836173
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 8/8/07, Mark <elihusmails@gmail.com> wrote:
>
> I am new to writing policies and have been reading the reference policy
> files.  I wrote a simple TCP server that listens on a port for connections.
> I would like to write a policy that will only allow my program to bind to a
> specific port(9999).  I looked at the reference policy and see that the
> ports that programs are allowed to use is in
> policy/modules/kernel/corenetwork.te.  My questions is, can I specify the
> port in my programs type enforcement file so that I can make a module
> instead of listing this in the kernel policy?  If so, what would the syntax
> be?


This is the best help you can get:

 http://securityblog.org/brindle/2007/05/28/secure-networking-with-selinux/

This is a good description keeping everything to the point by Joshua Brindle
of Tresys. If you want details try "Networking in NSA security-enhanced
linux" by James Moris of Red Hat:

https://www.redhat.com/f/pdf/sec/Networking_in_NSA-SELinux.pdf

Shaz.


> Thanks in advance.
>
> --
> ..Cheers
> Mark

------=_Part_1733_10043160.1186593836173
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br>
<div><span class="gmail_quote">On 8/8/07, <b class="gmail_sendername">Mark</b> &lt;<a href="mailto:elihusmails@gmail.com">elihusmails@gmail.com</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">I am new to writing policies and have been reading the reference policy files.&nbsp; I wrote a simple TCP server that listens on a port for connections.&nbsp; I would like to write a policy that will only allow my program to bind to a specific port(9999).&nbsp; I looked at the reference policy and see that the ports that programs are allowed to use is in policy/modules/kernel/corenetwork.te.&nbsp; My questions is, can I specify the port in my programs type enforcement file so that I can make a module instead of listing this in the kernel policy?&nbsp; If so, what would the syntax be? 
</blockquote>
<div>&nbsp;</div>
<div>This is the best help you can get:</div>
<div>&nbsp;&nbsp;&nbsp; </div>
<div><font color="#0000cc">&nbsp;</font><a href="http://securityblog.org/brindle/2007/05/28/secure-networking-with-selinux/">http://securityblog.org/brindle/2007/05/28/secure-networking-with-selinux/</a></div>
<div>&nbsp;</div>
<div>This is a good description keeping everything to the point by Joshua Brindle of Tresys. If you want details try &quot;Networking in NSA security-enhanced linux&quot; by James Moris of Red Hat:</div>
<div>&nbsp;</div>
<div><a href="https://www.redhat.com/f/pdf/sec/Networking_in_NSA-SELinux.pdf">https://www.redhat.com/f/pdf/sec/Networking_in_NSA-SELinux.pdf</a></div>
<div><br>Shaz.</div>
<div>&nbsp;</div>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Thanks in advance.<br clear="all"><br>-- <br>..Cheers<br><span class="sg">Mark </span></blockquote></div><br>

------=_Part_1733_10043160.1186593836173--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
