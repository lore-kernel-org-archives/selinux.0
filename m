MIME-Version: 1.0
Date: Mon, 6 Jan 2014 13:08:28 +0100
Message-ID: <CAOFt0CSftkNgEVBaM3Hr6eb+ygYyd2JoSATTir1=EOQy5+uQmA@mail.gmail.com>
Subject: Allowing all access in SELinux without permissive mode.
From: Kernel freak <kernelfreak@gmail.com>
To: SELinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a11c26b26203ee304ef4c1eda
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11c26b26203ee304ef4c1eda
Content-Type: text/plain; charset=ISO-8859-1

Hello Friends,
                      I am currently working on SELinux and as a part of
it, I need to make some changes to it. Basically, I would like to allow all
access requests, but not by enabling permissive mode. I checked the code
from SELinux/ss/services.c. The 2 main functions that can be helpful are
security_compute_av() and context_struct_compute_av(). The 1st call has the
parameters that I need to make other things work like the ssid, tsid, etc.
But how to allow all access request. I am posting some code for handy
reference. Thank you for your time.

/**

 * security_compute_av - Compute access vector decisions.

 * @ssid: source security identifier

 * @tsid: target security identifier

 * @tclass: target security class

 * @requested: requested permissions

 * @avd: access vector decisions

 *

 * Compute a set of access vector decisions based on the

 * SID pair (@ssid, @tsid) for the permissions in @tclass.

 * Return -%EINVAL if any of the parameters are invalid or %0

 * if the access vector decisions were computed successfully.

 */

int security_compute_av(u32 ssid,

			u32 tsid,

			u16 tclass,

			u32 requested,

			struct av_decision *avd)

{

	struct context *scontext = NULL, *tcontext = NULL;

	int rc = 0;


	if (!ss_initialized) {

		avd->allowed = 0xffffffff;

		avd->auditallow = 0;

		avd->auditdeny = 0xffffffff;

		avd->seqno = latest_granting;

		return 0;

	}


	read_lock(&policy_rwlock);


	scontext = sidtab_search(&sidtab, ssid);

	if (!scontext) {

		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",

		       __func__, ssid);

		rc = -EINVAL;

		goto out;

	}

	tcontext = sidtab_search(&sidtab, tsid);

	if (!tcontext) {

		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",

		       __func__, tsid);

		rc = -EINVAL;

		goto out;

	}


	rc = context_struct_compute_av(scontext, tcontext, tclass,

				       requested, avd);


	/* permissive domain? */

	if (ebitmap_get_bit(&policydb.permissive_map, scontext->type))

	    avd->flags |= AVD_FLAGS_PERMISSIVE;

out:

	read_unlock(&policy_rwlock);

	return rc;

}

--001a11c26b26203ee304ef4c1eda
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello Friends,<br></div>=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 I am currently working on SELinux and =
as a part of it, I need to make some changes to it. Basically, I would like=
 to allow all access requests, but not by enabling permissive mode. I check=
