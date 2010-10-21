Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o9L78aql028236
	for <selinux@tycho.nsa.gov>; Thu, 21 Oct 2010 03:08:36 -0400
Received: from mail-gx0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o9L78YGl014498
	for <selinux@tycho.nsa.gov>; Thu, 21 Oct 2010 07:08:35 GMT
Received: by gxk24 with SMTP id 24so2763544gxk.12
        for <selinux@tycho.nsa.gov>; Thu, 21 Oct 2010 00:08:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4CBFE22A.5040102@gmail.com>
References: <4CBE21ED.4050706@gmail.com>
	<20101020015409.GA19663@hallyn.com>
	<4CBF66AE.5040805@gmail.com>
	<20101021024431.GA25516@hallyn.com>
	<4CBFCC85.60404@gmail.com>
	<AANLkTimR6aJYd-OenPjLhUdz4wJLF+r=hUGhUHVikyyN@mail.gmail.com>
	<4CBFE22A.5040102@gmail.com>
Date: Thu, 21 Oct 2010 12:08:32 +0500
Message-ID: <AANLkTingRD0+ocKNED5EuHdqOrYdiS__JqtrToK1eWUC@mail.gmail.com>
Subject: Re: load_policy() with upstart on mint 9 fluxbox
From: Shaz <shazalive@gmail.com>
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, selinux@tycho.nsa.gov,
        refpolicy@oss1.tresys.com
Content-Type: multipart/alternative; boundary=20cf304353e29d0df904931b3180
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--20cf304353e29d0df904931b3180
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Oct 21, 2010 at 11:48 AM, Justin P. Mattock <justinmattock@gmail.com>
wrote:
> On 10/20/2010 11:26 PM, Shaz wrote:
>>
>> On Thu, Oct 21, 2010 at 10:15 AM, Justin P. Mattock
>> <justinmattock@gmail.com>  wrote:
>>>
>>> On 10/20/2010 07:44 PM, Serge E. Hallyn wrote:
>>>>
>>>> Quoting Justin P. Mattock (justinmattock@gmail.com):
>>>>>
>>>>> o.k. finally connected the dots that I needed to create a initrd.img
>>>>> in order for this to load(im a total newbie!!)
>>>>>
>>>>> Anyways the policy loads everything went in and am now in full
>>>>> enforcement mode.. only real issue is with lxde
>>>>> same bug here:
>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=552885
>>>>>
>>>>> seems lxde is in /usr/sbin reason probably for the wrong filelabel..
>>>>
>>>> Cool, so does following the steps outlined in that bug make it
>>>> work for you?
>>>>
>>>
>>> What I normally have is /boot/System.map-* and vmlinuz-* to load the
>>> kernel.. Seems sysvinit knows how to take things there and load_policy()
>>>


>>> for upstart whatever it's doing(like what you said) needs to go through
>>> initrd. Yesterday I though thats what I had done with:
>>> fakeroot make-kpkg --initrd --append-to-version=-custom kernel_image
>>> kernel_headers
>>>
>>> but missed one last step:
>>> mkinitramfs -k -o initrd.img-2.6.36-rc8-custom-00022-g2b666ca
>>> then after doing this everything loaded as is..
>>>
>>> Note: guess this is whats being called to do all of this:
>>> /usr/share/initramfs-tools/scripts/init-bottom/_load_selinux_policy
>>>
>>> As for the file labels in /var/run seems most of the files in there are
>>> labeled with initrc_t (keep in mind I chose debian as the distro in
>>> build.conf, so maybe this is why)..
>>>
>>> As for lxde, before using chcon I was getting a login context of
>>> name:staff_r:netutils_t:s0 then after relabeling those files:
>>>
>>> (chcon to this context like the bug report had shown)
>>> system_u:object_r:xdm_exec_t:s0 /usr/sbin/lxdm
>>> system_u:object_r:xdm_exec_t:s0 /usr/sbin/lxdm-binary
>>> system_u:object_r:xdm_var_run_t:s0 lxdm.pid
>>>
>>> I login with the proper context that I chose:
>>> name:staff_r:staff_t:s0
>>>
>>> Right now I think everything is running o.k. on this operating system..
>>> (nice,small, and functional..with a touch of SELinux on top...)
>>
>> Dear Justin,
>>
>> "initrd" helps to load selinux and label "init" so that transitions
>> can take effect. Be it upstart or sysvinit!
>>
>> If this is not done then all your processes will be loaded with
>> unconfined_t. Rest of the details you are considering should not
>> matter and they might be confusing if you tried to load selinux with
>> experimentation rather then proper bootstrap through initrd.
>>
>> Hope this helps.
>>
>
> well my other machines do not use an initrd image file in /boot only
> System.map and vmlinuz(I guess doing make, make install for the kernel is
a
> bit outdated these days)..
>
> Anyways sysvinit always loaded the policy just fine and had the processes
> correct, as for upstart seems I needed to do the whole
> make-kpkg,dpkg,mkinitramfs thing..(which is fine... but would rather keep
it
> more simpler).

