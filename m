Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s09Hr2hb007704
 for <selinux@tycho.nsa.gov>; Thu, 9 Jan 2014 12:53:02 -0500
Received: by mail-ve0-f178.google.com with SMTP id c14so2696074vea.9
 for <selinux@tycho.nsa.gov>; Thu, 09 Jan 2014 09:53:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <201401022053.56630.russell@coker.com.au>
References: <2a7b84d3.10951.143524a4a81.Coremail.bigclouds@163.com>
 <201401022053.56630.russell@coker.com.au>
Date: Thu, 9 Jan 2014 11:52:51 -0600
Message-ID: <CAP_GsaT1K32RbaqiqtK8z+P4LciQJDN7nRCVcd-7jF9xCbaPTA@mail.gmail.com>
Subject: Re: question about basic selinux concept
From: Tawfiq Shah <tawfiqshah@gmail.com>
To: russell@coker.com.au
Content-Type: multipart/alternative; boundary=089e0115e78847394004ef8d4784
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--089e0115e78847394004ef8d4784
Content-Type: text/plain; charset=ISO-8859-1

Hi all,
Is there any documentation on which LSM hook function is responsible for
sending the request to the security server and the function responsible for
relaying the decision of the security server to the LSM enforcement hooks?

Thank you


On Thu, Jan 2, 2014 at 3:53 AM, Russell Coker <russell@coker.com.au> wrote:

> On Thu, 2 Jan 2014, bigclouds <bigclouds@163.com> wrote:
> > there are not many document  about internal of selinux on the internet.
> > could you answer my  questions, thanks
> > # ps -eZ | grep qemu-kvm
> > system_u:system_r:svirt_t:s0:c87,c520 27950 ? 00:00:17 qemu-kvm
> >
> > 1.there, svirt_t is a domain or a type? how to create a new type , just a
> > sample is ok
>
> In the way that SE Linux works internally there isn't a difference.  With
> the
> way the policy is written the attribute "domain" is applied to any type
> that
> can be used for labelling a process.
>
> #
> # init_t is the domain of the init process.
> #
> type init_t, initrc_transition_domain;
> type init_exec_t;
> domain_type(init_t)
> domain_entry_file(init_t, init_exec_t)
> kernel_domtrans_to(init_t, init_exec_t)
> role system_r types init_t;
>
> Above is a snippet from init.te.  It creates the "type" (where the word
> applies to a policy language keyword) init_t and then uses the interface
> "domain_type" to give it the attribute "domain".
>
> > 2.how to know   how much authority  , on how many files,dirs,sockets....
> > the process of qemu-kvm  has? is there a command to show that?
>
> The commands "apol" and "sesearch" allow you to discover that.
>
> > 3. s0, if it can be s1,s2....(images have the same s*), if i do so , any
> > other requirement? if  type is targeted, if targeted has only one level,
> > s0?   in targeted case, s1,s2...is not valid?
>
> s1 only exists if you use the MLS (Multi Level Security) policy, which you
> almost certainly aren't using (it's an advanced feature and not enabled by
> default in any distribution you are likely to use).
>
> That level field in the label is also used by MCS (Multi Category Security)
> which allows values such as "s0:c0" and "s0:c0,c3".  Feel free to
> experiment
> with that, you can use the command "runcon" to launch a process with a
> different level and see what access it is permitted to have to files of
> different level.
>
> > 4.what does s(sensitive) and c(class) mean?
>
> For MCS it's only s0 so it means nothing for you.  MLS is more complex,
> master
> MCS first.
>
> > 5. there are two class, c520,c87.   what is the upper limit of class
> > amount.
>
> The categories (not classes) are numbered from c0 to c1023, there are 1024
> of
> them but this is a policy compilation choice, you could rebuild the policy
> and
> use more or less.  In MCS to read a file a process needs to have every
> category that the file has (or it needs to be in a domain that can override
> the MCS controls).
>
> --
> My Main Blog         http://etbe.coker.com.au/
> My Documents Blog    http://doc.coker.com.au/
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>

--089e0115e78847394004ef8d4784
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<div>Is there any documentation on which LSM hook f=
unction is responsible for sending the request to the security server and t=
he function responsible for relaying the decision of the security server to=
 the LSM enforcement hooks?</div>