ed the code from SELinux/ss/services.c. The 2 main functions that can be he=
lpful are security_compute_av() and context_struct_compute_av(). The 1st ca=
ll has the parameters that I need to make other things work like the ssid, =
tsid, etc. But how to allow all access request. I am posting some code for =
handy reference. Thank you for your time. <br>
<br><span style=3D"color:rgb(0,0,128)">/**</span>
<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)"> </span><span style=3D"color:rgb(0,0,128)">*</span><span style=3D"col=
or:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,128)">security_co=
mpute_av</span><span style=3D"color:rgb(192,192,192)"> </span><span style=
=3D"color:rgb(0,0,128)">-</span><span style=3D"color:rgb(192,192,192)"> </s=
pan><span style=3D"color:rgb(0,0,128)">Compute</span><span style=3D"color:r=
gb(192,192,192)"> </span><span style=3D"color:rgb(0,0,128)">access</span><s=
pan style=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,1=
28)">vector</span><span style=3D"color:rgb(192,192,192)"> </span><span styl=
e=3D"color:rgb(0,0,128)">decisions.</span></pre>

<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)"> </span><span style=3D"color:rgb(0,0,128)">*</span><span style=3D"col=
or:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,128)">@ssid:</spa=
n><span style=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb(0=
,0,128)">source</span><span style=3D"color:rgb(192,192,192)"> </span><span =
style=3D"color:rgb(0,0,128)">security</span><span style=3D"color:rgb(192,19=
2,192)"> </span><span style=3D"color:rgb(0,0,128)">identifier</span></pre>

<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)"> </span><span style=3D"color:rgb(0,0,128)">*</span><span style=3D"col=
or:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,128)">@tsid:</spa=
n><span style=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb(0=
,0,128)">target</span><span style=3D"color:rgb(192,192,192)"> </span><span =
style=3D"color:rgb(0,0,128)">security</span><span style=3D"color:rgb(192,19=
2,192)"> </span><span style=3D"color:rgb(0,0,128)">identifier</span></pre>

<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)"> </span><span style=3D"color:rgb(0,0,128)">*</span><span style=3D"col=
or:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,128)">@tclass:</s=
pan><span style=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb=
(0,0,128)">target</span><span style=3D"color:rgb(192,192,192)"> </span><spa=
n style=3D"color:rgb(0,0,128)">security</span><span style=3D"color:rgb(192,=
192,192)"> </span><span style=3D"color:rgb(0,0,128)">class</span></pre>

<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)"> </span><span style=3D"color:rgb(0,0,128)">*</span><span style=3D"col=
or:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,128)">@requested:=
</span><span style=3D"color:rgb(192,192,192)"> </span><span style=3D"color:=
rgb(0,0,128)">requested</span><span style=3D"color:rgb(192,192,192)"> </spa=
n><span style=3D"color:rgb(0,0,128)">permissions</span></pre>

<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)"> </span><span style=3D"color:rgb(0,0,128)">*</span><span style=3D"col=
or:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,128)">@avd:</span=
><span style=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,=
0,128)">access</span><span style=3D"color:rgb(192,192,192)"> </span><span s=
tyle=3D"color:rgb(0,0,128)">vector</span><span style=3D"color:rgb(192,192,1=
92)"> </span><span style=3D"color:rgb(0,0,128)">decisions</span></pre>

<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)"> </span><span style=3D"color:rgb(0,0,128)">*</span></pre>
<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)"> </span><span style=3D"color:rgb(0,0,128)">*</span><span style=3D"col=
or:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,128)">Compute</sp=
an><span style=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb(=
0,0,128)">a</span><span style=3D"color:rgb(192,192,192)"> </span><span styl=
e=3D"color:rgb(0,0,128)">set</span><span style=3D"color:rgb(192,192,192)"> =
</span><span style=3D"color:rgb(0,0,128)">of</span><span style=3D"color:rgb=
(192,192,192)"> </span><span style=3D"color:rgb(0,0,128)">access</span><spa=
n style=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,128=
)">vector</span><span style=3D"color:rgb(192,192,192)"> </span><span style=
=3D"color:rgb(0,0,128)">decisions</span><span style=3D"color:rgb(192,192,19=
2)"> </span><span style=3D"color:rgb(0,0,128)">based</span><span style=3D"c=
olor:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,128)">on</span>=
<span style=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0=
,128)">the</span></pre>

<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)"> </span><span style=3D"color:rgb(0,0,128)">*</span><span style=3D"col=
or:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,128)">SID</span><=
span style=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,=
128)">pair</span><span style=3D"color:rgb(192,192,192)"> </span><span style=
=3D"color:rgb(0,0,128)">(@ssid,</span><span style=3D"color:rgb(192,192,192)=
"> </span><span style=3D"color:rgb(0,0,128)">@tsid)</span><span style=3D"co=
lor:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,128)">for</span>=
<span style=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0=
,128)">the</span><span style=3D"color:rgb(192,192,192)"> </span><span style=
=3D"color:rgb(0,0,128)">permissions</span><span style=3D"color:rgb(192,192,=
192)"> </span><span style=3D"color:rgb(0,0,128)">in</span><span style=3D"co=
lor:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,128)">@tclass.</=
span></pre>

<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)"> </span><span style=3D"color:rgb(0,0,128)">*</span><span style=3D"col=
or:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,128)">Return</spa=
n><span style=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb(0=
,0,128)">-%EINVAL</span><span style=3D"color:rgb(192,192,192)"> </span><spa=
n style=3D"color:rgb(0,0,128)">if</span><span style=3D"color:rgb(192,192,19=
2)"> </span><span style=3D"color:rgb(0,0,128)">any</span><span style=3D"col=
or:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,128)">of</span><s=
pan style=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,1=
28)">the</span><span style=3D"color:rgb(192,192,192)"> </span><span style=
=3D"color:rgb(0,0,128)">parameters</span><span style=3D"color:rgb(192,192,1=
92)"> </span><span style=3D"color:rgb(0,0,128)">are</span><span style=3D"co=
lor:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,128)">invalid</s=
pan><span style=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb=
(0,0,128)">or</span><span style=3D"color:rgb(192,192,192)"> </span><span st=
yle=3D"color:rgb(0,0,128)">%0</span></pre>

<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)"> </span><span style=3D"color:rgb(0,0,128)">*</span><span style=3D"col=
or:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,128)">if</span><s=
pan style=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,1=
28)">the</span><span style=3D"color:rgb(192,192,192)"> </span><span style=
=3D"color:rgb(0,0,128)">access</span><span style=3D"color:rgb(192,192,192)"=
> </span><span style=3D"color:rgb(0,0,128)">vector</span><span style=3D"col=
or:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,128)">decisions</=
span><span style=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rg=
b(0,0,128)">were</span><span style=3D"color:rgb(192,192,192)"> </span><span=
 style=3D"color:rgb(0,0,128)">computed</span><span style=3D"color:rgb(192,1=
92,192)"> </span><span style=3D"color:rgb(0,0,128)">successfully.</span></p=
re>

<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)"> </span><span style=3D"color:rgb(0,0,128)">*/</span></pre>
<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(128,128,=
0)">int</span><span style=3D"color:rgb(192,192,192)"> </span><span style=3D=
"color:rgb(0,0,0)">security_compute_av</span><span style=3D"color:rgb(0,0,0=
)">(</span>u32<span style=3D"color:rgb(192,192,192)"> </span><span style=3D=
"color:rgb(0,0,0)">ssid</span><span style=3D"color:rgb(0,0,0)">,</span></pr=
e>

