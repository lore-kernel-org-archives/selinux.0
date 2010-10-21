Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o9LEaj3v025670
	for <selinux@tycho.nsa.gov>; Thu, 21 Oct 2010 10:36:45 -0400
Received: from mail-pv0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o9LEahlH008939
	for <selinux@tycho.nsa.gov>; Thu, 21 Oct 2010 14:36:44 GMT
Received: by pvg2 with SMTP id 2so1134626pvg.12
        for <selinux@tycho.nsa.gov>; Thu, 21 Oct 2010 07:36:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4CC042CD.4000501@gmail.com>
References: <4CBE21ED.4050706@gmail.com>
	<20101020015409.GA19663@hallyn.com>
	<4CBF66AE.5040805@gmail.com>
	<20101021024431.GA25516@hallyn.com>
	<4CBFCC85.60404@gmail.com>
	<AANLkTimR6aJYd-OenPjLhUdz4wJLF+r=hUGhUHVikyyN@mail.gmail.com>
	<4CBFE22A.5040102@gmail.com>
	<AANLkTingRD0+ocKNED5EuHdqOrYdiS__JqtrToK1eWUC@mail.gmail.com>
	<4CC042CD.4000501@gmail.com>
Date: Thu, 21 Oct 2010 19:36:40 +0500
Message-ID: <AANLkTinSFCbxNP9Ps=0rMsgR5idqvdyJ1t_pVUVG5N00@mail.gmail.com>
Subject: Re: load_policy() with upstart on mint 9 fluxbox
From: Shaz <shazalive@gmail.com>
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, selinux@tycho.nsa.gov,
        refpolicy@oss1.tresys.com
Content-Type: multipart/alternative; boundary=000e0cd17b9a4f258e04932174ce
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--000e0cd17b9a4f258e04932174ce
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Oct 21, 2010 at 6:40 PM, Justin P. Mattock
<justinmattock@gmail.com>wrote:

> On 10/21/2010 12:08 AM, Shaz wrote:
>
>>
>>
>> On Thu, Oct 21, 2010 at 11:48 AM, Justin P. Mattock
>> <justinmattock@gmail.com <mailto:justinmattock@gmail.com>> wrote:
>>  > On 10/20/2010 11:26 PM, Shaz wrote:
>>  >>
>>  >> On Thu, Oct 21, 2010 at 10:15 AM, Justin P. Mattock
>>  >> <justinmattock@gmail.com <mailto:justinmattock@gmail.com>>  wrote:
>>
>>  >>>
>>  >>> On 10/20/2010 07:44 PM, Serge E. Hallyn wrote:
>>  >>>>
>>  >>>> Quoting Justin P. Mattock (justinmattock@gmail.com
>> <mailto:justinmattock@gmail.com>):
>>
>>  >>>>>
>>  >>>>> o.k. finally connected the dots that I needed to create a
>> initrd.img
>>  >>>>> in order for this to load(im a total newbie!!)
>>  >>>>>
>>  >>>>> Anyways the policy loads everything went in and am now in full
>>  >>>>> enforcement mode.. only real issue is with lxde
>>  >>>>> same bug here:
>>  >>>>> https://bugzilla.redhat.com/show_bug.cgi?id=552885
>>  >>>>>
>>  >>>>> seems lxde is in /usr/sbin reason probably for the wrong
>> filelabel..
>>  >>>>
>>  >>>> Cool, so does following the steps outlined in that bug make it
>>  >>>> work for you?
>>  >>>>
>>  >>>
>>  >>> What I normally have is /boot/System.map-* and vmlinuz-* to load the
>>  >>> kernel.. Seems sysvinit knows how to take things there and
>> load_policy()
>>  >>>
>>
>>
>>  >>> for upstart whatever it's doing(like what you said) needs to go
>> through
>>  >>> initrd. Yesterday I though thats what I had done with:
>>  >>> fakeroot make-kpkg --initrd --append-to-version=-custom kernel_image
>>  >>> kernel_headers
>>  >>>
>>  >>> but missed one last step:
>>  >>> mkinitramfs -k -o initrd.img-2.6.36-rc8-custom-00022-g2b666ca
>>  >>> then after doing this everything loaded as is..
>>  >>>
>>  >>> Note: guess this is whats being called to do all of this:
>>  >>> /usr/share/initramfs-tools/scripts/init-bottom/_load_selinux_policy
>>  >>>
>>  >>> As for the file labels in /var/run seems most of the files in there
>> are
>>  >>> labeled with initrc_t (keep in mind I chose debian as the distro in
>>  >>> build.conf, so maybe this is why)..
>>  >>>
>>  >>> As for lxde, before using chcon I was getting a login context of
>>  >>> name:staff_r:netutils_t:s0 then after relabeling those files:
>>  >>>
>>  >>> (chcon to this context like the bug report had shown)
>>  >>> system_u:object_r:xdm_exec_t:s0 /usr/sbin/lxdm
>>  >>> system_u:object_r:xdm_exec_t:s0 /usr/sbin/lxdm-binary
>>  >>> system_u:object_r:xdm_var_run_t:s0 lxdm.pid
>>  >>>
>>  >>> I login with the proper context that I chose:
>>  >>> name:staff_r:staff_t:s0
>>  >>>
>>  >>> Right now I think everything is running o.k. on this operating
>> system..
>>  >>> (nice,small, and functional..with a touch of SELinux on top...)
>>  >>
>>  >> Dear Justin,
>>  >>
>>  >> "initrd" helps to load selinux and label "init" so that transitions
>>  >> can take effect. Be it upstart or sysvinit!
>>  >>
>>  >> If this is not done then all your processes will be loaded with
>>  >> unconfined_t. Rest of the details you are considering should not
>>  >> matter and they might be confusing if you tried to load selinux with
>>  >> experimentation rather then proper bootstrap through initrd.
>>  >>
>>  >> Hope this helps.
>>  >>
>>  >
>>  > well my other machines do not use an initrd image file in /boot only
>>  > System.map and vmlinuz(I guess doing make, make install for the
>> kernel is a
>>  > bit outdated these days)..
>>  >
>>  > Anyways sysvinit always loaded the policy just fine and had the
>> processes
>>  > correct, as for upstart seems I needed to do the whole
>>  > make-kpkg,dpkg,mkinitramfs thing..(which is fine... but would rather
>> keep it
>>  > more simpler).
>>
>> AFAIK without initrd your policy will not work properly as labeling is
>> not handled and thus the whole security objective fails. If this is
>> possible without an initrd then it would be init handling it by loading
>> selinux and restarting itself.
>>
>
> pretty much what I use over here..(make bisecting easier since I dont have
> to deal with the hundreds of vmlinuz tags, just one that gets written over)
>
> Now the question(I guess)is, is how/why is upstart not _realizing_ this is
> a system without initrd lets go over here and get the system started?
> (id imagine the code might have if then/else or something..)
>

Why do you expect Upstart or init to know if initrd was used or not? Is this
a feature that upstart should handle? I guess not because initrd is used for
early drivers and configuration before the rootfs can be utilized properly.

-- 
Shahbaz Khan
Assist. R&D Engineer

http://shazkhan.wordpress.com/
http://pk.linkedin.com/pub/shahbaz-khan/20/116/b49
http://imsciences.edu.pk/serg/
http://csrdu.org/

--000e0cd17b9a4f258e04932174ce
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Thu, Oct 21, 2010 at 6:40 PM, Justin =
P. Mattock <span dir=3D"ltr">&lt;<a href=3D"mailto:justinmattock@gmail.com"=
>justinmattock@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmai=
l_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204=
, 204, 204); padding-left: 1ex;">
<div class=3D"im">On 10/21/2010 12:08 AM, Shaz wrote:<br>
</div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex;=
 border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><div class=