<div><br></div><div>Thank you =A0=A0</div></div><div class=3D"gmail_extra">=
<br><br><div class=3D"gmail_quote">On Thu, Jan 2, 2014 at 3:53 AM, Russell =
Coker <span dir=3D"ltr">&lt;<a href=3D"mailto:russell@coker.com.au" target=
=3D"_blank">russell@coker.com.au</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">On Thu, 2 Jan 2014, bigclouds &lt;<a href=3D=
"mailto:bigclouds@163.com">bigclouds@163.com</a>&gt; wrote:<br>
&gt; there are not many document =A0about internal of selinux on the intern=
et.<br>
&gt; could you answer my =A0questions, thanks<br>
&gt; # ps -eZ | grep qemu-kvm<br>
&gt; system_u:system_r:svirt_t:s0:c87,c520 27950 ? 00:00:17 qemu-kvm<br>
&gt;<br>
&gt; 1.there, svirt_t is a domain or a type? how to create a new type , jus=
t a<br>
&gt; sample is ok<br>
<br>
In the way that SE Linux works internally there isn&#39;t a difference. =A0=
With the<br>
way the policy is written the attribute &quot;domain&quot; is applied to an=
y type that<br>
can be used for labelling a process.<br>
<br>
#<br>
# init_t is the domain of the init process.<br>
#<br>
type init_t, initrc_transition_domain;<br>
type init_exec_t;<br>
domain_type(init_t)<br>
domain_entry_file(init_t, init_exec_t)<br>
kernel_domtrans_to(init_t, init_exec_t)<br>
role system_r types init_t;<br>
<br>
Above is a snippet from init.te. =A0It creates the &quot;type&quot; (where =
the word<br>
applies to a policy language keyword) init_t and then uses the interface<br=
>
&quot;domain_type&quot; to give it the attribute &quot;domain&quot;.<br>
<br>
&gt; 2.how to know =A0 how much authority =A0, on how many files,dirs,socke=
ts....<br>
&gt; the process of qemu-kvm =A0has? is there a command to show that?<br>
<br>
The commands &quot;apol&quot; and &quot;sesearch&quot; allow you to discove=
r that.<br>
<br>
&gt; 3. s0, if it can be s1,s2....(images have the same s*), if i do so , a=
ny<br>
&gt; other requirement? if =A0type is targeted, if targeted has only one le=
vel,<br>
&gt; s0? =A0 in targeted case, s1,s2...is not valid?<br>
<br>
s1 only exists if you use the MLS (Multi Level Security) policy, which you<=
br>
almost certainly aren&#39;t using (it&#39;s an advanced feature and not ena=
bled by<br>
default in any distribution you are likely to use).<br>
<br>
That level field in the label is also used by MCS (Multi Category Security)=
<br>
which allows values such as &quot;s0:c0&quot; and &quot;s0:c0,c3&quot;. =A0=
Feel free to experiment<br>
with that, you can use the command &quot;runcon&quot; to launch a process w=
ith a<br>
different level and see what access it is permitted to have to files of<br>
different level.<br>
<br>
&gt; 4.what does s(sensitive) and c(class) mean?<br>
<br>
For MCS it&#39;s only s0 so it means nothing for you. =A0MLS is more comple=
x, master<br>
MCS first.<br>
<br>
&gt; 5. there are two class, c520,c87. =A0 what is the upper limit of class=
<br>
&gt; amount.<br>
<br>
The categories (not classes) are numbered from c0 to c1023, there are 1024 =
of<br>
them but this is a policy compilation choice, you could rebuild the policy =
and<br>
use more or less. =A0In MCS to read a file a process needs to have every<br=
>
category that the file has (or it needs to be in a domain that can override=
<br>
the MCS controls).<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
My Main Blog =A0 =A0 =A0 =A0 <a href=3D"http://etbe.coker.com.au/" target=
=3D"_blank">http://etbe.coker.com.au/</a><br>
My Documents Blog =A0 =A0<a href=3D"http://doc.coker.com.au/" target=3D"_bl=
ank">http://doc.coker.com.au/</a><br>
_______________________________________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>
</font></span></blockquote></div><br></div>

--089e0115e78847394004ef8d4784--
