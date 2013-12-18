MIME-Version: 1.0
In-Reply-To: <CACVacMu4EvcdZzLVbBRFUvgg_RA0Mc7awZ0x_mzoxadmO6TSkw@mail.gmail.com>
References: <CACVacMuiN=2GPxdHpCSToAEUJNmMwn1nE+hg-xqywO0crwdDNA@mail.gmail.com>
 <52B07D69.70209@tycho.nsa.gov>
 <CACVacMvNNP3HLAEW_RhzuHxqUvq77nmApstS5V_xKoEG1zbZkA@mail.gmail.com>
 <52B094C0.7080107@tycho.nsa.gov>
 <CACVacMu4EvcdZzLVbBRFUvgg_RA0Mc7awZ0x_mzoxadmO6TSkw@mail.gmail.com>
Date: Wed, 18 Dec 2013 07:32:58 -0800
Message-ID: <CACVacMtV2+QbQiGvQRoDu3HaVd7p45BJFU01E7jKMdbJH06K1g@mail.gmail.com>
Subject: Re: /bin/bash: Bad interpreter: Permission denied.
From: Jay Corrales <jscorrales1122@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a11c347e073c91d04edd0c2c3
Cc: SELinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11c347e073c91d04edd0c2c3
Content-Type: text/plain; charset=ISO-8859-1

Folks,

We think we've run into a bug with rhel5. Could be that the policy database
contains corruption, or contains some data structures that lead to buggy
results (e.g. AVC execute_no_trans). Is there a way to see additional debug
info in the LSM during run time? I've tried adding "debug" to the boot time
kernel parameters, but does not add any new logging or reporting info for
selinux.

Thanks

On Tue, Dec 17, 2013 at 2:51 PM, Jay Corrales <jscorrales1122@gmail.com>wrote:

> lx_apps_script_exec_t is how it is in the lab. awips_exec_t is the reduced
> example posted.
>
> On Tue, Dec 17, 2013 at 10:15 AM, Stephen Smalley <sds@tycho.nsa.gov>wrote:
>
>> On 12/17/2013 01:03 PM, Jay Corrales wrote:
>> > type=AVC msg=audit(1387301151.195:82549): avc: denied {
>> execute_no_trans }
>> > for pid=24492 comm="bash" path="/awips/fxa/bin/test.sh" dev=sda2
>> ino=800003
>> > scontext=user_u:user_r:user_t:s0
>> > tcontext=system_u:object_r:lx_apps_script_exec_t:s0 tclass=file
>>
>> I don't understand how to correlate this to the policy you listed.
>> The tcontext above has the script labeled with lx_apps_script_exec_t,
>> while your policy had it as awips_exec_t.
>>
>> Also, as a side note, domain transition on a shell script is
>> fundamentally unsafe unless the caller is strictly more trusted than the
>> callee.  Only suitable when the caller is trusted.  Use a binary
>> executable for any situation where the caller is untrusted.
>>
>

--001a11c347e073c91d04edd0c2c3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Folks,</div>
<div>=A0</div>
<div>We think we&#39;ve run into a bug with rhel5. Could be that the policy=
 database contains corruption, or contains some data structures that lead t=
o buggy results (e.g. AVC execute_no_trans). Is there a way to see addition=
al debug info in the LSM during run time? I&#39;ve tried adding &quot;debug=
&quot; to the boot time kernel parameters, but does not add any=A0new loggi=
ng or reporting info for selinux.</div>

<div>=A0</div>
<div>Thanks<br><br></div>
<div class=3D"gmail_quote">On Tue, Dec 17, 2013 at 2:51 PM, Jay Corrales <s=
pan dir=3D"ltr">&lt;<a href=3D"mailto:jscorrales1122@gmail.com" target=3D"_=
blank">jscorrales1122@gmail.com</a>&gt;</span> wrote:<br>
<blockquote style=3D"BORDER-LEFT:#ccc 1px solid;MARGIN:0px 0px 0px 0.8ex;PA=
DDING-LEFT:1ex" class=3D"gmail_quote">lx_apps_script_exec_t is how it is in=
 the lab. awips_exec_t is the reduced example posted. <br>
<div class=3D"HOEnZb">
<div class=3D"h5"><br>
<div class=3D"gmail_quote">On Tue, Dec 17, 2013 at 10:15 AM, Stephen Smalle=
y <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_bla=
nk">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br>
<blockquote style=3D"BORDER-LEFT:#ccc 1px solid;MARGIN:0px 0px 0px 0.8ex;PA=
DDING-LEFT:1ex" class=3D"gmail_quote">
<div>On 12/17/2013 01:03 PM, Jay Corrales wrote:<br>&gt; type=3DAVC msg=3Da=
udit(1387301151.195:82549): avc: denied { execute_no_trans }<br>&gt; for pi=
d=3D24492 comm=3D&quot;bash&quot; path=3D&quot;/awips/fxa/bin/test.sh&quot;=
 dev=3Dsda2 ino=3D800003<br>
&gt; scontext=3Duser_u:user_r:user_t:s0<br>&gt; tcontext=3Dsystem_u:object_=
r:lx_apps_script_exec_t:s0 tclass=3Dfile<br><br></div>I don&#39;t understan=
d how to correlate this to the policy you listed.<br>The tcontext above has=
 the script labeled with lx_apps_script_exec_t,<br>
while your policy had it as awips_exec_t.<br><br>Also, as a side note, doma=
in transition on a shell script is<br>fundamentally unsafe unless the calle=
r is strictly more trusted than the<br>callee. =A0Only suitable when the ca=
ller is trusted. =A0Use a binary<br>
executable for any situation where the caller is untrusted.<br></blockquote=
></div></div></div></blockquote></div><br>

--001a11c347e073c91d04edd0c2c3--