<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)">			</span>u32<span style=3D"color:rgb(192,192,192)"> </span><span sty=
le=3D"color:rgb(0,0,0)">tsid</span><span style=3D"color:rgb(0,0,0)">,</span=
></pre>

<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)">			</span>u16<span style=3D"color:rgb(192,192,192)"> </span><span sty=
le=3D"color:rgb(0,0,0)">tclass</span><span style=3D"color:rgb(0,0,0)">,</sp=
an></pre>

<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)">			</span>u32<span style=3D"color:rgb(192,192,192)"> </span><span sty=
le=3D"color:rgb(0,0,0)">requested</span><span style=3D"color:rgb(0,0,0)">,<=
/span></pre>

<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)">			</span><span style=3D"color:rgb(128,128,0)">struct</span><span sty=
le=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb(128,0,128)">=
av_decision</span><span style=3D"color:rgb(192,192,192)"> </span><span styl=
e=3D"color:rgb(0,0,0)">*</span><span style=3D"color:rgb(0,0,0)">avd</span><=
span style=3D"color:rgb(0,0,0)">)</span></pre>

<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(0,0,0)">=
{</span></pre>
<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)">	</span><span style=3D"color:rgb(128,128,0)">struct</span><span style=
=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb(128,0,128)">co=
ntext</span><span style=3D"color:rgb(192,192,192)"> </span><span style=3D"c=
olor:rgb(0,0,0)">*</span><span style=3D"color:rgb(0,0,0)">scontext</span><s=
pan style=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,0=
)">=3D</span><span style=3D"color:rgb(192,192,192)"> </span>NULL<span style=
=3D"color:rgb(0,0,0)">,</span><span style=3D"color:rgb(192,192,192)"> </spa=
n><span style=3D"color:rgb(0,0,0)">*</span><span style=3D"color:rgb(0,0,0)"=
>tcontext</span><span style=3D"color:rgb(192,192,192)"> </span><span style=
=3D"color:rgb(0,0,0)">=3D</span><span style=3D"color:rgb(192,192,192)"> </s=
pan>NULL<span style=3D"color:rgb(0,0,0)">;</span></pre>