AFAIK without initrd your policy will not work properly as labeling is not
handled and thus the whole security objective fails. If this is possible
without an initrd then it would be init handling it by loading selinux and
restarting itself.

>
> Justin P. Mattock
>

Thanks.

-- 
Shahbaz Khan
Assit. R&D Engineer

http://shazkhan.wordpress.com/
http://pk.linkedin.com/pub/shahbaz-khan/20/116/b49
http://imsciences.edu.pk/serg/
http://csrdu.org/

--20cf304353e29d0df904931b3180
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br>On Thu, Oct 21, 2010 at 11:48 AM, Justin P. Mattock &lt;<a href=3D"=
mailto:justinmattock@gmail.com">justinmattock@gmail.com</a>&gt; wrote:<br>&=
gt; On 10/20/2010 11:26 PM, Shaz wrote:<br>&gt;&gt;<br>&gt;&gt; On Thu, Oct=
 21, 2010 at 10:15 AM, Justin P. Mattock<br>
&gt;&gt; &lt;<a href=3D"mailto:justinmattock@gmail.com">justinmattock@gmail=
.com</a>&gt; =A0wrote:<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; On 10/20/2010 07:44 =
PM, Serge E. Hallyn wrote:<br>&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt; Quoting =
Justin P. Mattock (<a href=3D"mailto:justinmattock@gmail.com">justinmattock=
@gmail.com</a>):<br>
&gt;&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt;&gt; o.k. finally connected the dot=
s that I needed to create a initrd.img<br>&gt;&gt;&gt;&gt;&gt; in order for=
 this to load(im a total newbie!!)<br>&gt;&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&=
gt;&gt; Anyways the policy loads everything went in and am now in full<br>
&gt;&gt;&gt;&gt;&gt; enforcement mode.. only real issue is with lxde<br>&gt=
;&gt;&gt;&gt;&gt; same bug here:<br>&gt;&gt;&gt;&gt;&gt; <a href=3D"https:/=
/bugzilla.redhat.com/show_bug.cgi?id=3D552885">https://bugzilla.redhat.com/=
show_bug.cgi?id=3D552885</a><br>
&gt;&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt;&gt; seems lxde is in /usr/sbin rea=
son probably for the wrong filelabel..<br>&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;&=
gt; Cool, so does following the steps outlined in that bug make it<br>&gt;&=
gt;&gt;&gt; work for you?<br>
&gt;&gt;&gt;&gt;<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; What I normally have is /b=
oot/System.map-* and vmlinuz-* to load the<br>&gt;&gt;&gt; kernel.. Seems s=
ysvinit knows how to take things there and load_policy()<br>&gt;&gt;&gt;<br=
>
<br><br>&gt;&gt;&gt; for upstart whatever it&#39;s doing(like what you said=
) needs to go through<br>&gt;&gt;&gt; initrd. Yesterday I though thats what=
 I had done with:<br>&gt;&gt;&gt; fakeroot make-kpkg --initrd --append-to-v=
