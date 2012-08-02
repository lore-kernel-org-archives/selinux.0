Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q72A4AOE020956
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2012 06:04:10 -0400
Received: by wibhm11 with SMTP id hm11so3655616wib.12
        for <selinux@tycho.nsa.gov>; Thu, 02 Aug 2012 03:04:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5019E85E.1070402@manicmethod.com>
References: <1343874989-13155-1-git-send-email-method@manicmethod.com>
	<5019E85E.1070402@manicmethod.com>
Date: Thu, 2 Aug 2012 06:04:08 -0400
Message-ID: <CADQgGG3t4OHF9rBGzDjPwm-Cxm_aFvMi1YdmGv6qQZ0rxfA4dQ@mail.gmail.com>
Subject: Re: [PATCH build/] Fix mkyaffs2image call to add a '/' to the mount point
From: Robert Craig <robertpcraig@gmail.com>
To: Joshua Brindle <method@manicmethod.com>
Cc: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>
Content-Type: multipart/alternative; boundary=f46d04428cc847f17b04c64588c4
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d04428cc847f17b04c64588c4
Content-Type: text/plain; charset=ISO-8859-1

There has already been a patch merged with the master branch
(external/yaffs2 bd009e4d493deaf90c38da1cdbaa1db69db073ba).  For now I
would cherry-pick. I'll see what we can do about getting that patch applied
to the other branches as well.



On Wed, Aug 1, 2012 at 10:39 PM, Joshua Brindle <method@manicmethod.com>wrote:

> Note, I have no idea why this just started happening but it is consistent
> on my 4.1.1_r3 checkout. I don't know what the ramifications of changing
> the mountpoint are (e.g., is that used by something other than
> selabel_lookup?) so I haven't submitted it to AOSP.
>
>
> Joshua Brindle wrote:
>
>> From: Joshua Brindle<jbrindle@tresys.com>
>>
>> selabel_lookup requires the mountpoint start with a '/' to match
>> specifications in the file_context file. Change mkyaffs2image call to add a
>> '/' to the mount point argument
>>
>> Change-Id: I255b661822401f9253ef58a2a4bda**da85fc96b23
>>
>> Signed-off-by: Joshua Brindle<jbrindle@tresys.com>
>> ---
>>   tools/releasetools/build_**image.py |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/releasetools/build_**image.py
>> b/tools/releasetools/build_**image.py
>> index a615d1a..610e634 100755
>> --- a/tools/releasetools/build_**image.py
>> +++ b/tools/releasetools/build_**image.py
>> @@ -56,7 +56,7 @@ def BuildImage(in_dir, prop_dict, out_file):
>>       build_command.append(out_file)
>>       if "selinux_fc" in prop_dict:
>>         build_command.append(prop_**dict["selinux_fc"])
>> -      build_command.append(prop_**dict["mount_point"])
>> +      build_command.append("/%s" % prop_dict["mount_point"])
>>
>>     print "Running: ", " ".join(build_command)
>>     p = subprocess.Popen(build_**command);
>>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.govwith
> the words "unsubscribe selinux" without quotes as the message.
>

--f46d04428cc847f17b04c64588c4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>There has already been a patch merged with the master branch (external=
/yaffs2 bd009e4d493deaf90c38da1cdbaa1db69db073ba). =A0For now I would cherr=
y-pick.=A0I&#39;ll see what we can do about getting that patch applied to t=
he other branches as well.</div>
<div><br></div><br><br><div class=3D"gmail_quote">On Wed, Aug 1, 2012 at 10=
:39 PM, Joshua Brindle <span dir=3D"ltr">&lt;<a href=3D"mailto:method@manic=
method.com" target=3D"_blank">method@manicmethod.com</a>&gt;</span> wrote:<=
br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">
Note, I have no idea why this just started happening but it is consistent o=
n my 4.1.1_r3 checkout. I don&#39;t know what the ramifications of changing=
 the mountpoint are (e.g., is that used by something other than selabel_loo=
kup?) so I haven&#39;t submitted it to AOSP.<div class=3D"im HOEnZb">
<br>
<br>
Joshua Brindle wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
From: Joshua Brindle&lt;<a href=3D"mailto:jbrindle@tresys.com" target=3D"_b=
lank">jbrindle@tresys.com</a>&gt;<br>
<br>
selabel_lookup requires the mountpoint start with a &#39;/&#39; to match sp=
ecifications in the file_context file. Change mkyaffs2image call to add a &=
#39;/&#39; to the mount point argument<br>
<br>
Change-Id: I255b661822401f9253ef58a2a4bda<u></u>da85fc96b23<br>
<br>
Signed-off-by: Joshua Brindle&lt;<a href=3D"mailto:jbrindle@tresys.com" tar=
get=3D"_blank">jbrindle@tresys.com</a>&gt;<br>
---<br>
=A0 tools/releasetools/build_<u></u>image.py | =A0 =A02 +-<br>
=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/tools/releasetools/build_<u></u>image.py b/tools/releasetools/=
build_<u></u>image.py<br>
index a615d1a..610e634 100755<br>
--- a/tools/releasetools/build_<u></u>image.py<br>
+++ b/tools/releasetools/build_<u></u>image.py<br>
@@ -56,7 +56,7 @@ def BuildImage(in_dir, prop_dict, out_file):<br>
=A0 =A0 =A0 build_command.append(out_file)<br>
=A0 =A0 =A0 if &quot;selinux_fc&quot; in prop_dict:<br>
=A0 =A0 =A0 =A0 build_command.append(prop_<u></u>dict[&quot;selinux_fc&quot=
;])<br>
- =A0 =A0 =A0build_command.append(prop_<u></u>dict[&quot;mount_point&quot;]=
)<br>
+ =A0 =A0 =A0build_command.append(&quot;/%s&quot; % prop_dict[&quot;mount_p=
oint&quot;])<br>
<br>
=A0 =A0 print &quot;Running: &quot;, &quot; &quot;.join(build_command)<br>
=A0 =A0 p =3D subprocess.Popen(build_<u></u>command);<br>
</blockquote>
<br>
--<br></div><div class=3D"HOEnZb"><div class=3D"h5">
This message was distributed to subscribers of the selinux mailing list.<br=
>
If you no longer wish to subscribe, send mail to <a href=3D"mailto:majordom=
o@tycho.nsa.gov" target=3D"_blank">majordomo@tycho.nsa.gov</a> with<br>
the words &quot;unsubscribe selinux&quot; without quotes as the message.<br=
>
</div></div></blockquote></div><br>

--f46d04428cc847f17b04c64588c4--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
