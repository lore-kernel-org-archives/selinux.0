Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8ICfc3i008418
	for <selinux@tycho.nsa.gov>; Mon, 18 Sep 2006 08:41:39 -0400
Received: from twoface.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8ICf9OQ010425
	for <selinux@tycho.nsa.gov>; Mon, 18 Sep 2006 12:41:10 GMT
Subject: Re: C++ reserved word 'class' used in selinux/avc.h with patch
From: Joshua Brindle <jbrindle@tresys.com>
To: Joe Nall <joe@nall.com>
Cc: SELinux List <selinux@tycho.nsa.gov>,
        John Wiseman <john.wiseman@L-3Com.com>
In-Reply-To: <67358AB2-DB43-4555-9E0A-77180679B0FC@nall.com>
References: <67358AB2-DB43-4555-9E0A-77180679B0FC@nall.com>
Content-Type: text/plain; charset=utf-8
Date: Mon, 18 Sep 2006 08:43:02 -0400
Message-Id: <1158583382.8680.36.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-09-15 at 18:08 -0500, Joe Nall wrote:
> John Wiseman noticed that 'class', a reserved word in C++, is used  
> in /usr/include/selinux/avc.h.
> 
> Save the following code as test.cc and compile
> 
> #include <selinux/avc.h>
> 
> int
> main (int, char **)
>      {
>      }
> 
> results are
> 
> cc test.cc
> /usr/include/selinux/avc.h:123: error: expected identifier before ‘,’  
> token
> /usr/include/selinux/avc.h:124: error: two or more data types in  
> declaration of ‘parameter’
> 
> Fix:
> 
> --- avc.h.orig  2006-09-15 12:48:44.000000000 -0500
> +++ avc.h       2006-09-15 12:49:02.000000000 -0500
> @@ -120,7 +120,7 @@ extern "C" {
>                  void (*func_log) (const char *fmt, ...);
>                  /* store a string representation of auditdata  
> (corresponding
>                     to the given security class) into msgbuf. */
> -               void (*func_audit) (void *auditdata, security_class_t  
> class,
> +               void (*func_audit) (void *auditdata, security_class_t  
> cls,
>                                      char *msgbuf, size_t msgbufsize);
>          };
> 
> 

Acked-By: Joshua Brindle <jbrindle@tresys.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