<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)">	</span><span style=3D"color:rgb(128,128,0)">int</span><span style=3D=
"color:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,0)">rc</span>=
<span style=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0=
,0)">=3D</span><span style=3D"color:rgb(192,192,192)"> </span><span style=
=3D"color:rgb(0,0,128)">0</span><span style=3D"color:rgb(0,0,0)">;</span></=
pre>

<pre style=3D"margin:0px;text-indent:0px"><br></pre>
<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)">	</span><span style=3D"color:rgb(128,128,0)">if</span><span style=3D"=
color:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,0)">(!</span>s=
s_initialized<span style=3D"color:rgb(0,0,0)">)</span><span style=3D"color:=
rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,0)">{</span></pre>

<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)">		</span><span style=3D"color:rgb(0,0,0)">avd</span><span style=3D"co=
lor:rgb(0,0,0)">-&gt;</span>allowed<span style=3D"color:rgb(192,192,192)"> =
</span><span style=3D"color:rgb(0,0,0)">=3D</span><span style=3D"color:rgb(=
192,192,192)"> </span><span style=3D"color:rgb(0,0,128)">0xffffffff</span><=
span style=3D"color:rgb(0,0,0)">;</span></pre>

<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)">		</span><span style=3D"color:rgb(0,0,0)">avd</span><span style=3D"co=
lor:rgb(0,0,0)">-&gt;</span>auditallow<span style=3D"color:rgb(192,192,192)=
"> </span><span style=3D"color:rgb(0,0,0)">=3D</span><span style=3D"color:r=
gb(192,192,192)"> </span><span style=3D"color:rgb(0,0,128)">0</span><span s=
tyle=3D"color:rgb(0,0,0)">;</span></pre>

<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)">		</span><span style=3D"color:rgb(0,0,0)">avd</span><span style=3D"co=
lor:rgb(0,0,0)">-&gt;</span>auditdeny<span style=3D"color:rgb(192,192,192)"=
> </span><span style=3D"color:rgb(0,0,0)">=3D</span><span style=3D"color:rg=
b(192,192,192)"> </span><span style=3D"color:rgb(0,0,128)">0xffffffff</span=
><span style=3D"color:rgb(0,0,0)">;</span></pre>

<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)">		</span><span style=3D"color:rgb(0,0,0)">avd</span><span style=3D"co=
lor:rgb(0,0,0)">-&gt;</span>seqno<span style=3D"color:rgb(192,192,192)"> </=
span><span style=3D"color:rgb(0,0,0)">=3D</span><span style=3D"color:rgb(19=
2,192,192)"> </span>latest_granting<span style=3D"color:rgb(0,0,0)">;</span=
></pre>

<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)">		</span><span style=3D"color:rgb(128,128,0)">return</span><span styl=
e=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,128)">0</=
span><span style=3D"color:rgb(0,0,0)">;</span></pre>

<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)">	</span><span style=3D"color:rgb(0,0,0)">}</span></pre>
<pre style=3D"margin:0px;text-indent:0px"><br></pre>
<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)">	</span>read_lock<span style=3D"color:rgb(0,0,0)">(&amp;</span>policy=
_rwlock<span style=3D"color:rgb(0,0,0)">);</span></pre>
<pre style=3D"margin:0px;text-indent:0px"><br></pre>
<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)">	</span><span style=3D"color:rgb(0,0,0)">scontext</span><span style=
=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,0)">=3D</s=
pan><span style=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb=
(0,0,0)">sidtab_search</span><span style=3D"color:rgb(0,0,0)">(&amp;</span>=
<span style=3D"color:rgb(128,0,128)">sidtab</span><span style=3D"color:rgb(=
0,0,0)">,</span><span style=3D"color:rgb(192,192,192)"> </span><span style=
=3D"color:rgb(0,0,0)">ssid</span><span style=3D"color:rgb(0,0,0)">);</span>=
</pre>

