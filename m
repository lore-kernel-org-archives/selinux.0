Message-Id: <200503202320.j2KNKA8R029138@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Luke Kenneth Casson Leighton'" <lkcl@lkcl.net>
Cc: "'Stephen Smalley'" <sds@tycho.nsa.gov>,
   "'Kaigai Kohei'" <kaigai@ak.jp.nec.com>,
   "'KaiGai Kohei'" <kaigai@kaigai.gr.jp>,
   "'SELinux Mail List'" <selinux@tycho.nsa.gov>, <selinux-dev@tresys.com>
Subject: RE: [RFC & PATCH] inherited type definition.
Date: Sun, 20 Mar 2005 18:20:09 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20050318230350.GM8040@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Luke Kenneth Casson Leighton [mailto:lkcl@lkcl.net] 
> Sent: Friday, March 18, 2005 6:04 PM
> To: Karl MacMillan
> Cc: 'Stephen Smalley'; 'Kaigai Kohei'; 'KaiGai Kohei'; 
> 'SELinux Mail List'; selinux-dev@tresys.com
> Subject: Re: [RFC & PATCH] inherited type definition.
> 
> On Fri, Mar 18, 2005 at 05:28:57PM -0500, Karl MacMillan wrote:
> > Also, the more I think about it the more convinced I am that the 
> > show-stopper limitation of the extends syntax is that it 
> allows only one subset of access.
> 
>  there is nothing to stop you using an extends inside a macro:
> 
> 	 $1_t EXTENDS $1_ftp_t
> 
>  l.
> 

How does this address the problem - only one subset of access from $1_ftp_t can
be marked with the @ syntax.

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134  


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