ersion=3D-custom kernel_image<br>
&gt;&gt;&gt; kernel_headers<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; but missed one =
last step:<br>&gt;&gt;&gt; mkinitramfs -k -o initrd.img-2.6.36-rc8-custom-0=
0022-g2b666ca<br>&gt;&gt;&gt; then after doing this everything loaded as is=
..<br>
&gt;&gt;&gt;<br>&gt;&gt;&gt; Note: guess this is whats being called to do a=
ll of this:<br>&gt;&gt;&gt; /usr/share/initramfs-tools/scripts/init-bottom/=
_load_selinux_policy<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; As for the file labels=
 in /var/run seems most of the files in there are<br>
&gt;&gt;&gt; labeled with initrc_t (keep in mind I chose debian as the dist=
ro in<br>&gt;&gt;&gt; build.conf, so maybe this is why)..<br>&gt;&gt;&gt;<b=
r>&gt;&gt;&gt; As for lxde, before using chcon I was getting a login contex=
t of<br>
&gt;&gt;&gt; name:staff_r:netutils_t:s0 then after relabeling those files:<=
br>&gt;&gt;&gt;<br>&gt;&gt;&gt; (chcon to this context like the bug report =
had shown)<br>&gt;&gt;&gt; system_u:object_r:xdm_exec_t:s0 /usr/sbin/lxdm<b=
r>
&gt;&gt;&gt; system_u:object_r:xdm_exec_t:s0 /usr/sbin/lxdm-binary<br>&gt;&=
gt;&gt; system_u:object_r:xdm_var_run_t:s0 lxdm.pid<br>&gt;&gt;&gt;<br>&gt;=
&gt;&gt; I login with the proper context that I chose:<br>&gt;&gt;&gt; name=
:staff_r:staff_t:s0<br>
&gt;&gt;&gt;<br>&gt;&gt;&gt; Right now I think everything is running o.k. o=
n this operating system..<br>&gt;&gt;&gt; (nice,small, and functional..with=
 a touch of SELinux on top...)<br>&gt;&gt;<br>&gt;&gt; Dear Justin,<br>
&gt;&gt;<br>&gt;&gt; &quot;initrd&quot; helps to load selinux and label &qu=
ot;init&quot; so that transitions<br>&gt;&gt; can take effect. Be it upstar=
t or sysvinit!<br>&gt;&gt;<br>&gt;&gt; If this is not done then all your pr=
ocesses will be loaded with<br>
&gt;&gt; unconfined_t. Rest of the details you are considering should not<b=
r>&gt;&gt; matter and they might be confusing if you tried to load selinux =
with<br>&gt;&gt; experimentation rather then proper bootstrap through initr=
d.<br>
&gt;&gt;<br>&gt;&gt; Hope this helps.<br>&gt;&gt;<br>&gt;<br>&gt; well my o=
ther machines do not use an initrd image file in /boot only<br>&gt; System.=
map and vmlinuz(I guess doing make, make install for the kernel is a<br>
&gt; bit outdated these days)..<br>&gt;<br>&gt; Anyways sysvinit always loa=
ded the policy just fine and had the processes<br>&gt; correct, as for upst=
art seems I needed to do the whole<br>&gt; make-kpkg,dpkg,mkinitramfs thing=
..(which is fine... but would rather keep it<br>
&gt; more simpler).<br><br>AFAIK without initrd your policy will not work p=
roperly as labeling is not handled and thus the whole security objective fa=
ils. If this is possible without an initrd then it would be init handling i=
t by loading selinux and restarting itself.<br>
<br>&gt;<br>&gt; Justin P. Mattock<br>&gt;<br><br>Thanks.<br><br>-- <br>Sha=
hbaz Khan<br>Assit. R&amp;D Engineer<br><br><a href=3D"http://shazkhan.word=
press.com/">http://shazkhan.wordpress.com/</a><br><a href=3D"http://pk.link=
edin.com/pub/shahbaz-khan/20/116/b49">http://pk.linkedin.com/pub/shahbaz-kh=
an/20/116/b49</a><br>
<a href=3D"http://imsciences.edu.pk/serg/">http://imsciences.edu.pk/serg/</=
a><br><a href=3D"http://csrdu.org/">http://csrdu.org/</a><br><br><br><br>

--20cf304353e29d0df904931b3180--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