<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)">	</span><span style=3D"color:rgb(128,128,0)">if</span><span style=3D"=
color:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,0)">(!</span><=
span style=3D"color:rgb(0,0,0)">scontext</span><span style=3D"color:rgb(0,0=
,0)">)</span><span style=3D"color:rgb(192,192,192)"> </span><span style=3D"=
color:rgb(0,0,0)">{</span></pre>

<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)">		</span>printk<span style=3D"color:rgb(0,0,0)">(</span>KERN_ERR<span=
 style=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,128,0)=
">&quot;SELinux:</span><span style=3D"color:rgb(192,192,192)"> </span><span=
 style=3D"color:rgb(0,128,0)">%s:</span><span style=3D"color:rgb(192,192,19=
2)">  </span><span style=3D"color:rgb(0,128,0)">unrecognized</span><span st=
yle=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,128,0)">S=
ID</span><span style=3D"color:rgb(192,192,192)"> </span><span style=3D"colo=
r:rgb(0,128,0)">%d\n&quot;</span><span style=3D"color:rgb(0,0,0)">,</span><=
/pre>

<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)">		       </span>__func__<span style=3D"color:rgb(0,0,0)">,</span><spa=
n style=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,0)"=
>ssid</span><span style=3D"color:rgb(0,0,0)">);</span></pre>

<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)">		</span><span style=3D"color:rgb(0,0,0)">rc</span><span style=3D"col=
or:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,0)">=3D</span><sp=
an style=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,0)=
">-</span>EINVAL<span style=3D"color:rgb(0,0,0)">;</span></pre>

<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)">		</span><span style=3D"color:rgb(128,128,0)">goto</span><span style=
=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb(128,0,0)">out<=
/span><span style=3D"color:rgb(0,0,0)">;</span></pre>

<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)">	</span><span style=3D"color:rgb(0,0,0)">}</span></pre>
<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)">	</span><span style=3D"color:rgb(0,0,0)">tcontext</span><span style=
=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,0)">=3D</s=
pan><span style=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb=
(0,0,0)">sidtab_search</span><span style=3D"color:rgb(0,0,0)">(&amp;</span>=
<span style=3D"color:rgb(128,0,128)">sidtab</span><span style=3D"color:rgb(=
0,0,0)">,</span><span style=3D"color:rgb(192,192,192)"> </span><span style=
=3D"color:rgb(0,0,0)">tsid</span><span style=3D"color:rgb(0,0,0)">);</span>=
</pre>

<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)">	</span><span style=3D"color:rgb(128,128,0)">if</span><span style=3D"=
color:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,0)">(!</span><=
span style=3D"color:rgb(0,0,0)">tcontext</span><span style=3D"color:rgb(0,0=
,0)">)</span><span style=3D"color:rgb(192,192,192)"> </span><span style=3D"=
color:rgb(0,0,0)">{</span></pre>

<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)">		</span>printk<span style=3D"color:rgb(0,0,0)">(</span>KERN_ERR<span=
 style=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,128,0)=
">&quot;SELinux:</span><span style=3D"color:rgb(192,192,192)"> </span><span=
 style=3D"color:rgb(0,128,0)">%s:</span><span style=3D"color:rgb(192,192,19=
2)">  </span><span style=3D"color:rgb(0,128,0)">unrecognized</span><span st=
yle=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,128,0)">S=
ID</span><span style=3D"color:rgb(192,192,192)"> </span><span style=3D"colo=
r:rgb(0,128,0)">%d\n&quot;</span><span style=3D"color:rgb(0,0,0)">,</span><=
/pre>

<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)">		       </span>__func__<span style=3D"color:rgb(0,0,0)">,</span><spa=
n style=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,0)"=
>tsid</span><span style=3D"color:rgb(0,0,0)">);</span></pre>

