Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t2GChYd6010871
 for <selinux@tycho.nsa.gov>; Mon, 16 Mar 2015 08:43:35 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
 (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t2GChUX4026692
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <selinux@tycho.nsa.gov>; Mon, 16 Mar 2015 08:43:30 -0400
Received: from dhcp-2-191.brq.redhat.com (dhcp-2-145.brq.redhat.com
 [10.34.2.145])
 by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 t2GChT2F027940
 for <selinux@tycho.nsa.gov>; Mon, 16 Mar 2015 08:43:30 -0400
Message-ID: <5506CFF0.1040003@redhat.com>
Date: Mon, 16 Mar 2015 13:43:28 +0100
From: Miroslav Grepl <mgrepl@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="=_Boundary-2884-1426509815-0001-2"
To: selinux@tycho.nsa.gov
Subject: Re: selinux category relabel (puppet)
References: <2409d98630af4bc39108524e04557017@VNUCITEX02.ICFI.icfconsulting.com>
 <55032105.1030903@tycho.nsa.gov>
 <103dc46dd5b34fa5a752edce40d20e01@VNUCITEX02.ICFI.icfconsulting.com>
 <550326BD.10207@tycho.nsa.gov>
 <6d80ec39a885492792f446972fb5facc@VNUCITEX02.ICFI.icfconsulting.com>
 <20150313213137.GE9437@linksys-wireless-usb.network2>
In-Reply-To: <20150313213137.GE9437@linksys-wireless-usb.network2>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_Boundary-2884-1426509815-0001-2
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 03/13/2015 10:31 PM, Dominick Grift wrote:
> On Fri, Mar 13, 2015 at 09:17:36PM +0000, Higgs, Stephen wrote:
>>>>>> Hello all,
>>>>>>
>>>>>>
>>>>>>
>>>>>> If there is a more appropriate forum for this question please let me know:
>>>>>>
>>>>>>
>>>>>>
>>>>>> I have a system that uses confined users by default and some files
>>>>>> are managed by a puppet server.  When I run (via run_init) the
>>>>>> puppet startup script, I get the following avc log:
>>>>>>
>>>>>>
>>>>>>
>>>>>> avc: denied { relabelto } for pid=30707 comm="puppet" name="crl.pem"
>>>>>> dev=dm-1 ino=527257 scontext=system_u:system_r:puppet_t:s0
>>>>>> tcontext=system_u:object_r:puppet_var_lib_t:s0:c0.c1023 tclass=file
>>>>>>
>>>>>> I added "typeattribute puppet_t can_change_object_identity" and
>>>>>> appropriate "allow" statements to the puppet_t type after reading
>>>>>> the constraints in the targeted policy. However, it was the category
>>>>>> "s0:c0.c1023" that was also preventing puppet from relabeling the
>>>>>> crl.pem file.
>>>>>>
>>>>>> I was able to fix this by manually relabeling the file to "s0"
>>>>>> instead of "s0:c0.c1023". My question is, how *should* I handle this
>>>>>> so puppet can handle the relabel of the category?
>>>>> It requires an appropriate attribute for the mcs or mls constraint
>>>>> that is blocking access.  Which attribute depends on your policy; MCS
>>>>> in particular has changed a lot over time in Fedora and RHEL.  What distro &
>>> version?
>>>> I'm using CentOS / RedHat 6.6, targeted reference policy 24.
>>> Hmmm...looking at selinux-policy-3.7.19-260.el6.src.rpm,
>>> serefpolicy-3.719/policy/mcs has this:
>>>
>>> # New filesystem object labels must be dominated by the relabeling subject #
>>> clearance, also the objects are single-level.
>>> mlsconstrain file { create relabelto }
>>>          (( h1 dom h2 ) and ( l2 eq h2 ));
>>>
>>> So no attributes are exempted from that constraint; your only option is to run
>>> puppet ranged (i.e. as system_u:system_r:puppet_t:s0-s0:c0.c1023)
>>> so that its high level dominates any potential file level.
Yes, there is no attribute on RHEL6.
>>>
>>> You should be able to do that with a range_transition rule, e.g.
>>> range_transition initrc_t puppet_exec_t:process s0 - s0:c0.c0123; (assuming
>>> that the puppet entrypoint is labeled with puppet_exec_t).
>> Thanks Stephen, this makes sense to me, but I can't get that statement to compile in my policy module:
>>
>>     Compiling targeted puppet module
>>     /usr/bin/checkmodule:  loading policy configuration from tmp/puppet.tmp
>>     puppet.te":14:ERROR 'unknown level s0-s0 used in range_transition definition' at token ';' on line 1041:
>>     range_transition initrc_t puppet_exec_t:process s0-s0:c0.c1023;
>>     #init_ranged_daemon_domain(puppet_t,puppet_exec_t,s0-s0:c0.c1023);
>>     /usr/bin/checkmodule:  error(s) encountered while parsing configuration
>>     make: *** [tmp/puppet.mod] Error 1
>>
>> I did try checkmodule as well, and I tried using the init_ranged_daemon_domain macro.  Here is the policy module that I am trying to compile:
>>
>>     module puppet 1.2;
>>     require {
>>             type puppet_t;
>>             type puppet_exec_t;
>>             type initrc_t;
>>             attribute can_change_object_identity;
>>             class process { transition };
>>     }
>>     typeattribute puppet_t can_change_object_identity;
>>     #init_ranged_daemon_domain(puppet_t,puppet_exec_t,s0-s0:c0.c1023);
>>     range_transition initrc_t puppet_exec_t:process s0-s0:c0.c1023;
> Not sure but try spaces here (s0 - s0): range_transition initrc_t puppet_exec_t:process s0 - s0:c0.c1023;
>
>> I feel like I'm close, but perhaps I'm missing how to import  the level definitions?
Try this one

policy_module(mypol,1.0)

require{
  type puppet_t;
  type puppet_exec_t;
}

ifdef(`enable_mcs',`
     init_ranged_daemon_domain(puppet_t, puppet_exec_t, s0 - s0:c0.c1023)
')

>>
>>
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.


--=_Boundary-2884-1426509815-0001-2
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
X-Mime-Autoconverted: from 8bit to quoted-printable by mime827

<html>
  <head>
    <meta content=3D"text/html; charset=3Dwindows-1252"
      http-equiv=3D"Content-Type">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <div class=3D"moz-cite-prefix">On 03/13/2015 10:31 PM, Dominick Grif=
t
      wrote:<br>
    </div>
    <blockquote
      cite=3D"mid:20150313213137.GE9437@linksys-wireless-usb.network2"
      type=3D"cite">
      <pre wrap=3D"">On Fri, Mar 13, 2015 at 09:17:36PM +0000, Higgs, St=
ephen wrote:
</pre>
      <blockquote type=3D"cite">
        <blockquote type=3D"cite">
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <pre wrap=3D"">Hello all,



If there is a more appropriate forum for this question please let me kno=
w:



I have a system that uses confined users by default and some files
are managed by a puppet server.  When I run (via run_init) the
puppet startup script, I get the following avc log:



avc: denied { relabelto } for pid=3D30707 comm=3D"puppet" name=3D"crl.pe=
m"
dev=3Ddm-1 ino=3D527257 scontext=3Dsystem_u:system_r:puppet_t:s0
tcontext=3Dsystem_u:object_r:puppet_var_lib_t:s0:c0.c1023 tclass=3Dfile

I added "typeattribute puppet_t can_change_object_identity" and
appropriate "allow" statements to the puppet_t type after reading
the constraints in the targeted policy. However, it was the category
"s0:c0.c1023" that was also preventing puppet from relabeling the
crl.pem file.

I was able to fix this by manually relabeling the file to "s0"
instead of "s0:c0.c1023". My question is, how *should* I handle this
so puppet can handle the relabel of the category?
</pre>
              </blockquote>
              <pre wrap=3D"">
It requires an appropriate attribute for the mcs or mls constraint
that is blocking access.  Which attribute depends on your policy; MCS
in particular has changed a lot over time in Fedora and RHEL.  What dist=
ro &amp;
</pre>
            </blockquote>
          </blockquote>
          <pre wrap=3D"">version?
</pre>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <pre wrap=3D"">
</pre>
            </blockquote>
            <pre wrap=3D"">
I'm using CentOS / RedHat 6.6, targeted reference policy 24.
</pre>
          </blockquote>
          <pre wrap=3D"">
Hmmm...looking at selinux-policy-3.7.19-260.el6.src.rpm,
serefpolicy-3.719/policy/mcs has this:

# New filesystem object labels must be dominated by the relabeling subje=
ct #
clearance, also the objects are single-level.
mlsconstrain file { create relabelto }
        (( h1 dom h2 ) and ( l2 eq h2 ));

So no attributes are exempted from that constraint; your only option is =
to run
puppet ranged (i.e. as system_u:system_r:puppet_t:s0-s0:c0.c1023)
so that its high level dominates any potential file level.</pre>
        </blockquote>
      </blockquote>
    </blockquote>
    Yes, there is no attribute on RHEL6. <br>
    <blockquote
      cite=3D"mid:20150313213137.GE9437@linksys-wireless-usb.network2"
      type=3D"cite">
      <blockquote type=3D"cite">
        <blockquote type=3D"cite">
          <pre wrap=3D"">

You should be able to do that with a range_transition rule, e.g.
range_transition initrc_t puppet_exec_t:process s0 - s0:c0.c0123; (assum=
ing
that the puppet entrypoint is labeled with puppet_exec_t).
</pre>
        </blockquote>
        <pre wrap=3D"">
Thanks Stephen, this makes sense to me, but I can't get that statement t=
o compile in my policy module:

   Compiling targeted puppet module
   /usr/bin/checkmodule:  loading policy configuration from tmp/puppet.t=
mp
   puppet.te":14:ERROR 'unknown level s0-s0 used in range_transition def=
inition' at token ';' on line 1041:
   range_transition initrc_t puppet_exec_t:process s0-s0:c0.c1023;
   #init_ranged_daemon_domain(puppet_t,puppet_exec_t,s0-s0:c0.c1023);
   /usr/bin/checkmodule:  error(s) encountered while parsing configurati=
on
   make: *** [tmp/puppet.mod] Error 1

I did try checkmodule as well, and I tried using the init_ranged_daemon_=
domain macro.  Here is the policy module that I am trying to compile:

   module puppet 1.2;
   require {
           type puppet_t;
           type puppet_exec_t;
           type initrc_t;
           attribute can_change_object_identity;
           class process { transition }; 
   }
   typeattribute puppet_t can_change_object_identity;
   #init_ranged_daemon_domain(puppet_t,puppet_exec_t,s0-s0:c0.c1023); 
   range_transition initrc_t puppet_exec_t:process s0-s0:c0.c1023;
</pre>
      </blockquote>
      <pre wrap=3D"">
Not sure but try spaces here (s0 - s0): range_transition initrc_t puppet=
_exec_t:process s0 - s0:c0.c1023;

</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"">
I feel like I'm close, but perhaps I'm missing how to import  the level =
definitions?</pre>
      </blockquote>
    </blockquote>
    Try this one<br>
    <br>
    policy_module(mypol,1.0)<br>
    <br>
    require{<br>
    =A0type puppet_t;<br>
    =A0type puppet_exec_t;<br>
    }<br>
    <br>
    ifdef(`enable_mcs',`<br>
    =A0=A0=A0 init_ranged_daemon_domain(puppet_t, puppet_exec_t, s0 -
    s0:c0.c1023)<br>
    ')<br>
    =A0=A0=A0 <br>
    <blockquote
      cite=3D"mid:20150313213137.GE9437@linksys-wireless-usb.network2"
      type=3D"cite">
      <blockquote type=3D"cite">
        <pre wrap=3D"">


_______________________________________________
Selinux mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:Selinux@tycho.nsa.g=
ov">Selinux@tycho.nsa.gov</a>
To unsubscribe, send email to <a class=3D"moz-txt-link-abbreviated" href=
=3D"mailto:Selinux-leave@tycho.nsa.gov">Selinux-leave@tycho.nsa.gov</a>.
To get help, send an email containing "help" to <a class=3D"moz-txt-link=
-abbreviated" href=3D"mailto:Selinux-request@tycho.nsa.gov">Selinux-requ=
est@tycho.nsa.gov</a>.
</pre>
      </blockquote>
      <pre wrap=3D"">
</pre>
      <br>
      <fieldset class=3D"mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap=3D"">_______________________________________________
Selinux mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:Selinux@tycho.nsa.g=
ov">Selinux@tycho.nsa.gov</a>
To unsubscribe, send email to <a class=3D"moz-txt-link-abbreviated" href=
=3D"mailto:Selinux-leave@tycho.nsa.gov">Selinux-leave@tycho.nsa.gov</a>.
To get help, send an email containing "help" to <a class=3D"moz-txt-link=
-abbreviated" href=3D"mailto:Selinux-request@tycho.nsa.gov">Selinux-requ=
est@tycho.nsa.gov</a>.</pre>
    </blockquote>
    <br>
  </body>
</html>

--=_Boundary-2884-1426509815-0001-2--
