Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3SMkuKA023751
	for <selinux@tycho.nsa.gov>; Mon, 28 Apr 2008 18:46:56 -0400
Received: from ug-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m3SMkr9Q008447
	for <selinux@tycho.nsa.gov>; Mon, 28 Apr 2008 22:46:54 GMT
Received: by ug-out-1314.google.com with SMTP id 30so1018062ugs.15
        for <selinux@tycho.nsa.gov>; Mon, 28 Apr 2008 15:46:51 -0700 (PDT)
Message-ID: <cadfc0e40804281546n188882c2w2c84241878f2d7ef@mail.gmail.com>
Date: Mon, 28 Apr 2008 17:46:50 -0500
From: "Xavier Toth" <txtoth@gmail.com>
To: "Eamon Walsh" <ewalsh@tycho.nsa.gov>
Subject: Re: copy/paste policy patch
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        "SE Linux" <selinux@tycho.nsa.gov>
In-Reply-To: <4816523B.4030905@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_10964_23508078.1209422811011"
References: <cadfc0e40804250607q6e6542ecmc1fa3d1e78a84cb8@mail.gmail.com>
	 <1209386863.30483.44.camel@gorn.columbia.tresys.com>
	 <4816523B.4030905@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_10964_23508078.1209422811011
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, Apr 28, 2008 at 5:39 PM, Eamon Walsh <ewalsh@tycho.nsa.gov> wrote:

> Christopher J. PeBenito wrote:
>
>> On Fri, 2008-04-25 at 08:07 -0500, Xavier Toth wrote:
>>
>>
>>> Here's a patch I'm using with an MLS version of glipper to give the
>>> capability to check for dominance between copy and paste data
>>> contexts. Hopefully some version of this can be upstreamed.
>>>
>>>
>>
> Here is a revised patch.  I support including this in refpolicy as it's
> generally useful for supporting selection managers.
>
> Note that the access_vectors definition is at the end of the file in this
> patch.  Not sure if the ordering matters in that file, if it doesn't you can
> move this to coincide with the other X classes.
>
> Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
> ---
>
>
> Index: policy/flask/security_classes
> ===================================================================
> --- policy/flask/security_classes       (revision 2667)
> +++ policy/flask/security_classes       (working copy)
> @@ -114,5 +114,6 @@
> class x_resource                # userspace
> class x_event                   # userspace
> class x_synthetic_event         # userspace
> +class x_application_data       # userspace
>
> # FLASK
> Index: policy/flask/access_vectors
> ===================================================================
> --- policy/flask/access_vectors (revision 2667)
> +++ policy/flask/access_vectors (working copy)
> @@ -775,3 +775,10 @@
> {
>        recv
> }
> +
> +class x_application_data
> +{
> +       paste
> +       paste_after_confirm
> +       copy
> +}
> Index: policy/mls
> ===================================================================
> --- policy/mls  (revision 2667)
> +++ policy/mls  (working copy)
> @@ -568,7 +568,13 @@
>         ( t1 == mlsxwinwrite ));
>
>
> +#
> +# MLS policy for the x_application_data class
> +#
> +mlsconstrain x_application_data { paste }
> +       ( l1 domby l2 );
>
> +
> #
> # MLS policy for the pax class
> #
>
>
>
> --
> Eamon Walsh <ewalsh@tycho.nsa.gov>
> National Security Agency
>

Seems to me that paste mlsconstrain should be (l1 eq l2) and should be a
mlsconstrain for paste_after_confirm which is (l1 domby l2).

------=_Part_10964_23508078.1209422811011
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div class="gmail_quote">On Mon, Apr 28, 2008 at 5:39 PM, Eamon Walsh &lt;<a href="mailto:ewalsh@tycho.nsa.gov">ewalsh@tycho.nsa.gov</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">Christopher J. PeBenito wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Fri, 2008-04-25 at 08:07 -0500, Xavier Toth wrote:<br>
 &nbsp;<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Here&#39;s a patch I&#39;m using with an MLS version of glipper to give the<br>
capability to check for dominance between copy and paste data<br>
contexts. Hopefully some version of this can be upstreamed.<br>
 &nbsp; &nbsp;<br>
</blockquote></blockquote>
<br></div>
Here is a revised patch. &nbsp;I support including this in refpolicy as it&#39;s generally useful for supporting selection managers.<br>
<br>
Note that the access_vectors definition is at the end of the file in this patch. &nbsp;Not sure if the ordering matters in that file, if it doesn&#39;t you can move this to coincide with the other X classes.<br>
<br>
Signed-off-by: Eamon Walsh &lt;<a href="mailto:ewalsh@tycho.nsa.gov" target="_blank">ewalsh@tycho.nsa.gov</a>&gt;<br>
---<br>
<br>
<br>
Index: policy/flask/security_classes<br>
===================================================================<br>
--- policy/flask/security_classes &nbsp; &nbsp; &nbsp; (revision 2667)<br>
+++ policy/flask/security_classes &nbsp; &nbsp; &nbsp; (working copy)<div class="Ih2E3d"><br>
@@ -114,5 +114,6 @@<br>
class x_resource &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;# userspace<br>
class x_event &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; # userspace<br>
class x_synthetic_event &nbsp; &nbsp; &nbsp; &nbsp; # userspace<br>
+class x_application_data &nbsp; &nbsp; &nbsp; # userspace<br>
<br>
# FLASK<br></div>
Index: policy/flask/access_vectors<br>
===================================================================<br>
--- policy/flask/access_vectors (revision 2667)<br>
+++ policy/flask/access_vectors (working copy)<br>
@@ -775,3 +775,10 @@<div class="Ih2E3d"><br>
{<br>
 &nbsp; &nbsp; &nbsp; &nbsp;recv<br>
}<br>
+<br>
+class x_application_data<br>
+{<br>
+ &nbsp; &nbsp; &nbsp; paste<br></div>
+ &nbsp; &nbsp; &nbsp; paste_after_confirm<br>
+ &nbsp; &nbsp; &nbsp; copy<br>
+}<br>
Index: policy/mls<br>
===================================================================<br>
--- policy/mls &nbsp;(revision 2667)<br>
+++ policy/mls &nbsp;(working copy)<br>
@@ -568,7 +568,13 @@<div class="Ih2E3d"><br>
 &nbsp; &nbsp; &nbsp; &nbsp; ( t1 == mlsxwinwrite ));<br>
<br>
<br>
+#<br>
+# MLS policy for the x_application_data class<br>
+#<br>
+mlsconstrain x_application_data { paste }<br></div><div class="Ih2E3d">
+ &nbsp; &nbsp; &nbsp; ( l1 domby l2 );<br>
<br>
+<br>
#<br>
# MLS policy for the pax class<br></div><div><div></div><div class="Wj3C7c">
#<br>
<br>
<br>
<br>
-- <br>
Eamon Walsh &lt;<a href="mailto:ewalsh@tycho.nsa.gov" target="_blank">ewalsh@tycho.nsa.gov</a>&gt;<br>
National Security Agency<br>
</div></div></blockquote><div>&nbsp;</div></div>Seems to me that paste mlsconstrain should be (l1 eq l2) and should be a mlsconstrain for paste_after_confirm which is (l1 domby l2).<br>

------=_Part_10964_23508078.1209422811011--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
