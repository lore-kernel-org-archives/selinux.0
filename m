Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m810ovYs014468
	for <selinux@tycho.nsa.gov>; Sun, 31 Aug 2008 20:50:57 -0400
Received: from rv-out-0708.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m810oMVk000294
	for <selinux@tycho.nsa.gov>; Mon, 1 Sep 2008 00:50:23 GMT
Received: by rv-out-0708.google.com with SMTP id f25so1557505rvb.54
        for <selinux@tycho.nsa.gov>; Sun, 31 Aug 2008 17:50:56 -0700 (PDT)
References: <dd18b0c30808311634k683b139fm9f17810a66a81074@mail.gmail.com> <f00ed96d0808311732x76e42755l5565a3e8ef384632@mail.gmail.com>
Message-Id: <81A3674C-CF2C-4E31-B8B8-0D72BCB8C357@gmail.com>
From: "Justin P. Mattock" <justinmattock@gmail.com>
To: Hong <kindloaf@gmail.com>
In-Reply-To: <f00ed96d0808311732x76e42755l5565a3e8ef384632@mail.gmail.com>
Content-Type: multipart/alternative;
	boundary=Apple-Mail-1--742600992
Mime-Version: 1.0 (iPhone Mail 5C1)
Subject: Re: checkpolicy: error(s) encountered while parsing configuration
Date: Sun, 31 Aug 2008 17:50:49 -0700
Cc: SE Linux <selinux@tycho.nsa.gov>, tresys <refpolicy@oss.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Apple-Mail-1--742600992
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

Maybe there is an updated package
For this, other than that I just used
The .tar.bz2 and everything works
Fine.

justin P. Mattock



On Aug 31, 2008, at 5:32 PM, Hong <kindloaf@gmail.com> wrote:

> Hi,
>
> I also found the same problem.  I downloaded refpolicy source and  
> tried to compile it under ubuntu 8.04.  Looks like  
> corenet_raw_send_multicast_node is an interface(or macro?).  And it  
> is not defined anywhere.
>
> Hong
>
> On Sun, Aug 31, 2008 at 7:34 PM, Justin Mattock <justinmattock@gmail.com 
> > wrote:
> when loading the latest refpolicy I'm seing a
> policy/modules/kernel/kernel.te":237:ERROR 'syntax error' at token  
> 'corenet_raw_
> corenet_raw_send_multicast_node(kernel_t)
>
> not sure if this is checkpolicy or refpolicy
> --
> Justin P. Mattock
>
> --
> This message was distributed to subscribers of the selinux mailing  
> list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov 
>  with
> the words "unsubscribe selinux" without quotes as the message.
>

--Apple-Mail-1--742600992
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: 7bit

<html><body bgcolor="#FFFFFF"><div>Maybe there is an updated package</div><div>For this, other than that I just used</div><div>The .tar.bz2 and everything works</div><div>Fine.<br><br>justin P. Mattock<div><br></div><div><br></div></div><div><br>On Aug 31, 2008, at 5:32 PM, Hong &lt;<a href="mailto:kindloaf@gmail.com">kindloaf@gmail.com</a>> wrote:<br><br></div><div></div><blockquote type="cite"><div><div dir="ltr">Hi,<br><br>I also found the same problem.&nbsp; I downloaded refpolicy source and tried to compile it under ubuntu 8.04.&nbsp; Looks like 
corenet_raw_send_multicast_node is an interface(or macro?).&nbsp; And it is not defined anywhere.<br><br>Hong<br><br><div class="gmail_quote">On Sun, Aug 31, 2008 at 7:34 PM, Justin Mattock <span dir="ltr">&lt;<a href="mailto:justinmattock@gmail.com"><a href="mailto:justinmattock@gmail.com">justinmattock@gmail.com</a></a>></span> wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">when loading the latest refpolicy I'm seing a<br>
policy/modules/kernel/kernel.te":237:ERROR 'syntax error' at token 'corenet_raw_<br>
corenet_raw_send_multicast_node(kernel_t)<br>
<br>
not sure if this is checkpolicy or refpolicy<br>
--<br>
Justin P. Mattock<br>
<font color="#888888"><br>
--<br>
This message was distributed to subscribers of the selinux mailing list.<br>
If you no longer wish to subscribe, send mail to <a href="mailto:majordomo@tycho.nsa.gov"><a href="mailto:majordomo@tycho.nsa.gov">majordomo@tycho.nsa.gov</a></a> with<br>
the words "unsubscribe selinux" without quotes as the message.<br>
</font></blockquote></div><br></div>
</div></blockquote></body></html>
--Apple-Mail-1--742600992--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