<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)">		</span><span style=3D"color:rgb(0,0,0)">rc</span><span style=3D"col=
or:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,0)">=3D</span><sp=
an style=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,0)=
">-</span>EINVAL<span style=3D"color:rgb(0,0,0)">;</span></pre>

<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)">		</span><span style=3D"color:rgb(128,128,0)">goto</span><span style=
=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb(128,0,0)">out<=
/span><span style=3D"color:rgb(0,0,0)">;</span></pre>

<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)">	</span><span style=3D"color:rgb(0,0,0)">}</span></pre>
<pre style=3D"margin:0px;text-indent:0px"><br></pre>
<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)">	</span><span style=3D"color:rgb(0,0,0)">rc</span><span style=3D"colo=
r:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,0)">=3D</span><spa=
n style=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,0)"=
>context_struct_compute_av</span><span style=3D"color:rgb(0,0,0)">(</span><=
span style=3D"color:rgb(0,0,0)">scontext</span><span style=3D"color:rgb(0,0=
,0)">,</span><span style=3D"color:rgb(192,192,192)"> </span><span style=3D"=
color:rgb(0,0,0)">tcontext</span><span style=3D"color:rgb(0,0,0)">,</span><=
span style=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,=
0)">tclass</span><span style=3D"color:rgb(0,0,0)">,</span></pre>

<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)">				       </span><span style=3D"color:rgb(0,0,0)">requested</span><s=
pan style=3D"color:rgb(0,0,0)">,</span><span style=3D"color:rgb(192,192,192=
)"> </span><span style=3D"color:rgb(0,0,0)">avd</span><span style=3D"color:=
rgb(0,0,0)">);</span></pre>

<pre style=3D"margin:0px;text-indent:0px"><br></pre>
<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)">	</span><span style=3D"color:rgb(0,128,0)">/*</span><span style=3D"co=
lor:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,128,0)">permissive=
</span><span style=3D"color:rgb(192,192,192)"> </span><span style=3D"color:=
rgb(0,128,0)">domain?</span><span style=3D"color:rgb(192,192,192)"> </span>=
<span style=3D"color:rgb(0,128,0)">*/</span></pre>

<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)">	</span><span style=3D"color:rgb(128,128,0)">if</span><span style=3D"=
color:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,0)">(</span><s=
pan style=3D"color:rgb(0,0,0)">ebitmap_get_bit</span><span style=3D"color:r=
gb(0,0,0)">(&amp;</span><span style=3D"color:rgb(128,0,128)">policydb</span=
><span style=3D"color:rgb(0,0,0)">.</span><span style=3D"color:rgb(128,0,0)=
">permissive_map</span><span style=3D"color:rgb(0,0,0)">,</span><span style=
=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,0)">sconte=
xt</span><span style=3D"color:rgb(0,0,0)">-&gt;</span><span style=3D"color:=
rgb(128,0,0)">type</span><span style=3D"color:rgb(0,0,0)">))</span></pre>

<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)">	    </span><span style=3D"color:rgb(0,0,0)">avd</span><span style=3D=
"color:rgb(0,0,0)">-&gt;</span>flags<span style=3D"color:rgb(192,192,192)">=
 </span><span style=3D"color:rgb(0,0,0)">|=3D</span><span style=3D"color:rg=
b(192,192,192)"> </span>AVD_FLAGS_PERMISSIVE<span style=3D"color:rgb(0,0,0)=
">;</span></pre>

<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(128,0,0)=
">out</span><span style=3D"color:rgb(0,0,0)">:</span></pre>
<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)">	</span>read_unlock<span style=3D"color:rgb(0,0,0)">(&amp;</span>poli=
cy_rwlock<span style=3D"color:rgb(0,0,0)">);</span></pre>
<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)">	</span><span style=3D"color:rgb(128,128,0)">return</span><span style=
=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,0)">rc</sp=
an><span style=3D"color:rgb(0,0,0)">;</span></pre>

<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(0,0,0)">=
}</span></pre><br></div>

--001a11c26b26203ee304ef4c1eda--
