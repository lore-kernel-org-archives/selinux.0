MIME-Version: 1.0
Date: Fri, 14 Sep 2012 17:09:37 -0700
Message-ID: <CAFftDdrK8sR=HuHxryryzDjfFOSz_GBsLusPrdsGqXe79YVsYA@mail.gmail.com>
Subject: clean up in android.c
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=20cf307c9fd82136b904c9b25b1a
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--20cf307c9fd82136b904c9b25b1a
Content-Type: text/plain; charset=ISO-8859-1

Would anyone object to me cleaning up the setcon and setfilecon2 code that
does the mls level stuff:

Currently the below code is duplicated:

pw = getpwuid(uid);
if (!pw)
goto err;
username = pw->pw_name;

if (!strncmp(username, "app_", 4)) {
id = strtoul(username + 4, NULL, 10);
if (id >= MLS_CATS)
goto err;
} else if (username[0] == 'u' && isdigit(username[1])) {
unsigned long unused;
unused = strtoul(username+1, &end, 10);
if (end[0] != '_')
goto err;
id = strtoul(end + 2, NULL, 10);
if (id >= MLS_CATS/2)
goto err;
if (end[1] == 'i')
id += MLS_CATS/2;
else if (end[1] != 'a')
goto err;
/* use app_ for matching on the user= field */
username = "app_";
}

I want to break it up into two functions.

1. that gets the normalized username
2. that computes the id, takes username, returns -1 on error


This way of the username stuff changes again in the future, we can
normalize it one spot. The one that computes the id doesn't gain much by
putting it in a function, but I think it will make the code more readable.

-- 
Respectfully,

William C Roberts

--20cf307c9fd82136b904c9b25b1a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Would anyone object to me cleaning up the setcon and setfilecon2 code that =
does the mls level stuff:<div><br></div><div>Currently the below code is du=
plicated:</div><div><br></div><div><div><span class=3D"Apple-tab-span" styl=
e=3D"white-space:pre">	</span>pw =3D getpwuid(uid);</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>if (!=
pw)</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</=
span>goto err;</div><div><span class=3D"Apple-tab-span" style=3D"white-spac=
e:pre">	</span>username =3D pw-&gt;pw_name;</div>
<div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre=
">	</span>if (!strncmp(username, &quot;app_&quot;, 4)) {</div><div><span cl=
ass=3D"Apple-tab-span" style=3D"white-space:pre">		</span>id =3D strtoul(us=
ername + 4, NULL, 10);</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>if (=
id &gt;=3D MLS_CATS)</div><div><span class=3D"Apple-tab-span" style=3D"whit=
e-space:pre">			</span>goto err;</div><div><span class=3D"Apple-tab-span" s=
tyle=3D"white-space:pre">	</span>} else if (username[0] =3D=3D &#39;u&#39; =
&amp;&amp; isdigit(username[1])) {</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>unsi=
gned long unused;</div><div><span class=3D"Apple-tab-span" style=3D"white-s=
pace:pre">		</span>unused =3D strtoul(username+1, &amp;end, 10);</div><div>=
<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>if (end[0=
] !=3D &#39;_&#39;)</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>got=
o err;</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
	</span>id =3D strtoul(end + 2, NULL, 10);</div><div><span class=3D"Apple-t=
ab-span" style=3D"white-space:pre">		</span>if (id &gt;=3D MLS_CATS/2)</div=
>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>got=
o err;</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
	</span>if (end[1] =3D=3D &#39;i&#39;)</div><div><span class=3D"Apple-tab-s=
pan" style=3D"white-space:pre">			</span>id +=3D MLS_CATS/2;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>else=
 if (end[1] !=3D &#39;a&#39;)</div><div><span class=3D"Apple-tab-span" styl=
e=3D"white-space:pre">			</span>goto err;</div><div><span class=3D"Apple-ta=
b-span" style=3D"white-space:pre">		</span>/* use app_ for matching on the =
user=3D field */</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>user=
name =3D &quot;app_&quot;;</div><div><span class=3D"Apple-tab-span" style=
=3D"white-space:pre">	</span>}</div></div><div><br></div><div>I want to bre=
ak it up into two functions.</div>
<div><br></div><div>1. that gets the normalized username</div><div>2. that =
computes the id, takes username, returns -1 on error</div><div><br></div><d=
iv><div><br></div><div>This way of the username stuff changes again in the =
future, we can normalize it one spot. The one that computes the id doesn&#3=
9;t gain much by putting it in a function, but I think it will make the cod=
e more readable.</div>
<div><br></div>-- <br>Respectfully,<br><br>William C Roberts<br><br><br>
</div>

--20cf307c9fd82136b904c9b25b1a--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
