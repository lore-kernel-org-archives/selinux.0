MIME-Version: 1.0
In-Reply-To: <1268315218.16780.10.camel@moss-pluto.epoch.ncsc.mil>
References: <20100311081913.GC24034@myhost.felk.cvut.cz> <1268315218.16780.10.camel@moss-pluto.epoch.ncsc.mil>
From: Richard Bullington-McGuire <richard.bullington-mcguire@threepillarglobal.com>
Date: Thu, 11 Mar 2010 09:45:17 -0500
Message-ID: <34e141281003110645p4c7922e3i86716092735e6fef@mail.gmail.com>
Subject: Re: how to cope with file renames?
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=0016e6d77e3ed4ab5704818777e6
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0016e6d77e3ed4ab5704818777e6
Content-Type: text/plain; charset=UTF-8

On Thu, Mar 11, 2010 at 8:46 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

>
> http://pecl.php.net/package/selinux
>
>
It's funny that you mention pecl in this context, since pecl itself has the
same behavior that the original poster mentioned with regard to  SELinux, at
least on RHEL 5. When you install a module using pecl, it compiles it in a
temporary directory and them moves it into place in the PHP library
directory. The resulting module has the SELinux label from the temporary
directory, user_u:object_r:tmp_t, not the system_u:object_r:textrel_shlib_t
label that the other PHP modules in the /usr/lib64/php/modules directory
have. Issuing a quick 'restorecon' command versus the resulting php module
file adjusted its context so that httpd could read it.

-- 
Richard Bullington-McGuire | Director of Technology | Three Pillar Global
mobile: 571.236.0938 | fax: 703-564-5595 | PGP key ID:  0xDAC3028E
richard.bullington-mcguire@threepillarglobal.com | www.threepillarglobal.com

--0016e6d77e3ed4ab5704818777e6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><div class=3D"gmail_quote">On Thu, Mar 11, 2010 at 8:46 AM, Stephen Sma=
lley <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov">sds@tycho.n=
sa.gov</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"=
border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; paddi=
ng-left: 1ex;">

<div class=3D"im"><br>
</div><a href=3D"http://pecl.php.net/package/selinux" target=3D"_blank">htt=
p://pecl.php.net/package/selinux</a><br><br></blockquote><div>=C2=A0</div><=
/div>It&#39;s funny that you mention pecl in this context, since pecl itsel=
f has the same behavior that the original poster mentioned with regard to=
=C2=A0 SELinux, at least on RHEL 5. When you install a module using pecl, i=
t compiles it in a temporary directory and them moves it into place in the =
PHP library directory. The resulting module has the SELinux label from the =
temporary directory, user_u:object_r:tmp_t, not the system_u:object_r:textr=
el_shlib_t label that the other PHP modules in the /usr/lib64/php/modules d=
irectory have. Issuing a quick &#39;restorecon&#39; command versus the resu=
lting php module file adjusted its context so that httpd could read it.<br =
clear=3D"all">

<br>-- <br>Richard Bullington-McGuire | Director of Technology | Three Pill=
ar Global<br>mobile: 571.236.0938 | fax: 703-564-5595 | PGP key ID: =C2=A00=
xDAC3028E<br><a href=3D"mailto:richard.bullington-mcguire@threepillarglobal=
.com">richard.bullington-mcguire@threepillarglobal.com</a> | <a href=3D"htt=
p://www.threepillarglobal.com">www.threepillarglobal.com</a><br>

<br>

--0016e6d77e3ed4ab5704818777e6--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
