Message-ID: <8c2dc7030612030114l4da1eff4ma21492aa5a325664@mail.gmail.com>
Date: Sun, 3 Dec 2006 17:14:33 +0800
From: "Jian Liu" <gjk.liu@gmail.com>
To: SELinux@tycho.nsa.gov
Subject: Re: how to test ssh_sysadm_login(tunable)
In-Reply-To: <200612012117.52567.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_17923_22787391.1165137273041"
References: <8c2dc7030612010133j5709d6b1k72f44e40ed58dbcd@mail.gmail.com>
	 <200612012117.52567.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_17923_22787391.1165137273041
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 12/1/06, Russell Coker <russell@coker.com.au> wrote:
>
> On Friday 01 December 2006 20:33, "Jian Liu" <gjk.liu@gmail.com> wrote:
> > In refpolicy, there is a global tunable named "ssh_sysadm_login". It
> means
> > "Allow ssh logns as sysamd_r:sysadm_t".
> > How to use this tunable?
> >
> > I have tested it on my lab, and find It is always allowed to "newrole -r
> > sysadm_r -t sysadm_t" after sshed
> > to my test server, not mattering ssh_sysadm_login is on or off on the
> > server.
>
> That is the way it's designed.
>
> The boolean in question determines whether you are permitted to ssh
> directly
> as sysadm_t, not whether you can run newrole after that.
>

But, after "ssh_sysadm_login" is set to on, there is
not a login menu containing
"sysadm_r:sysadm_t". Moreover, when I use ssh , there is no any scontext
select
menu as local login.

 by Liu Jian
------------
email to: GJK.Liu@gmail.com

------=_Part_17923_22787391.1165137273041
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">On 12/1/06, <b class="gmail_sendername">Russell Coker</b> &lt;<a href="mailto:russell@coker.com.au">russell@coker.com.au</a>&gt; wrote:</span><blockquote class="gmail_quote" style="margin-top: 0; margin-right: 0; margin-bottom: 0; margin-left: 0; margin-left: 0.80ex; border-left-color: #cccccc; border-left-width: 1px; border-left-style: solid; padding-left: 1ex">
On Friday 01 December 2006 20:33, &quot;Jian Liu&quot; &lt;<a href="mailto:gjk.liu@gmail.com">gjk.liu@gmail.com</a>&gt; wrote:<br>&gt; In refpolicy, there is a global tunable named &quot;ssh_sysadm_login&quot;. It means<br>
&gt; &quot;Allow ssh logns as sysamd_r:sysadm_t&quot;.<br>&gt; How to use this tunable?<br>&gt;<br>&gt; I have tested it on my lab, and find It is always allowed to &quot;newrole -r<br>&gt; sysadm_r -t sysadm_t&quot; after sshed
<br>&gt; to my test server, not mattering ssh_sysadm_login is on or off on the<br>&gt; server.<br><br>That is the way it's designed.<br><br>The boolean in question determines whether you are permitted to ssh directly<br>as sysadm_t, not whether you can run newrole after that.
<br></blockquote></div><br>But, after &quot;ssh_sysadm_login&quot; is set to on, there is<br>not a login menu containing<br>&quot;sysadm_r:sysadm_t&quot;. Moreover, when I use ssh , there is no any scontext<br>select<br>menu as local login.
<br><br>&nbsp;by Liu Jian<br>------------<br>email to: <a href="mailto:GJK.Liu@gmail.com">GJK.Liu@gmail.com</a> 

------=_Part_17923_22787391.1165137273041--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