=3D"im">
<br>
<br>
On Thu, Oct 21, 2010 at 11:48 AM, Justin P. Mattock<br></div><div class=3D"=
im">
&lt;<a href=3D"mailto:justinmattock@gmail.com" target=3D"_blank">justinmatt=
ock@gmail.com</a> &lt;mailto:<a href=3D"mailto:justinmattock@gmail.com" tar=
get=3D"_blank">justinmattock@gmail.com</a>&gt;&gt; wrote:<br>
=A0&gt; On 10/20/2010 11:26 PM, Shaz wrote:<br>
=A0&gt;&gt;<br>
=A0&gt;&gt; On Thu, Oct 21, 2010 at 10:15 AM, Justin P. Mattock<br></div>
=A0&gt;&gt; &lt;<a href=3D"mailto:justinmattock@gmail.com" target=3D"_blank=
">justinmattock@gmail.com</a> &lt;mailto:<a href=3D"mailto:justinmattock@gm=
ail.com" target=3D"_blank">justinmattock@gmail.com</a>&gt;&gt; =A0wrote:<di=
v class=3D"im">
<br>
=A0&gt;&gt;&gt;<br>
=A0&gt;&gt;&gt; On 10/20/2010 07:44 PM, Serge E. Hallyn wrote:<br>
=A0&gt;&gt;&gt;&gt;<br>
=A0&gt;&gt;&gt;&gt; Quoting Justin P. Mattock (<a href=3D"mailto:justinmatt=
ock@gmail.com" target=3D"_blank">justinmattock@gmail.com</a><br></div>
&lt;mailto:<a href=3D"mailto:justinmattock@gmail.com" target=3D"_blank">jus=
tinmattock@gmail.com</a>&gt;):<div><div></div><div class=3D"h5"><br>
=A0&gt;&gt;&gt;&gt;&gt;<br>
=A0&gt;&gt;&gt;&gt;&gt; o.k. finally connected the dots that I needed to cr=
eate a initrd.img<br>
=A0&gt;&gt;&gt;&gt;&gt; in order for this to load(im a total newbie!!)<br>
=A0&gt;&gt;&gt;&gt;&gt;<br>
=A0&gt;&gt;&gt;&gt;&gt; Anyways the policy loads everything went in and am =
now in full<br>
=A0&gt;&gt;&gt;&gt;&gt; enforcement mode.. only real issue is with lxde<br>
=A0&gt;&gt;&gt;&gt;&gt; same bug here:<br>
=A0&gt;&gt;&gt;&gt;&gt; <a href=3D"https://bugzilla.redhat.com/show_bug.cgi=
?id=3D552885" target=3D"_blank">https://bugzilla.redhat.com/show_bug.cgi?id=
=3D552885</a><br>
=A0&gt;&gt;&gt;&gt;&gt;<br>
=A0&gt;&gt;&gt;&gt;&gt; seems lxde is in /usr/sbin reason probably for the =
wrong filelabel..<br>
=A0&gt;&gt;&gt;&gt;<br>
=A0&gt;&gt;&gt;&gt; Cool, so does following the steps outlined in that bug =
make it<br>
=A0&gt;&gt;&gt;&gt; work for you?<br>
=A0&gt;&gt;&gt;&gt;<br>
=A0&gt;&gt;&gt;<br>
=A0&gt;&gt;&gt; What I normally have is /boot/System.map-* and vmlinuz-* to=
 load the<br>
