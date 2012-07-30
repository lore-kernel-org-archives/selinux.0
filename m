Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6UAvk8U013614
	for <selinux@tycho.nsa.gov>; Mon, 30 Jul 2012 06:57:46 -0400
Received: by wibhm11 with SMTP id hm11so1278271wib.12
        for <selinux@tycho.nsa.gov>; Mon, 30 Jul 2012 03:57:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5015C421.10906@manicmethod.com>
References: <CAFftDdqvjCJY+EoxGN+0QcHPVTv7Gzpg8ykDaPVG2-R32TyzqA@mail.gmail.com>
	<50141AB2.8010407@manicmethod.com>
	<CAFftDdq9KyfLNXUfGmpf3ywcV01-Wthfdn-BzVb5iTochUBS-A@mail.gmail.com>
	<CAFftDdoJGaao4wSp-MOx3qXo4p7a0bvmdLxHys8gh-0iNA16dw@mail.gmail.com>
	<CAFftDdrzA1=Xg63cJUSv=LjgGq=S9pN7O2WzcG3sJdT1vviGEw@mail.gmail.com>
	<5015C421.10906@manicmethod.com>
Date: Mon, 30 Jul 2012 06:57:43 -0400
Message-ID: <CADQgGG0sfgZTMUd3ovJHtnJH=D-OgP4H27av5BrxKZOdDRrG0g@mail.gmail.com>
Subject: Re: Mirrors
From: Robert Craig <robertpcraig@gmail.com>
To: Joshua Brindle <method@manicmethod.com>
Cc: William Roberts <bill.c.roberts@gmail.com>, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=00235451e8ee6cc5cf04c609ee0d
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--00235451e8ee6cc5cf04c609ee0d
Content-Type: text/plain; charset=ISO-8859-1

Seems that with a repo sync everything works as expected:

rpcraig@zombie:~/bitbucket-seandroid$ repo sync device-samsung-tuna
Fetching projects: 100% (1/1), done.

However with just using Bill's command, seems to be an issue for me.

rpcraig@zombie:/tmp$ time git clone --mirror
https://bitbucket.org/seandroid/device-samsung-tuna
Cloning into bare repository device-samsung-tuna.git...
remote: Counting objects: 5870, done.
remote: Compressing objects: 100% (3180/3180), done.
fatal: The remote end hung up unexpectedly29 MiB | 1.02 MiB/s
fatal: early EOF
fatal: index-pack failed

real 16m20.657s
user 0m0.000s
sys 0m0.148s



On Sun, Jul 29, 2012 at 7:15 PM, Joshua Brindle <method@manicmethod.com>wrote:

> It is working here:
>
> $ repo sync -j8
> Fetching projects: 100% (386/386), done.
>
>
> William Roberts wrote:
>
>> It looks like repo and tuna are not getting along, with the only thing
>> in the local_manifest.xml file is tuna:
>>
>> git@sta105992:/repo/seandroid$ repo sync -j8
>> remote: Counting objects: 5870, done.
>> remote: Compressing objects: 100% (3180/3180), done.
>> Receiving objects:  95% (5610/5870), 1023.46 MiB | 311 KiB/s
>> 1/5870), 17.44 MiB | 715 KiB/s
>>
>> It is not over a gig....
>>
>> On Sat, Jul 28, 2012 at 3:08 PM, William Roberts
>> <bill.c.roberts@gmail.com>  wrote:
>>
>>> I even tried with -j1 to make sure it wasn't a deadlock in git or the
>>> repo tool and it still would hang. It seems syncing one by one from
>>> the local manifest (even with a high -j option) works fine. Once the
>>> initial mirror sync for master works, ill try it with a full local
>>> manifest and post my results. If it works, then their is some weird
>>> flaw with repo....
>>>
>>> Bill
>>>
>>> On Sat, Jul 28, 2012 at 1:28 PM, William Roberts
>>> <bill.c.roberts@gmail.com>  wrote:
>>>
>>>> That's strange because it worked before with stuff that was outside of
>>>> the normal path, like selinux/libselinux. I definitely thing they
>>>> intended to use name as that matches up with he remote
>>>> and not the local checkout path. I started syncing with the new local
>>>> manifest 1 project at a time and it seems to be working ok. Somewhere
>>>> it just hangs and I haven't thrown repo into a debugger to see why.
>>>>
>>>> Bill
>>>>
>>>> On Sat, Jul 28, 2012 at 10:00 AM, Joshua Brindle<method@manicmethod.com
>>>> **>  wrote:
>>>>
>>>>> William Roberts wrote:
>>>>>
>>>>>> Recently, I used a SE Android mirror.
>>>>>>
>>>>>> After the repository was initialized with --mirror I had a cron job
>>>>>> the updated us every night through script. The script would repo init
>>>>>> (on the appropriate branch) pull the local manifest over .repo and
>>>>>> sync again. This all worked until the projects moved to bitbucket, now
>>>>>> for some reason it dies, it literally hangs checking out the objects.
>>>>>>
>>>>>> I then merged the local manifest project paths and branches into my
>>>>>> manifest to other people in my team can just do a checkout with repo
>>>>>> init -b seandroid (and others)
>>>>>>
>>>>>> Did anyone else have something similar setup and did they have similar
>>>>>> issues? Does anyone possibly know the cause?
>>>>>>
>>>>>
>>>>> I'm doing the same thing. The issue I had was that the bitbucket repos
>>>>> are
>>>>> formatted like "device-moto-wingray" instead of device/moto/wingray so
>>>>> my
>>>>> mirror started checking out new repos and generally changing the
>>>>> directory
>>>>> layout of the mirror. I guess I could have copied everything over to
>>>>> the new
>>>>> locations and updated all the manifests but I found it lazier to "fix"
>>>>> repo,
>>>>> I'm not sure if they intended to do this or not:
>>>>>
>>>>> diff --git a/manifest_xml.py b/manifest_xml.py
>>>>> index a46cf24..a4c56e6 100644
>>>>> --- a/manifest_xml.py
>>>>> +++ b/manifest_xml.py
>>>>> @@ -570,9 +570,9 @@ class XmlManifest(object):
>>>>>         groups.append('default')
>>>>>
>>>>>       if self.IsMirror:
>>>>> -      relpath = None
>>>>> +      #relpath = None
>>>>>         worktree = None
>>>>> -      gitdir = os.path.join(self.topdir, '%s.git' % name)
>>>>> +      gitdir = os.path.join(self.topdir, '%s.git' % path)
>>>>>       else:
>>>>>         worktree = os.path.join(self.topdir, path).replace('\\', '/')
>>>>>         gitdir = os.path.join(self.repodir, 'projects/%s.git' % path)
>>>>>
>>>>
>>>>
>>>> --
>>>> Respectfully,
>>>>
>>>> William C Roberts
>>>>
>>>
>>>
>>> --
>>> Respectfully,
>>>
>>> William C Roberts
>>>
>>
>>
>>
>>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.govwith
> the words "unsubscribe selinux" without quotes as the message.
>

--00235451e8ee6cc5cf04c609ee0d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Seems that with a repo sync everything works as expected:</div><div><d=
iv><br></div><div>rpcraig@zombie:~/bitbucket-seandroid$ repo sync device-sa=
msung-tuna</div><div>Fetching projects: 100% (1/1), done.=A0</div></div><di=
v>
=A0</div><div>However with just using Bill&#39;s command, seems to be an is=
sue for me.</div><div><br></div><div>rpcraig@zombie:/tmp$ time git clone --=
mirror <a href=3D"https://bitbucket.org/seandroid/device-samsung-tuna">http=
s://bitbucket.org/seandroid/device-samsung-tuna</a></div>
<div><div>Cloning into bare repository device-samsung-tuna.git...</div><div=
>remote: Counting objects: 5870, done.</div><div>remote: Compressing object=
s: 100% (3180/3180), done.</div><div>fatal: The remote end hung up unexpect=
edly29 MiB | 1.02 MiB/s =A0=A0</div>
<div>fatal: early EOF</div><div>fatal: index-pack failed</div><div><br></di=
v><div>real<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span=
>16m20.657s</div><div>user<span class=3D"Apple-tab-span" style=3D"white-spa=
ce:pre">	</span>0m0.000s</div>
<div>sys<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0m=
0.148s</div></div><div><br></div><br><br><div class=3D"gmail_quote">On Sun,=
 Jul 29, 2012 at 7:15 PM, Joshua Brindle <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:method@manicmethod.com" target=3D"_blank">method@manicmethod.com</a>&=
gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">It is working here:<br>
<br>
$ repo sync -j8<br>
Fetching projects: 100% (386/386), done.<div class=3D"HOEnZb"><div class=3D=
"h5"><br>
<br>
William Roberts wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
It looks like repo and tuna are not getting along, with the only thing<br>
in the local_manifest.xml file is tuna:<br>
<br>
git@sta105992:/repo/seandroid$ repo sync -j8<br>
remote: Counting objects: 5870, done.<br>
remote: Compressing objects: 100% (3180/3180), done.<br>
Receiving objects: =A095% (5610/5870), 1023.46 MiB | 311 KiB/s<br>
1/5870), 17.44 MiB | 715 KiB/s<br>
<br>
It is not over a gig....<br>
<br>
On Sat, Jul 28, 2012 at 3:08 PM, William Roberts<br>
&lt;<a href=3D"mailto:bill.c.roberts@gmail.com" target=3D"_blank">bill.c.ro=
berts@gmail.com</a>&gt; =A0wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
I even tried with -j1 to make sure it wasn&#39;t a deadlock in git or the<b=
r>
repo tool and it still would hang. It seems syncing one by one from<br>
the local manifest (even with a high -j option) works fine. Once the<br>
initial mirror sync for master works, ill try it with a full local<br>
manifest and post my results. If it works, then their is some weird<br>
flaw with repo....<br>
<br>
Bill<br>
<br>
On Sat, Jul 28, 2012 at 1:28 PM, William Roberts<br>
&lt;<a href=3D"mailto:bill.c.roberts@gmail.com" target=3D"_blank">bill.c.ro=
berts@gmail.com</a>&gt; =A0wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
That&#39;s strange because it worked before with stuff that was outside of<=
br>
the normal path, like selinux/libselinux. I definitely thing they<br>
intended to use name as that matches up with he remote<br>
and not the local checkout path. I started syncing with the new local<br>
manifest 1 project at a time and it seems to be working ok. Somewhere<br>
it just hangs and I haven&#39;t thrown repo into a debugger to see why.<br>
<br>
Bill<br>
<br>
On Sat, Jul 28, 2012 at 10:00 AM, Joshua Brindle&lt;<a href=3D"mailto:metho=
d@manicmethod.com" target=3D"_blank">method@manicmethod.com</a><u></u>&gt; =
=A0wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
William Roberts wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Recently, I used a SE Android mirror.<br>
<br>
After the repository was initialized with --mirror I had a cron job<br>
the updated us every night through script. The script would repo init<br>
(on the appropriate branch) pull the local manifest over .repo and<br>
sync again. This all worked until the projects moved to bitbucket, now<br>
for some reason it dies, it literally hangs checking out the objects.<br>
<br>
I then merged the local manifest project paths and branches into my<br>
manifest to other people in my team can just do a checkout with repo<br>
init -b seandroid (and others)<br>
<br>
Did anyone else have something similar setup and did they have similar<br>
issues? Does anyone possibly know the cause?<br>
</blockquote>
<br>
I&#39;m doing the same thing. The issue I had was that the bitbucket repos =
are<br>
formatted like &quot;device-moto-wingray&quot; instead of device/moto/wingr=
ay so my<br>
mirror started checking out new repos and generally changing the directory<=
br>
layout of the mirror. I guess I could have copied everything over to the ne=
w<br>
locations and updated all the manifests but I found it lazier to &quot;fix&=
quot; repo,<br>
I&#39;m not sure if they intended to do this or not:<br>
<br>
diff --git a/manifest_xml.py b/manifest_xml.py<br>
index a46cf24..a4c56e6 100644<br>
--- a/manifest_xml.py<br>
+++ b/manifest_xml.py<br>
@@ -570,9 +570,9 @@ class XmlManifest(object):<br>
=A0 =A0 =A0 =A0 groups.append(&#39;default&#39;)<br>
<br>
=A0 =A0 =A0 if self.IsMirror:<br>
- =A0 =A0 =A0relpath =3D None<br>
+ =A0 =A0 =A0#relpath =3D None<br>
=A0 =A0 =A0 =A0 worktree =3D None<br>
- =A0 =A0 =A0gitdir =3D os.path.join(self.topdir, &#39;%s.git&#39; % name)<=
br>
+ =A0 =A0 =A0gitdir =3D os.path.join(self.topdir, &#39;%s.git&#39; % path)<=
br>
=A0 =A0 =A0 else:<br>
=A0 =A0 =A0 =A0 worktree =3D os.path.join(self.topdir, path).replace(&#39;\=
\&#39;, &#39;/&#39;)<br>
=A0 =A0 =A0 =A0 gitdir =3D os.path.join(self.repodir, &#39;projects/%s.git&=
#39; % path)<br>
</blockquote>
<br>
<br>
--<br>
Respectfully,<br>
<br>
William C Roberts<br>
</blockquote>
<br>
<br>
--<br>
Respectfully,<br>
<br>
William C Roberts<br>
</blockquote>
<br>
<br>
<br>
</blockquote>
<br>
--<br></div></div><div class=3D"HOEnZb"><div class=3D"h5">
This message was distributed to subscribers of the selinux mailing list.<br=
>
If you no longer wish to subscribe, send mail to <a href=3D"mailto:majordom=
o@tycho.nsa.gov" target=3D"_blank">majordomo@tycho.nsa.gov</a> with<br>
the words &quot;unsubscribe selinux&quot; without quotes as the message.<br=
>
</div></div></blockquote></div><br>

--00235451e8ee6cc5cf04c609ee0d--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
