Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n876rUnt023206
	for <selinux@tycho.nsa.gov>; Mon, 7 Sep 2009 02:53:30 -0400
Received: from mail-px0-f193.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n876snuA009963
	for <selinux@tycho.nsa.gov>; Mon, 7 Sep 2009 06:54:49 GMT
Received: by pxi31 with SMTP id 31so2351606pxi.3
        for <selinux@tycho.nsa.gov>; Sun, 06 Sep 2009 23:53:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4AA48895.8030400@gmail.com>
References: <200909071010066097796@gmail.com> <4AA48895.8030400@gmail.com>
From: waqar afridi <afridi.waqar@gmail.com>
Date: Mon, 7 Sep 2009 12:53:08 +0600
Message-ID: <78aaeffc0909062353p428dac47q614eb6b71a2f8ed7@mail.gmail.com>
Subject: Re: Problem install Reference Policy
To: zheyeung@gmail.com, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=000e0cd2960c9b92090472f74ee9
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--000e0cd2960c9b92090472f74ee9
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: quoted-printable

*Thanx zheyeung*, But If I do leave the original *Build.conf* I get the
following error

/usr/bin/checkpolicy policy.conf -o /etc/selinux/refpolicy/policy/policy.23
/usr/bin/checkpolicy:  loading policy configuration from policy.conf
make: *** [/etc/selinux/refpolicy/policy/policy.23] Killed

 Is it due to less memory or some thing else, I also turned off some
unwanted modules from *modules.conf*, but didnt help, What should I do?

On Mon, Sep 7, 2009 at 10:14 AM, Justin P. Mattock
<justinmattock@gmail.com>wrote:

> zheyeung wrote:
>
>> hello waqar, I used to get this problem.after then, i edit file build.co=
nf
>> in some way  ,then make . make successfully!
>> but I've got another problem . after i install the policy (by editting
>> /etc/ selinux/config ,reboot)  ,my graphic user interface failed to star=
t
>> up.and i don't kown why.
>> I run "semanage login -l" ,found "login" of root is root: sysadm_r.but
>> default targeted in Fedora-11. root 's "login" is "unconfined_u:
>> unconfined_r".
>>
>
> you might try  make clean, make enableaudit, make policy
> this will generate some more avc's that you might need
> to allow to startx.
>
>  2009-09-07
>> ------------------------------------------------------------------------
>> zheyeung
>> ------------------------------------------------------------------------
>> *=B7=A2=BC=FE=C8=CB=A3=BA* waqar afridi
>> *=B7=A2=CB=CD=CA=B1=BC=E4=A3=BA* 2009-09-05  15:44:44
>> *=CA=D5=BC=FE=C8=CB=A3=BA* selinux
>> *=B3=AD=CB=CD=A3=BA*
>> *=D6=F7=CC=E2=A3=BA* Problem install Reference Policy
>> Hello Every One,
>>
>> I am new to selinux, I am using Ubuntu and i am trying to install
>> reference Policy on it, after running command make load, I get this erro=
r,
>> I dont know whats wrong
>>
>> /usr/bin/checkpolicy policy.conf -o
>> /etc/selinux/refpolicy/policy/policy.23
>> /usr/bin/checkpolicy:  loading policy configuration from policy.conf
>> policy/modules/services/ifplugd.te":67:ERROR 'type netutils_exec_t is no=
t
>> within scope' at token ';' on line 362418:
>>    allow ifplugd_t netutils_exec_t:file { getattr open read execute };
>> #line 67
>> checkpolicy:  error(s) encountered while parsing configuration
>> make: *** [/etc/selinux/refpolicy/policy/policy.23] Error 1
>>
>>
>> --
>> Waqar Afridi
>>
>
> Justin P. Mattock
>



--=20
Waqar Afridi

--000e0cd2960c9b92090472f74ee9
Content-Type: text/html; charset=GB2312
Content-Transfer-Encoding: quoted-printable

<b>Thanx zheyeung</b>, But If I do leave the original <b>Build.conf</b> I g=
et the following error<br><br>/usr/bin/checkpolicy policy.conf -o /etc/seli=
nux/refpolicy/policy/policy.23<br>/usr/bin/checkpolicy:&nbsp; loading polic=
y configuration from policy.conf<br>

make: *** [/etc/selinux/refpolicy/policy/policy.23] Killed<br><br>&nbsp;Is =
it due to less memory or some thing else, I also turned off some unwanted m=
odules from <b>modules.conf</b>, but didnt help, What should I do?<br><br><=
div class=3D"gmail_quote">

On Mon, Sep 7, 2009 at 10:14 AM, Justin P. Mattock <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:justinmattock@gmail.com">justinmattock@gmail.com</a>&gt;</s=
pan> wrote:<br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px =
solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

<div class=3D"im">zheyeung wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
hello waqar, I used to get this problem.after then, i edit file build.conf =
in some way &nbsp;,then make . make successfully!<br>
but I&#39;ve got another problem . after i install the policy (by editting =
/etc/ selinux/config ,reboot) &nbsp;,my graphic user interface failed to st=
art up.and i don&#39;t kown why.<br>
I run &quot;semanage login -l&quot; ,found &quot;login&quot; of root is roo=
t: sysadm_r.but default targeted in Fedora-11. root &#39;s &quot;login&quot=
; is &quot;unconfined_u: unconfined_r&quot;.<br>
</blockquote>
<br></div>
you might try &nbsp;make clean, make enableaudit, make policy<br>
this will generate some more avc&#39;s that you might need<br>
to allow to startx.<div><div></div><div class=3D"h5"><br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
2009-09-07<br>
------------------------------------------------------------------------<br=
>
zheyeung<br>
------------------------------------------------------------------------<br=
>
*=B7=A2=BC=FE=C8=CB=A3=BA* waqar afridi<br>
*=B7=A2=CB=CD=CA=B1=BC=E4=A3=BA* 2009-09-05 &nbsp;15:44:44<br>
*=CA=D5=BC=FE=C8=CB=A3=BA* selinux<br>
*=B3=AD=CB=CD=A3=BA*<br>
*=D6=F7=CC=E2=A3=BA* Problem install Reference Policy<br>
Hello Every One,<br>
<br>
I am new to selinux, I am using Ubuntu and i am trying to install reference=
 Policy on it, after running command make load, I get this error,<br>
I dont know whats wrong<br>
<br>
/usr/bin/checkpolicy policy.conf -o /etc/selinux/refpolicy/policy/policy.23=
<br>
/usr/bin/checkpolicy: &nbsp;loading policy configuration from policy.conf<b=
r>
policy/modules/services/ifplugd.te&quot;:67:ERROR &#39;type netutils_exec_t=
 is not within scope&#39; at token &#39;;&#39; on line 362418:<br>
 &nbsp; &nbsp;allow ifplugd_t netutils_exec_t:file { getattr open read exec=
ute };<br>
#line 67<br>
checkpolicy: &nbsp;error(s) encountered while parsing configuration<br>
make: *** [/etc/selinux/refpolicy/policy/policy.23] Error 1<br>
<br>
<br>
-- <br>
Waqar Afridi<br>
</blockquote>
<br></div></div><font color=3D"#888888">
Justin P. Mattock<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>Waqar Afridi<br>

--000e0cd2960c9b92090472f74ee9--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