=A0&gt;&gt;&gt; kernel.. Seems sysvinit knows how to take things there and<=
br>
load_policy()<br>
=A0&gt;&gt;&gt;<br>
<br>
<br>
=A0&gt;&gt;&gt; for upstart whatever it&#39;s doing(like what you said) nee=
ds to go through<br>
=A0&gt;&gt;&gt; initrd. Yesterday I though thats what I had done with:<br>
=A0&gt;&gt;&gt; fakeroot make-kpkg --initrd --append-to-version=3D-custom k=
ernel_image<br>
=A0&gt;&gt;&gt; kernel_headers<br>
=A0&gt;&gt;&gt;<br>
=A0&gt;&gt;&gt; but missed one last step:<br>
=A0&gt;&gt;&gt; mkinitramfs -k -o initrd.img-2.6.36-rc8-custom-00022-g2b666=
ca<br>
=A0&gt;&gt;&gt; then after doing this everything loaded as is..<br>
=A0&gt;&gt;&gt;<br>
=A0&gt;&gt;&gt; Note: guess this is whats being called to do all of this:<b=
r>
=A0&gt;&gt;&gt; /usr/share/initramfs-tools/scripts/init-bottom/_load_selinu=
x_policy<br>
=A0&gt;&gt;&gt;<br>
=A0&gt;&gt;&gt; As for the file labels in /var/run seems most of the files =
in there are<br>
=A0&gt;&gt;&gt; labeled with initrc_t (keep in mind I chose debian as the d=
istro in<br>
=A0&gt;&gt;&gt; build.conf, so maybe this is why)..<br>
=A0&gt;&gt;&gt;<br>
=A0&gt;&gt;&gt; As for lxde, before using chcon I was getting a login conte=
xt of<br>
=A0&gt;&gt;&gt; name:staff_r:netutils_t:s0 then after relabeling those file=
s:<br>
=A0&gt;&gt;&gt;<br>
=A0&gt;&gt;&gt; (chcon to this context like the bug report had shown)<br>
=A0&gt;&gt;&gt; system_u:object_r:xdm_exec_t:s0 /usr/sbin/lxdm<br>
=A0&gt;&gt;&gt; system_u:object_r:xdm_exec_t:s0 /usr/sbin/lxdm-binary<br>
=A0&gt;&gt;&gt; system_u:object_r:xdm_var_run_t:s0 lxdm.pid<br>
=A0&gt;&gt;&gt;<br>
=A0&gt;&gt;&gt; I login with the proper context that I chose:<br>
=A0&gt;&gt;&gt; name:staff_r:staff_t:s0<br>
=A0&gt;&gt;&gt;<br>
=A0&gt;&gt;&gt; Right now I think everything is running o.k. on this operat=
ing system..<br>
=A0&gt;&gt;&gt; (nice,small, and functional..with a touch of SELinux on top=
...)<br>
=A0&gt;&gt;<br>
=A0&gt;&gt; Dear Justin,<br>
=A0&gt;&gt;<br>
=A0&gt;&gt; &quot;initrd&quot; helps to load selinux and label &quot;init&q=
uot; so that transitions<br>
=A0&gt;&gt; can take effect. Be it upstart or sysvinit!<br>
=A0&gt;&gt;<br>
=A0&gt;&gt; If this is not done then all your processes will be loaded with=
<br>
=A0&gt;&gt; unconfined_t. Rest of the details you are considering should no=
t<br>
=A0&gt;&gt; matter and they might be confusing if you tried to load selinux=
 with<br>
=A0&gt;&gt; experimentation rather then proper bootstrap through initrd.<br=
>
=A0&gt;&gt;<br>
=A0&gt;&gt; Hope this helps.<br>
=A0&gt;&gt;<br>
=A0&gt;<br>
=A0&gt; well my other machines do not use an initrd image file in /boot onl=
y<br>
=A0&gt; System.map and vmlinuz(I guess doing make, make install for the<br>
kernel is a<br>
=A0&gt; bit outdated these days)..<br>
=A0&gt;<br>
=A0&gt; Anyways sysvinit always loaded the policy just fine and had the pro=
cesses<br>
=A0&gt; correct, as for upstart seems I needed to do the whole<br>
=A0&gt; make-kpkg,dpkg,mkinitramfs thing..(which is fine... but would rathe=
r<br>
keep it<br>
=A0&gt; more simpler).<br>
<br>
AFAIK without initrd your policy will not work properly as labeling is<br>
not handled and thus the whole security objective fails. If this is<br>
possible without an initrd then it would be init handling it by loading<br>
selinux and restarting itself.<br>
</div></div></blockquote>
<br>
pretty much what I use over here..(make bisecting easier since I dont have =
to deal with the hundreds of vmlinuz tags, just one that gets written over)=
<br>
<br>
Now the question(I guess)is, is how/why is upstart not _realizing_ this is =
a system without initrd lets go over here and get the system started?<br>
(id imagine the code might have if then/else or something..)<font color=3D"=
#888888"></font><br clear=3D"all"></blockquote></div><br>Why do you expect =
Upstart or init to know if initrd was used or not? Is this a feature that u=
pstart should handle? I guess not because initrd is used for early drivers =
and configuration before the rootfs can be utilized properly.<br>
<br>-- <br>Shahbaz Khan<br>Assist. R&amp;D Engineer<br><br><a href=3D"http:=
//shazkhan.wordpress.com/" target=3D"_blank">http://shazkhan.wordpress.com/=
</a><br><a href=3D"http://pk.linkedin.com/pub/shahbaz-khan/20/116/b49" targ=
et=3D"_blank">http://pk.linkedin.com/pub/shahbaz-khan/20/116/b49</a><br>
<a href=3D"http://imsciences.edu.pk/serg/" target=3D"_blank">http://imscien=
ces.edu.pk/serg/</a><br><a href=3D"http://csrdu.org/" target=3D"_blank">htt=
p://csrdu.org/</a><br><br>

--000e0cd17b9a4f258e04932174ce--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
