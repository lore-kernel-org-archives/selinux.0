Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7T3jexA002819
	for <selinux@tycho.nsa.gov>; Thu, 28 Aug 2008 23:45:40 -0400
Received: from rv-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7T3jdXZ008785
	for <selinux@tycho.nsa.gov>; Fri, 29 Aug 2008 03:45:40 GMT
Received: by rv-out-0708.google.com with SMTP id f25so715264rvb.54
        for <selinux@tycho.nsa.gov>; Thu, 28 Aug 2008 20:45:39 -0700 (PDT)
Message-ID: <f00ed96d0808282045v633a018fsf06aa8a70b55474e@mail.gmail.com>
Date: Thu, 28 Aug 2008 23:45:39 -0400
From: Hong <kindloaf@gmail.com>
To: "Dominick Grift" <domg472@gmail.com>
Subject: Re: About Domain Transition
Cc: "SELinux Mailing List" <selinux@tycho.nsa.gov>
In-Reply-To: <1219957912.11166.14.camel@sulphur.notebook.internal>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_11133_1259000.1219981539127"
References: <f00ed96d0808281333i6fb890a9j85949806cbbf2179@mail.gmail.com>
	 <1219957912.11166.14.camel@sulphur.notebook.internal>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_11133_1259000.1219981539127
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks Dominick, your comments are very helpful.

I have another question.  Suppose there is a rule:
type_transition  domain1_type  app_exec_t: process domain2_type;

but domain1_type only has execute_no_trans over over app_exec_t:
allow domain1_type app_exec_t: file execute_no_trans;

Then what'll happen when a process within domain1_type executes a program
with type app_exec_t?  Will it stay in domain1_type or the access is denied?


Hong





On Thu, Aug 28, 2008 at 5:11 PM, Dominick Grift <domg472@gmail.com> wrote:

> On Thu, 2008-08-28 at 16:33 -0400, Hong wrote:
>
> > Is there any documentation I can refer to so I can see how the access
> > decision is made? Or where in the kernel source code above logic is
> > implement?
> >
> > Thanks!
> >
>
> Hello and welcome, There is a separate mailing list for (ref)policy.
> You can subscribe here: http://oss.tresys.com/mailman/listinfo/refpolicy
>
> You can browse policy source code here:
> http://oss.tresys.com/projects/refpolicy/browser/trunk
>
> I Think your explanation looks good.
>
> 1. cannot execute (access is denied by default)
>
> 2. can execute but not transition to new domain (run executable file in
> the caller domain) for example: if domain_type_6_t tries to execute
> application_executable_files_type_1_t then run that process in the
> domain_type_6_t domain
>
> 3. can execute and and transition to a predefined domain ( for example:
> if domain_type_1_t tries to executes
> application_executable_files_type_1_t then transition to domain_type_2_t
>
> You can easily test these with policy like can_exec() and
> domain_auto_trans()
>
> Another good resource for knowledge is the #selinux and #fedora-selinux
> irc channel on irc.freenode.org.
>
>
>
> if domain_type_3_t tries to execute
> application_executable_files_type_1_t then transition to domain_type_3_t
>
> --
> Dominick Grift <domg472@gmail.com>
>

------=_Part_11133_1259000.1219981539127
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Thanks Dominick, your comments are very helpful.<br><br>I have another question.&nbsp; Suppose there is a rule:<br>type_transition&nbsp; domain1_type&nbsp; app_exec_t: process domain2_type;<br><br>but domain1_type only has execute_no_trans over over app_exec_t:<br>
allow domain1_type app_exec_t: file execute_no_trans;<br><br>Then what&#39;ll happen when a process within domain1_type executes a program with type app_exec_t?&nbsp; Will it stay in domain1_type or the access is denied?<br><br>
<br>Hong<br><br><font color="#888888"><br><br><br></font><br><div class="gmail_quote">On Thu, Aug 28, 2008 at 5:11 PM, Dominick Grift <span dir="ltr">&lt;<a href="mailto:domg472@gmail.com">domg472@gmail.com</a>&gt;</span> wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class="Ih2E3d">On Thu, 2008-08-28 at 16:33 -0400, Hong wrote:<br>
<br>
&gt; Is there any documentation I can refer to so I can see how the access<br>
&gt; decision is made? Or where in the kernel source code above logic is<br>
&gt; implement?<br>
&gt;<br>
&gt; Thanks!<br>
&gt;<br>
<br>
</div>Hello and welcome, There is a separate mailing list for (ref)policy.<br>
You can subscribe here: <a href="http://oss.tresys.com/mailman/listinfo/refpolicy" target="_blank">http://oss.tresys.com/mailman/listinfo/refpolicy</a><br>
<br>
You can browse policy source code here:<br>
<a href="http://oss.tresys.com/projects/refpolicy/browser/trunk" target="_blank">http://oss.tresys.com/projects/refpolicy/browser/trunk</a><br>
<br>
I Think your explanation looks good.<br>
<br>
1. cannot execute (access is denied by default)<br>
<br>
2. can execute but not transition to new domain (run executable file in<br>
the caller domain) for example: if domain_type_6_t tries to execute<br>
application_executable_files_type_1_t then run that process in the<br>
domain_type_6_t domain<br>
<br>
3. can execute and and transition to a predefined domain ( for example:<br>
if domain_type_1_t tries to executes<br>
application_executable_files_type_1_t then transition to domain_type_2_t<br>
<br>
You can easily test these with policy like can_exec() and<br>
domain_auto_trans()<br>
<br>
Another good resource for knowledge is the #selinux and #fedora-selinux<br>
irc channel on <a href="http://irc.freenode.org" target="_blank">irc.freenode.org</a>.<br>
<br>
<br>
<br>
if domain_type_3_t tries to execute<br>
application_executable_files_type_1_t then transition to domain_type_3_t<br>
<font color="#888888"><br>
--<br>
Dominick Grift &lt;<a href="mailto:domg472@gmail.com">domg472@gmail.com</a>&gt;<br>
</font></blockquote></div><br></div>

------=_Part_11133_1259000.1219981539127--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
