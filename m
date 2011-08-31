Message-ID: <4E5E7757.5030007@roboreus.com>
Date: Wed, 31 Aug 2011 19:03:03 +0100
From: Roy Badami <roy.badami@roboreus.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: CentOS 5 RBAC
References: <4E5E68DB.1030101@roboreus.com> <1314810951.6850.26.camel@moss-pluto>
In-Reply-To: <1314810951.6850.26.camel@moss-pluto>
Content-Type: multipart/alternative;
 boundary="------------030706040408020905040600"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030706040408020905040600
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[Resending after accidentally dropping cc to the list]

On 31/08/2011 18:15, Stephen Smalley wrote:
> The logic in selinux_set_enforce_mode() in
> policy/modules/kernel/selinux.if is:
> ...
>        if(!secure_mode_policyload) {
>                  allow $1 security_t:security setenforce;
> ...
> }
>
> Notice the logical negation (!) in the above if statement.
>

Ah, thank you!  I had looked at those lines ealier, without fully 
understanding how the policy fitted together.  Indeed, I set  
secure_mode_policyload to 'on' based on that code to fix the fact that 
root could still run setenforce, even without changing role to 
secadm_r.  But unfortuantely, I see now, the reason root could run 
setenforce without changing to secadm_r is that root gets sysadm_r by 
default - and changing secure_mode_loadpolicy prevents *both* sysadm_r 
*and* secadm_r from administering policy - which wasn't what I was 
trying to achieve.

                 ifdef(`enable_mls',`
                         
userdom_security_administrator(secadm_t,secadm_r,{ secadm_tty_device_t 
sysadm_devpts_t })
#                       tunable_policy(`allow_sysadm_manage_security',`
                                 
userdom_security_administrator(sysadm_t,sysadm_r,admin_terminal)
#                       ')

If the allow_sysadm_manage_security boolean was implemented in this 
policy then I could simply set that to 'off'.   Given it's not - what's 
the best way to grant this permission to secadm_r only?  Presumably I 
want to set secure_mode_loadpolicy to 'on' as now so that the shipped 
policy doesn't give permissions, and then load some custom TE rules to 
add the necessary permissions for secadm_r to administer security policy?

Regards

roy




-- 
Roy Badami
Roboreus Ltd
1 New Oxford Street
London WC1A 1NU


--------------030706040408020905040600
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content=3D"text/html; charset=3DUTF-8" http-equiv=3D"Content-Ty=
pe">
    <title></title>
  </head>
  <body bgcolor=3D"#ffffff" text=3D"#000000">
    <div class=3D"moz-text-flowed" style=3D"font-family: -moz-fixed;
      font-size: 14px;" lang=3D"x-unicode">[Resending after accidentally
      dropping cc to the list]<br>
      <br>
      On 31/08/2011 18:15, Stephen Smalley wrote:
      <br>
      <blockquote type=3D"cite" style=3D"color: rgb(0, 0, 0);">The logic =
in
        selinux_set_enforce_mode() in
        <br>
        policy/modules/kernel/selinux.if is:
        <br>
        ...
        <br>
        =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if(!secure_mode_policyload) =
{
        <br>
        =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 allow $1 security_t:security setenforce;
        <br>
        ...
        <br>
        }
        <br>
        <br>
        Notice the logical negation (!) in the above if statement.
        <br>
        <br>
      </blockquote>
      <br>
      Ah, thank you!=C2=A0 I had looked at those lines ealier, without fu=
lly
      understanding how the policy fitted together.=C2=A0 Indeed, I set=C2=
=A0
      secure_mode_policyload to 'on' based on that code to fix the fact
      that root could still run setenforce, even without changing role
      to secadm_r.=C2=A0 But unfortuantely, I see now, the reason root co=
uld
      run setenforce without changing to secadm_r is that root gets
      sysadm_r by default - and changing secure_mode_loadpolicy prevents
      <b class=3D"moz-txt-star"><span class=3D"moz-txt-tag">*</span>both<=
span
          class=3D"moz-txt-tag">*</span></b> sysadm_r <b
        class=3D"moz-txt-star"><span class=3D"moz-txt-tag">*</span>and<sp=
an
          class=3D"moz-txt-tag">*</span></b> secadm_r from administering
      policy - which wasn't what I was trying to achieve.
      <br>
      <br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ifdef(`enable_mls',`
      <br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
      userdom_security_administrator(secadm_t,secadm_r,{
      secadm_tty_device_t sysadm_devpts_t })
      <br>
      #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
      tunable_policy(`allow_sysadm_manage_security',`
      <br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
      userdom_security_administrator(sysadm_t,sysadm_r,admin_terminal)
      <br>
      #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ')
      <br>
      <br>
      If the allow_sysadm_manage_security boolean was implemented in
      this policy then I could simply set that to 'off'.=C2=A0=C2=A0 Give=
n it's
      not - what's the best way to grant this permission to secadm_r
      only?=C2=A0 Presumably I want to set secure_mode_loadpolicy to 'on'=
 as
      now so that the shipped policy doesn't give permissions, and then
      load some custom TE rules to add the necessary permissions for
      secadm_r to administer security policy?
      <br>
      <br>
      Regards
      <br>
      <br>
      roy
      <br>
      <br>
      <br>
      <br>
      <br>
      <div class=3D"moz-txt-sig"><span class=3D"moz-txt-tag">--=C2=A0<br>
        </span>Roy Badami
        <br>
        Roboreus Ltd
        <br>
        1 New Oxford Street
        <br>
        London WC1A 1NU
        <br>
        <br>
      </div>
    </div>
  </body>
</html>

--------------030706040408020905040600--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
